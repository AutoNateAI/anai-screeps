# Local Screeps Setup

## Current Setup

- Machine: Apple Silicon Mac
- Docker architecture: `aarch64`
- Container name: `autonate-screeps`
- Local URL: `http://localhost:21025`
- Steam client custom server: `localhost:21025`
- Local onboarding UI: `http://localhost:21025/local/`
- Default Steam-client mapped user: `autonate`

## Local Auth Mode

The stock Docker launcher expects Steam auth during backend startup. For this learning repo, we patch the generated backend to skip Steam startup and use `screepsmod-auth` username/password auth.

Add this local-only flag to `.env`:

```sh
SCREEPS_LOCAL_PASSWORD_AUTH_ONLY=1
SCREEPS_LOCAL_DEFAULT_USER=autonate
```

Apply the patch after dependencies exist:

```sh
node scripts/patch-local-screeps-auth.js
```

If `node_modules` is regenerated under `screeps-server/`, rerun the patch script.

The `steamKey: local-dev-placeholder` config value is only there to satisfy the Docker entrypoint's preflight check. The local patch makes `SCREEPS_LOCAL_PASSWORD_AUTH_ONLY=1` take precedence so the backend does not use that placeholder for Steam authentication.

The Steam client still calls `/api/auth/steam-ticket` when connecting to a private server. In local-only mode that endpoint is patched to issue a token for `SCREEPS_LOCAL_DEFAULT_USER`, so the client can enter the world without a Steam Web API key.

The supported Steam path can still be used by removing local-only mode and setting a real `STEAM_KEY`, but it is not required for this local learning server.

## What Was Patched

The repeatable patch script is:

```sh
node scripts/patch-local-screeps-auth.js
```

It patches generated files under `screeps-server/node_modules/`:

- `@screeps/backend/lib/game/server.js`: skips Steam/greenworks startup when `SCREEPS_LOCAL_PASSWORD_AUTH_ONLY=1`.
- `@screeps/backend/lib/game/api/auth.js`: maps the Steam client's `/api/auth/steam-ticket` call to `SCREEPS_LOCAL_DEFAULT_USER`.
- `screepsmod-auth/lib/backend.js`: hides Steam auth from auth metadata and local menus.

Because these are generated dependency files, rerun the patch whenever `screeps-server/node_modules/` is regenerated.

## Server Config

The first boot stays minimal so server, auth, and client connection issues are easy to isolate:

```yaml
pinnedPackages:
  ssri: 8.0.1
  cacache: 15.3.0
  passport-steam: 1.0.17
  minipass-fetch: 2.1.2
  express-rate-limit: 6.7.0

steamKey: local-dev-placeholder

mods:
  - screepsmod-auth
  - screepsmod-admin-utils

serverConfig:
  tickRate: 1000
```

Bots can be added after the base loop works.

## Commands

First detached run:

```sh
docker run --platform linux/arm64 -d \
  --restart=unless-stopped \
  --name autonate-screeps \
  --env-file .env \
  -v "$PWD/screeps-server:/screeps" \
  -p 21025:21025 \
  screepers/screeps-launcher:main
```

If `autonate-screeps` already exists after a failed first run, remove it before recreating:

```sh
docker stop autonate-screeps
docker rm autonate-screeps
```

Follow logs:

```sh
docker logs -f autonate-screeps
```

Stop:

```sh
docker stop autonate-screeps
```

Restart detached after the first successful boot:

```sh
docker start autonate-screeps
```

If the container needs to be rebuilt:

```sh
docker stop autonate-screeps
docker rm autonate-screeps
```

Then rerun the foreground command.

## Account Setup

After the server starts, open the local onboarding page:

```text
http://localhost:21025/local/
```

Use it to create profiles and review existing local profiles.

Current first profile:

```text
Username: autonate
Password: 1234
```

The Steam client connection is mapped to `SCREEPS_LOCAL_DEFAULT_USER=autonate`, so the client may not ask for this password during the private-server ticket flow. The password is still useful for API/password-auth flows.

The same registration can be done through the local registration API:

```sh
curl -X POST http://localhost:21025/api/register/submit \
  -H 'Content-Type: application/json' \
  -d '{
    "username": "autonate",
    "email": "autonate@local",
    "password": "choose-a-local-password"
  }'
```

Expected result:

```json
{"ok":1}
```

Then open the Steam Screeps: World client, add `localhost:21025` as a custom/private server, and connect.

Use these private-server connection settings:

```text
Host: localhost
Port: 21025
Server password: blank
```

Do not put the profile password in the server password field. `Server password` only applies if we set `SERVER_PASSWORD` in `.env`, which we have not done.

The older password helper page is still available at:

```text
http://localhost:21025/authmod/password/
```

For this local-only setup, the direct registration API is the cleaner first-account path.

## Sparring Ground Mod

`screeps-server/mods/sparring-ground.js` is a custom local mod (same pattern as `local-onboarding.js` and `screeps-launcher-cli.js` in the same folder — the launcher auto-loads every file under `mods/`, no `config.yml` entry needed). It adds one HTTP endpoint so combat tutorials can trigger a real NPC invasion repeatedly, entirely offline, without clicking through the client's Invasion panel each time:

```sh
curl -X POST http://localhost:21025/local/api/sparring/wave \
  -H 'Content-Type: application/json' \
  -d '{"room": "W6N3"}'
```

Swap in your actual room name. This forces the target room's invasion counters to look already-due, then runs the engine's own `genInvaders` cronjob — the same mechanism a server admin would trigger by hand from the CLI (`docker exec -it autonate-screeps screeps-launcher cli`, then `storage.db.rooms.update(...)` and `system.runCronjob('genInvaders')`). It doesn't fabricate a creep document; it asks the real engine to spawn one, so the result should be a normal, correctly-formed invader.

Two things worth knowing before relying on this in a tutorial session:

- It only produces an invader if the target room still has at least one exit into a neutral, unclaimed room — same restriction the automatic energy-triggered invasion has. If every neighboring room is claimed or reserved (see Episode 8), pick a different exit or test against an earlier checkpoint.
- This composes documented private-server CLI commands rather than a first-party API, so if a future engine update changes how `invaderGoal`/`genInvaders` behave, this could stop working. The guaranteed fallback is always the client's own Invasion panel: room side panel > Invasion tab > Create an invader > click an exit tile.

Health check:

```sh
curl http://localhost:21025/local/api/sparring/health
```

Expected result: `{"ok":1,"message":"sparring-ground mod is loaded"}`.

## Notes

- `.env` stays local because it contains Airtable credentials.
- Runtime files generated under `screeps-server/` are ignored except for `config.yml` and everything under `screeps-server/mods/`.
- The saved planning conversation is in `input_convos/chatgpt/convo_000.md`.

## Dashboard Counters

The dashboard is provided by `screepsmod-admin-utils`.

On a fresh local world, the dashboard can show existing owned rooms and creeps before the `autonate` player has placed a spawn. These counts come from all controller/creep objects with a `user` field, including seeded NPC/system users such as invaders/source keepers/capture bot state.

Use `/stats` to inspect the aggregate server counters:

```sh
curl http://localhost:21025/stats
```

The player-specific part is the `users` array. If `users` is empty, the dashboard-owned rooms and creeps are not player progress for `autonate` yet.

## First Play Session

After connecting in the Screeps: World client:

1. Choose an unowned room.
2. Place your first spawn.
3. Name it something simple, such as `Spawn1`.
4. Use the in-game tutorial prompts for the first harvesting and spawning loop.
5. Record what happened in the learning notes before changing server configuration.

Keep the first bot simple: harvest, transfer, spawn replacement workers, then upgrade the controller.
