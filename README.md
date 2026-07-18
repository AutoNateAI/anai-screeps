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

This repo uses a documented local-only auth patch so the server can run without a Steam Web API key. See `docs/local-screeps.md`.

Open `http://localhost:21025`, then add `localhost:21025` as a custom server in the Steam Screeps client.

Use the local onboarding UI to create or choose profiles:

```text
http://localhost:21025/local/
```

The current local Steam-client mapping is:

```text
SCREEPS_LOCAL_DEFAULT_USER=autonate
```

See `docs/local-screeps.md` for the current workflow notes.

## Offline Screeps Docs

Official Screeps docs can be mirrored locally under `local-reference/`, which is ignored by Git.

Serve the mirrored docs with:

```sh
cd local-reference/screeps-docs-official/docs.screeps.com
python3 -m http.server 8080
```

Then open:

- Guide: `http://localhost:8080/`
- API reference: `http://localhost:8080/api/`

If the mirror is missing, refresh it while online:

```sh
wget --mirror --page-requisites --convert-links --adjust-extension --no-parent --domains docs.screeps.com --directory-prefix local-reference/screeps-docs-official https://docs.screeps.com/
```

## Offline Video Study

Use [docs/offline-video-study.md](docs/offline-video-study.md) for the local `/Users/autonate/tapes/` audit and the authorized offline-study archive workflow.

## Orientation

- `docs/world-orientation.md`

## Player Guide (Free, No Program Required)

Just want to play and get competitive, no narrative or curriculum attached? Start at `docs/player-guide/README.md` — the same tested code and mechanics as the tutorials below, stripped down to a fast reference.

## The Story

Every tutorial is an episode in AutoNate's run through the Foundry.

- `docs/story/00-prologue.md` — how AutoNate got here
- `docs/story/bible.md` — characters, factions, and terms
- `docs/roadmap.md` — the full season, episode by episode

## Tutorials

The full season is written — see `docs/roadmap.md` for loglines and arc groupings. In order:

1. `docs/tutorials/01-first-spawn-and-harvester.md` — Touchdown
2. `docs/tutorials/02-target-selection.md` — Two Sources, One Colony
3. `docs/tutorials/03-roles.md` — Job Descriptions
4. `docs/tutorials/04-controller-upgrading.md` — The Controller's Price
5. `docs/tutorials/05-construction-and-roads.md` — Paved Roads
6. `docs/tutorials/06-haulers-and-static-mining.md` — Haulers and Miners
7. `docs/tutorials/07-defense.md` — Under Siege
8. `docs/tutorials/08-expansion.md` — Beyond the Border
9. `docs/tutorials/09-cpu-and-memory.md` — The Weight of Memory
10. `docs/tutorials/10-ai-collaboration.md` — Two Minds
11. `docs/tutorials/11-scouting.md` — Scouting the Dark
12. `docs/tutorials/12-pvp-fundamentals.md` — The First Skirmish
13. `docs/tutorials/13-sparring-ground.md` — The Sparring Ground
14. `docs/tutorials/14-running-the-league.md` — Open the Gates

## League

- `league/README.md` — submission structure used by Episode 14
- `league/scoring-rubric.md` — the rubric template for scoring a match

## Journal

- `docs/journal/TEMPLATE.md` — copy this for your own debugging-session entries (Episode 10)

## Diagrams and Screenshots

Every episode, the orientation doc, and the player guide now include Mermaid diagrams for the strategy/architecture concepts (renders natively on GitHub). Screenshot spots are marked inline with 📸 placeholders — see `docs/SCREENSHOTS-NEEDED.md` for the full checklist and where to drop real images in.
