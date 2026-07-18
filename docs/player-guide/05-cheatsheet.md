# Cheatsheet

Quick lookups for things you'll otherwise re-Google every week for the first month.

## Common Error Codes

| Code | Meaning |
| --- | --- |
| `0` | `OK` — it worked |
| `-1` | `ERR_NOT_OWNER` |
| `-2` | `ERR_NO_PATH` |
| `-3` | `ERR_NAME_EXISTS` |
| `-4` | `ERR_BUSY` (spawn is already spawning) |
| `-5` | `ERR_NOT_FOUND` |
| `-6` | `ERR_NOT_ENOUGH_RESOURCES` / `ERR_NOT_ENOUGH_ENERGY` |
| `-7` | `ERR_INVALID_TARGET` |
| `-8` | `ERR_FULL` |
| `-9` | `ERR_NOT_IN_RANGE` — the one you'll handle constantly; usually means "move closer, then retry" |
| `-10` | `ERR_INVALID_ARGS` |
| `-11` | `ERR_TIRED` |
| `-12` | `ERR_NO_BODYPART` |

## Body Part Costs

| Part | Energy Cost | Effect |
| --- | --- | --- |
| `MOVE` | 50 | Reduces fatigue |
| `WORK` | 100 | Harvest 2/tick, build 5/tick, upgrade 1/tick, repair 100/tick |
| `CARRY` | 50 | 50 capacity |
| `ATTACK` | 80 | 30 melee damage/tick |
| `RANGED_ATTACK` | 150 | 10 damage/tick at range ≤3 |
| `HEAL` | 250 | 12 hp/tick melee, 4 hp/tick ranged |
| `CLAIM` | 600 | Required for `claimController`/`reserveController` |
| `TOUGH` | 10 | No action; 100 hp buffer |

Max 50 body parts per creep. Spawn capacity (`room.energyCapacityAvailable`) caps what you can actually afford at once — see the RCL table in `02-core-loop-and-roles.md`.

## API One-Liners You'll Type Constantly

```js
Game.spawns.Spawn1.room.controller.level              // current RCL
Game.spawns.Spawn1.room.energyCapacityAvailable        // max spawn capacity right now
Game.spawns.Spawn1.room.energyAvailable                // energy sitting in spawn+extensions right now
Game.cpu.getUsed()                                      // this tick's CPU so far
Game.cpu.bucket                                          // banked CPU
Game.map.describeExits(roomName)                        // adjacent room names by direction
Game.map.getRoomStatus(roomName)                        // 'normal' | 'closed' | 'novice' | 'respawn'
room.find(FIND_HOSTILE_CREEPS)                          // any hostile creep currently visible
room.getTerrain().get(x, y)                              // 0 plain, 1 wall, 2 swamp
creep.getActiveBodyparts(ATTACK)                        // live (non-destroyed) part count
```

## Structure Limits by RCL

See the full table in `02-core-loop-and-roles.md`. Containers are the exception — up to 5 allowed at any RCL, including RCL0.

## Where to Go Deeper

Every pattern in this guide has a full episode in `docs/tutorials/` with checkpoints, troubleshooting, and the reasoning behind each design choice — start at `docs/tutorials/01-first-spawn-and-harvester.md` if you want the long version of any of this.
