# Tutorial 05: Construction and Roads

*Episode 5: Paved Roads*

"Watch your harvesters," your collaborator says. "Really watch them. Count how many ticks they spend just walking."

You watch. It's more than you expected — basically a calendar full of meetings that could've been an email. Every trip from source to spawn crosses the same dozen tiles, over and over, at full terrain cost, forever.

"Roads don't make a creep smarter," it says. "They make the same creep faster, permanently, for a one-time cost. That's the best trade this game offers you — infrastructure spend that actually pays itself back, unlike half the tools on your company card."

## Goal

Turn the builder role from "finishes whatever's placed" into a colony that plans its own infrastructure:

- Plan and place roads along the harvester-to-spawn route
- Place containers next to each source, ahead of when you'll need them
- Confirm the builder role from Episode 4 needs zero code changes to handle either

## Prerequisites

Tutorial 04 is complete:

- The room is RCL2 or higher.
- `role.builder.js` exists and completes construction sites it finds via `FIND_CONSTRUCTION_SITES`.
- At least one extension has been built and `energyCapacityAvailable` is above `300`.

## Step 1: Confirm the Builder Doesn't Care What It's Building

Look back at `role.builder.js`. The build logic is:

```js
const target = creep.pos.findClosestByPath(FIND_CONSTRUCTION_SITES);
```

`FIND_CONSTRUCTION_SITES` returns every construction site in the room — extensions, roads, containers, anything. The builder was never extension-specific. That was deliberate scope discipline in Episode 4: write the general case once, and every future structure type is free.

You will not touch `role.builder.js` in this tutorial. That's the checkpoint for Step 1 — if you find yourself editing it, stop and reconsider.

## Step 2: Plan a Road from Spawn to Each Source

In the console, define a helper and run it once per source:

```js
function planRoadsTo(room, targetPos) {
  const spawn = Game.spawns.Spawn1;
  const path = room.findPath(spawn.pos, targetPos, { ignoreCreeps: true, swampCost: 2 });
  for (const step of path) {
    room.createConstructionSite(step.x, step.y, STRUCTURE_ROAD);
  }
}

const room = Game.spawns.Spawn1.room;
const sources = room.find(FIND_SOURCES);
sources.forEach((source) => planRoadsTo(room, source.pos));
```

`room.findPath` runs the same pathfinding a creep would use, so the road you place is the road your creeps were already walking — not a guess at one.

Checkpoint:

```js
Game.spawns.Spawn1.room.find(FIND_CONSTRUCTION_SITES, { filter: { structureType: STRUCTURE_ROAD } }).length
```

Expected result: a number roughly equal to the combined length of both paths. Some tiles may fail to place (`-7`, usually because a creep or existing structure occupies that tile at the exact moment you ran the command) — that's fine, rerun the loop later to fill gaps.

## Step 3: Place Containers Next to Each Source

Containers don't need extra RCL beyond what you already have — they're allowed at any controller level, up to 5 per room. Pick an open tile adjacent to each source. Coordinates will differ per room; check terrain first if you're unsure:

```js
const room = Game.spawns.Spawn1.room;
const sources = room.find(FIND_SOURCES);

sources.forEach((source) => {
  const x = source.pos.x + 1;
  const y = source.pos.y;
  room.createConstructionSite(x, y, STRUCTURE_CONTAINER);
});
```

If `x + 1` lands on a wall, adjust to `x - 1`, `y + 1`, or `y - 1` for that source. Check with:

```js
Game.spawns.Spawn1.room.getTerrain().get(x, y)
```

Checkpoint:

```js
Game.spawns.Spawn1.room.find(FIND_CONSTRUCTION_SITES, { filter: { structureType: STRUCTURE_CONTAINER } }).length
```

Expected result: `2` (one per source, assuming a two-source room).

These containers won't be used by any role yet. That's expected — they're infrastructure ahead of the need. Episode 6 is what makes them matter.

## Step 4: Let the Colony Build Itself

Do nothing. Watch.

Checkpoint (over the following minutes of ticks):

- The builder alternates between harvesting and walking to whichever construction site is closest.
- Roads complete first near the spawn, since they're along the builder's own travel path.
- The construction site count trends toward zero as `FIND_MY_STRUCTURES` grows.

```js
Game.spawns.Spawn1.room.find(FIND_CONSTRUCTION_SITES).length
```

## Step 5: Measure the Payoff

Once at least the road segment nearest the spawn is complete, compare a harvester's travel time before and after. A rough measurement:

```js
Game.creeps.harvester12345.memory.role
```

(swap in an actual harvester name from `Game.creeps`)

There's no single command that proves "this creep is faster now" — the honest way to see it is to watch the client. Roads cost `1` movement point per step instead of `2` on plains or `10` on swamp. A creep with one `MOVE` part moves at half speed on unpaved plains and full speed on a road.

## Troubleshooting

If `findPath` returns an empty array, `spawn.pos` and `targetPos` may already be adjacent, or something is blocking every route. Try without `ignoreCreeps: true` removed to see if a creep is the obstruction.

If construction sites disappear without becoming structures, you likely hit the per-room construction site cap (100 total across all types). Check:

```js
Game.spawns.Spawn1.room.find(FIND_CONSTRUCTION_SITES).length
Game.spawns.Spawn1.room.find(FIND_MY_STRUCTURES).length
```

If the builder ignores roads/containers entirely and only ever walks to extensions, re-check that you didn't add a `structureType` filter into `role.builder.js` at some point — the whole point of this episode is that you shouldn't have needed to.

## Completion Criteria

You are done when:

- At least one road segment between `Spawn1` and a source is fully built.
- A container exists (built or under construction) next to each source.
- `role.builder.js` is unmodified from Episode 4.
- The construction site count is trending down without manual intervention.

## Learning Notes

After completing the tutorial, write down:

- How many total tiles did `findPath` place roads on, for each source?
- What would happen to the colony's building priorities if you placed 20 more extension sites right now, all at once? Would the builder finish the road first or the closest extension first?
- Containers exist but nothing uses them yet. What's the risk of building infrastructure before the code that depends on it?
- Roads decay over time in the real game. Nothing in this episode's code handles repair. What role do you think should own that job?

## Next: Episode 6 — Haulers and Miners

The containers sitting by each source are about to stop being decoration.

"Right now your harvester still walks the source-to-spawn round trip every single time it's full," your collaborator says. "A creep with more `WORK` parts could just stand on that source and never move again — if something else picks up what it drops. That's the whole pitch for a logistics team."

That something else is a hauler. Episode 6 splits harvesting from hauling for good.

See `docs/roadmap.md` for the full season.
