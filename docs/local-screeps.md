# Local Screeps Setup

## Current Setup

- Machine: Apple Silicon Mac
- Docker architecture: `aarch64`
- Container name: `autonate-screeps`
- Local URL: `http://localhost:21025`
- Steam client custom server: `localhost:21025`

## Local Auth Mode

The stock Docker launcher expects Steam auth during backend startup. For this learning repo, we patch the generated backend to skip Steam startup and use `screepsmod-auth` username/password auth.

Add this local-only flag to `.env`:

```sh
SCREEPS_LOCAL_PASSWORD_AUTH_ONLY=1
```

Apply the patch after dependencies exist:

```sh
node scripts/patch-local-screeps-auth.js
```

If `node_modules` is regenerated under `screeps-server/`, rerun the patch script.

The `steamKey: local-dev-placeholder` config value is only there to satisfy the Docker entrypoint's preflight check. The local patch makes `SCREEPS_LOCAL_PASSWORD_AUTH_ONLY=1` take precedence so the backend does not use that placeholder for Steam authentication.

The supported Steam path can still be used by removing local-only mode and setting a real `STEAM_KEY`, but it is not required for this local learning server.

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

Then open the Steam Screeps: World client, add `localhost:21025` as a custom/private server, and log in with that local username and password.

The older password helper page is still available at:

```text
http://localhost:21025/authmod/password/
```

For this local-only setup, the direct registration API is the cleaner first-account path.

## Notes

- `.env` stays local because it contains Airtable credentials.
- Runtime files generated under `screeps-server/` are ignored except for `config.yml`.
- The saved planning conversation is in `input_convos/chatgpt/convo_000.md`.
