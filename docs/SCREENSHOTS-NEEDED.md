# Screenshots Needed

A checklist of every screenshot placeholder in the docs, in reading order. Each one is marked inline with `📸 **Screenshot placeholder:**` at the exact spot in the file — search for that marker to find where to drop the image in.

Not sourced from the community here: no tool in this environment can browse and download real screenshots, and redistributing other players' captures without permission is a real copyright problem regardless. These are either your own captures from this repo's local server, or images you have explicit rights to use.

## Checklist

- [ ] `docs/story/00-prologue.md` — a fresh, unclaimed room: terrain, two sources, unowned controller, nothing built.
- [ ] `docs/world-orientation.md` — a labeled/annotated room showing spawn, sources, controller, and terrain together.
- [ ] `docs/tutorials/01-first-spawn-and-harvester.md` — `Spawn1` freshly placed, before any creep exists.
- [ ] `docs/tutorials/02-target-selection.md` — two harvesters stacked on one source, one visibly waiting.
- [ ] `docs/tutorials/03-roles.md` — the controller's progress bar visibly filling.
- [ ] `docs/tutorials/04-controller-upgrading.md` — five completed extensions around `Spawn1`, capacity UI visible.
- [ ] `docs/tutorials/05-construction-and-roads.md` — a road mid-construction between spawn and a source, container visible.
- [ ] `docs/tutorials/06-haulers-and-static-mining.md` — a miner motionless on a container tile, container energy climbing.
- [ ] `docs/tutorials/07-defense.md` — a tower's attack beam connecting with a test invader.
- [ ] `docs/tutorials/08-expansion.md` — a remote room's map view with the reservation banner visible.
- [ ] `docs/tutorials/09-cpu-and-memory.md` — the console log panel showing a run of CPU/bucket lines.
- [ ] `docs/tutorials/11-scouting.md` — the map view showing your colony and an NPC bot's claimed room side by side.
- [ ] `docs/tutorials/12-pvp-fundamentals.md` — a defender and an invader mid-fight, health bars visible.
- [ ] `docs/tutorials/13-sparring-ground.md` — the terminal mid-loop with wave responses logged.
- [ ] `docs/tutorials/14-running-the-league.md` — a contestant's colony mid-benchmark, tower firing, terminal log in frame.

Episode 10 (AI Collaboration) has no placeholder — nothing in it is a Screeps-client visual moment, it's a workflow episode.

## Format Notes

Once you have a real image, replace the placeholder blockquote with standard markdown image syntax:

```markdown
![Five completed extensions around Spawn1](../images/04-extensions.png)
```

Suggested convention: store images under `docs/images/`, named `<file-number>-<short-description>.png`, so they sort alongside the episode they belong to. Delete the corresponding line from this checklist once an image is placed.
