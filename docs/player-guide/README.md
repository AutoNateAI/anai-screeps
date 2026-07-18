# Screeps Player Guide (Free)

No program, no login, no curriculum required. This is the practical, no-fluff version. If you've got this repo, Docker, and about twenty minutes, you can be playing Screeps today and genuinely competitive inside a couple of weeks.

This guide is pulled straight out of the same technical bones as `docs/tutorials/` — every pattern in here is real, tested code and mechanics, just stripped of the story and reordered for speed. If you want the narrative version (AutoNate, the Foundry, fourteen episodes of it), that's over in `docs/tutorials/`. If you just want to play and get good, you're in the right place.

## What's Here

1. `01-quickstart.md` — server up, room claimed, first creep working. About 15 minutes.
2. `02-core-loop-and-roles.md` — the actual code patterns: role modules, population-based spawning, source assignment. Copy-paste ready.
3. `03-infrastructure-and-scaling.md` — roads, containers, CPU/memory discipline, going from one room to two.
4. `04-combat-and-competing.md` — defense, the real combat math, and how to test against actual NPCs on this local server.
5. `05-cheatsheet.md` — error codes, constants, and API calls you'll look up constantly for the first month.

## Before You Start

You need the local server running. Full setup is in `docs/local-screeps.md` — short version:

```sh
docker run --platform linux/arm64 -d \
  --restart=unless-stopped \
  --name autonate-screeps \
  --env-file .env \
  -v "$PWD/screeps-server:/screeps" \
  -p 21025:21025 \
  screepers/screeps-launcher:main
```

Then point the Screeps: World client (or a browser at `http://localhost:21025`) at `localhost:21025`.

No third-party account, no waitlist, no credit card. Go.

## How to Use This

Each file is a reference, not a story — read top to bottom the first time, then come back and jump straight to whatever section you need. Code blocks are meant to be copied into your own `main.js` and role files and adapted, not admired.

If you want the deeper "why" behind any pattern here — why source assignment works this way, why the hauler split from the harvester, why CPU caching matters — the matching episode in `docs/tutorials/` covers it in full, with checkpoints and troubleshooting. This guide assumes you just want the answer.
