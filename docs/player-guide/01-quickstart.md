# Quickstart: Playing in 15 Minutes

## 1. Claim a Room

On the world map, pick an unowned room with two visible energy sources, a controller, and enough open space near both. Enter it, and use the client's prompt to place your first spawn. Name it `Spawn1`.

## 2. Spawn Your First Worker

Open the in-game console:

```js
Game.spawns.Spawn1.spawnCreep([WORK, CARRY, MOVE], 'Harvester1');
```

`0` means it worked. If you get something else:

- `-4` — spawn is busy
- `-6` — not enough energy
- `-3` — name already exists

## 3. Give It a Job

Open the script editor. Replace `main` with:

```js
module.exports.loop = function () {
  for (const name in Memory.creeps) {
    if (!Game.creeps[name]) delete Memory.creeps[name];
  }

  if (!Game.creeps.Harvester1 && !Game.spawns.Spawn1.spawning) {
    Game.spawns.Spawn1.spawnCreep([WORK, CARRY, MOVE], 'Harvester1');
  }

  const creep = Game.creeps.Harvester1;
  if (!creep) return;

  if (creep.store.getFreeCapacity() > 0) {
    const source = creep.room.find(FIND_SOURCES)[0];
    if (creep.harvest(source) === ERR_NOT_IN_RANGE) {
      creep.moveTo(source, { visualizePathStyle: { stroke: '#ffaa00' } });
    }
    return;
  }

  const spawn = Game.spawns.Spawn1;
  if (creep.transfer(spawn, RESOURCE_ENERGY) === ERR_NOT_IN_RANGE) {
    creep.moveTo(spawn, { visualizePathStyle: { stroke: '#ffffff' } });
  }
};
```

Save it. Watch the creep harvest, return, deliver, repeat — and respawn itself automatically if it dies.

That's the entire game, in miniature: harvest, deliver, survive. Everything from here is scaling that one loop until it doesn't need you watching it.

## 4. Sanity Checks

If nothing spawns: `Game.spawns.Spawn1.spawning` and `Game.spawns.Spawn1.store[RESOURCE_ENERGY]`.

If the creep exists but sits still: check the console for a script error — a typo in `main` fails silently otherwise.

Next: `02-core-loop-and-roles.md`.
