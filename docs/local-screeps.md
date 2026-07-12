# Local Screeps Setup

## Current Setup

- Machine: Apple Silicon Mac
- Docker architecture: `aarch64`
- Container name: `autonate-screeps`
- Local URL: `http://localhost:21025`
- Steam client custom server: `localhost:21025`

## Server Config

The first boot stays minimal so server, auth, and client connection issues are easy to isolate:

```yaml
pinnedPackages:
  ssri: 8.0.1
  cacache: 15.3.0
  passport-steam: 1.0.17
  minipass-fetch: 2.1.2
  express-rate-limit: 6.7.0

mods:
  - screepsmod-auth
  - screepsmod-admin-utils

serverConfig:
  tickRate: 1000
```

Bots can be added after the base loop works.

## Commands

First foreground run:

```sh
docker run --restart=unless-stopped \
  --name autonate-screeps \
  -v "$PWD/screeps-server:/screeps" \
  -p 21025:21025 \
  screepers/screeps-launcher:main
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

## Notes

- `.env` stays local because it contains Airtable credentials.
- Runtime files generated under `screeps-server/` are ignored except for `config.yml`.
- The saved planning conversation is in `input_convos/chatgpt/convo_000.md`.
