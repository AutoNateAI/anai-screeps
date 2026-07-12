# AutoNateAI Screeps Learning Repo

This repo is the local learning workspace for building Screeps skill across four tracks:

- Screeps player
- Screeps developer
- AI collaborator
- Tournament organizer

The first milestone is intentionally small: run a local Screeps private server, connect the Steam client, and document what we learn as we work through the competencies.

## Local Server

The local server config lives in `screeps-server/config.yml`.

Start it with:

```sh
docker run --platform linux/arm64 -d \
  --restart=unless-stopped \
  --name autonate-screeps \
  --env-file .env \
  -v "$PWD/screeps-server:/screeps" \
  -p 21025:21025 \
  screepers/screeps-launcher:main
```

The launcher requires `STEAM_KEY` in `.env`. See `docs/local-screeps.md`.

Open `http://localhost:21025`, then add `localhost:21025` as a custom server in the Steam Screeps client.

See `docs/local-screeps.md` for the current workflow notes.
