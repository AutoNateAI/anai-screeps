#import "theme.typ": tutorial-doc
#show: body => tutorial-doc(title: "Tutorial 04: Controller Upgrading", source: "docs/tutorials/04-controller-upgrading.md", body)

= Tutorial 04: Controller Upgrading
<tutorial-04-controller-upgrading>
#emph[Episode 4: The Controller\'s Price]

The controller crosses its first threshold while you\'re not even
watching it --- like finding out you hit a revenue milestone from a
Slack notification instead of a spreadsheet you were staring at. Your
collaborator notices before you do.

\"Room Controller Level 2,\" it says. \"You\'ve been upgrading it
because the upgrader role needed a job to do. Now it\'s paying you back
--- extensions just unlocked. More energy capacity per spawn cycle,
bigger creeps, everything downstream gets faster. This is what people
mean when they say \'compounding.\'\"

The controller was never just a progress bar. It\'s the thing that
decides what you\'re allowed to build next, same as revenue decides what
headcount you\'re allowed to add.

== Goal
<goal>
Reach Room Controller Level 2 (RCL2), understand what it unlocks, and
spend it:

- Confirm RCL2 and read what it grants
- Place extension construction sites
- Add a `builder` role that completes them
- Watch `room.energyCapacityAvailable` increase as a direct result

== Prerequisites
<prerequisites>
Tutorial 03 is complete:

- `role.harvester.js`, `role.upgrader.js`, and `main.js` exist.
- The `POPULATION` system is spawning 2 harvesters and 1 upgrader.
- The controller\'s `progress` has been increasing.

== Step 1: Check Your Controller Level
<step-1-check-your-controller-level>
```js
Game.spawns.Spawn1.room.controller.level
```

If this is still `1`, let the upgrader keep working --- RCL2 requires
`progress` to reach `progressTotal` at level 1, which happens
automatically as your upgrader delivers energy. This can take a while at
one upgrader; that\'s expected.

Checkpoint: this returns `2` before you continue.

== Step 2: Understand What RCL Controls
<step-2-understand-what-rcl-controls>
Room Controller Level gates which structures you\'re allowed to have,
not which structures you already have. Reaching a level only unlocks the
#emph[allowance] --- you still have to build.

#figure(
  align(center)[#table(
    columns: 3,
    align: (auto,auto,auto,),
    table.header([RCL], [Extensions Allowed], [Notable Unlock],),
    table.hline(),
    [1], [0], [Spawn only],
    [2], [5], [Extensions, ramparts, walls],
    [3], [10], [Towers],
    [4], [20], [Storage],
    [5], [30], [Links],
    [6], [40], [Terminal, labs, extractor],
    [7], [50], [Second spawn, factory],
    [8], [60], [Third spawn, observer, power spawn, nuker],
  )]
  , kind: table
  )

You just crossed row 2. Five extensions are now legal to build in this
room. None exist yet.

#align(center)[#image("../assets/04-controller-upgrading/diagram-01.png", alt: "Mermaid diagram 1")]

Each arrow is \"allowed to build,\" not \"built automatically\" ---
crossing RCL2 doesn\'t place a single extension for you. That\'s still
Step 3.

Checkpoint:

```js
Game.spawns.Spawn1.room.energyCapacityAvailable
```

Expected result: `300` --- the spawn\'s own capacity. Extensions
haven\'t been built, so they aren\'t contributing yet.

== Step 3: Place Extension Construction Sites
<step-3-place-extension-construction-sites>
Pick open tiles near `Spawn1` --- not on terrain walls, not on the spawn
itself. In the console, using coordinates near your spawn (adjust
`x`/`y` to your room):

```js
const room = Game.spawns.Spawn1.room;
room.createConstructionSite(24, 24, STRUCTURE_EXTENSION);
room.createConstructionSite(25, 24, STRUCTURE_EXTENSION);
room.createConstructionSite(24, 25, STRUCTURE_EXTENSION);
room.createConstructionSite(23, 24, STRUCTURE_EXTENSION);
room.createConstructionSite(24, 23, STRUCTURE_EXTENSION);
```

Expected result for each call: `0`.

Common results:

- `0`: OK
- `-7`: invalid target (wall, or another structure/site already there)
  --- pick a different tile
- `-8`: the site limit for this room has been reached

Checkpoint:

```js
Game.spawns.Spawn1.room.find(FIND_CONSTRUCTION_SITES).length
```

Expected result: `5` (or however many succeeded).

== Step 4: Add the Builder Role
<step-4-add-the-builder-role>
Nobody is completing these sites yet. Add a new file named
`role.builder`:

```js
const roleBuilder = {
  run(creep) {
    if (creep.memory.building && creep.store[RESOURCE_ENERGY] === 0) {
      creep.memory.building = false;
    }
    if (!creep.memory.building && creep.store.getFreeCapacity() === 0) {
      creep.memory.building = true;
    }

    if (creep.memory.building) {
      const target = creep.pos.findClosestByPath(FIND_CONSTRUCTION_SITES);
      if (!target) {
        return;
      }
      if (creep.build(target) === ERR_NOT_IN_RANGE) {
        creep.moveTo(target, { visualizePathStyle: { stroke: '#ffffff' } });
      }
      return;
    }

    const sources = creep.room.find(FIND_SOURCES);
    if (creep.harvest(sources[0]) === ERR_NOT_IN_RANGE) {
      creep.moveTo(sources[0], { visualizePathStyle: { stroke: '#ffaa00' } });
    }
  },
};

module.exports = roleBuilder;
```

This follows the exact same toggle pattern as `role.upgrader.js` from
Episode 3: fill up, switch to \"spend\" mode, empty out, switch back.
Same shape, different target.

== Step 5: Wire It Into `main`
<step-5-wire-it-into-main>
Add the builder to the population and the dispatch loop:

```js
const roleHarvester = require('role.harvester');
const roleUpgrader = require('role.upgrader');
const roleBuilder = require('role.builder');

const POPULATION = {
  harvester: 2,
  upgrader: 1,
  builder: 1,
};

module.exports.loop = function () {
  for (const name in Memory.creeps) {
    if (!Game.creeps[name]) {
      delete Memory.creeps[name];
    }
  }

  spawnMissingRoles();

  for (const name in Game.creeps) {
    const creep = Game.creeps[name];
    if (creep.memory.role === 'harvester') {
      roleHarvester.run(creep);
    } else if (creep.memory.role === 'upgrader') {
      roleUpgrader.run(creep);
    } else if (creep.memory.role === 'builder') {
      roleBuilder.run(creep);
    }
  }
};

function spawnMissingRoles() {
  const spawn = Game.spawns.Spawn1;
  if (spawn.spawning) {
    return;
  }

  for (const role in POPULATION) {
    const currentCount = _.filter(Game.creeps, (creep) => creep.memory.role === role).length;
    if (currentCount < POPULATION[role]) {
      const name = `${role}${Game.time}`;
      spawn.spawnCreep([WORK, CARRY, MOVE], name, { memory: { role } });
      break;
    }
  }
}
```

Checkpoint:

- A new `builder` creep spawns.
- It harvests, then walks to the nearest construction site and builds
  it.
- The site\'s progress bar (visible in the client) moves.

== Step 6: Watch Capacity Change
<step-6-watch-capacity-change>
Let the builder finish at least one extension. Then check:

```js
Game.spawns.Spawn1.room.energyCapacityAvailable
```

Expected result: `350` --- `300` from the spawn plus `50` from one
completed extension. Each additional finished extension adds another
`50`, up to `550` once all five are standing.

This number is not cosmetic. `spawnCreep` can only afford body parts up
to whatever `energyCapacityAvailable` allows. A colony stuck at `300`
capacity is permanently stuck with 3-part creeps like the ones you\'ve
been spawning all along.

#quote(block: true)[
📸 #strong[Screenshot placeholder:] Five completed extensions
surrounding `Spawn1` in the client, with the room\'s energy capacity UI
visible --- the moment \"more capacity\" stops being a console number
and becomes visible structures.
]

== Troubleshooting
<troubleshooting>
If `createConstructionSite` keeps returning `-7`, you\'re likely
targeting a wall tile or a position already occupied. Check terrain
first:

```js
Game.spawns.Spawn1.room.getTerrain().get(24, 24)
```

`1` means wall. `0` means plain. `2` means swamp (buildable, just slow).

If the builder never switches to building mode, confirm
`FIND_CONSTRUCTION_SITES` is actually returning something:

```js
Game.spawns.Spawn1.room.find(FIND_CONSTRUCTION_SITES)
```

If `energyCapacityAvailable` isn\'t increasing after a site completes,
confirm the site actually finished and became a real structure:

```js
Game.spawns.Spawn1.room.find(FIND_MY_STRUCTURES, { filter: { structureType: STRUCTURE_EXTENSION } }).length
```

== Completion Criteria
<completion-criteria>
You are done when:

- The room is at RCL2 or higher.
- At least one extension construction site has been placed and
  completed.
- `role.builder.js` exists and is wired into `main`.
- `room.energyCapacityAvailable` is greater than `300`.

== Learning Notes
<learning-notes>
After completing the tutorial, write down:

- How long did it take, in ticks, to go from RCL1 to RCL2 with only one
  upgrader?
- What\'s the tradeoff of adding a second upgrader now versus waiting
  for more extensions first?
- `spawnCreep` still uses the fixed body `[WORK, CARRY, MOVE]` even
  though capacity went up. What\'s the smallest change that would let it
  spend the new capacity?
- The builder\'s toggle pattern is identical to the upgrader\'s. What
  does that similarity suggest about how these two files should relate
  to each other going forward?

== Next: Episode 5 --- Paved Roads
<next-episode-5--paved-roads>
The builder has a job now, but it\'s a job with an end date --- five
extensions, then nothing left to build.

\"That\'s the wrong way to think about a builder,\" your collaborator
says. \"The room isn\'t going to stop needing things built. It\'s going
to need roads next, so your creeps stop torching half their lifetime
walking across open terrain like it\'s a commute nobody\'s
reimbursing.\"

See `docs/roadmap.md` for the full season.
