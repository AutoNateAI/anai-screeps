# Welcome to the Screeps World

You wake up in a room you did not build.

They call you AutoNate. It's a callsign, not a birth name — the Foundry gives it to every architect who ships out with nothing but a terminal, a spawn beacon, and an AI collaborator riding along. The full story of how you got here is in `docs/story/00-prologue.md`. This document is the world; that one is the plot.

There is no avatar walking around with a sword. There is no quest marker waiting for you. There is only terrain, energy, a controller, a spawn, and the code you are willing to write.

Screeps is a persistent programming world. The world keeps ticking whether you are staring at it or not. Your colony survives because your systems keep working. A good decision becomes a reusable behavior. A bad assumption becomes a broken economy. A missing fallback becomes an idle spawn. Every line of code either helps the colony adapt or teaches you why it failed.

That is why this game belongs inside AutoNateAI.

We are not only learning JavaScript. We are learning how to design systems with feedback loops, constraints, resources, agents, memory, automation, debugging, and strategy. We are learning how to work with AI as a collaborator while still understanding the world well enough to judge the answer. The goal is not to copy code into the console. The goal is to become the kind of builder who can observe a complex world, describe what is happening, make a plan, implement a system, test it, and improve it over time.

Welcome to the world.

## The Core Objective

At the beginning, your objective is simple:

1. Choose a room.
2. Place a spawn.
3. Harvest energy.
4. Spawn creeps.
5. Upgrade the room controller.
6. Build structures.
7. Defend and expand.

Over time, the objective becomes deeper:

- Keep your economy alive without manual intervention.
- Turn repeated behavior into reusable roles and modules.
- Expand from one room to multiple rooms.
- Make decisions from memory, scouting, and world state.
- Build systems that recover from failure.
- Prepare bots for competition, review, and instruction.

In AutoNateAI terms, Screeps is our live systems simulator. It gives us a world where software architecture is visible.

## The First Mental Model

Think of your colony as a small software company crash-landed on an alien world.

- The spawn is your factory.
- Energy is your budget.
- Creeps are your workers.
- Roles are job descriptions.
- Memory is your shared operating notebook.
- The controller is your license to build bigger.
- Roads, extensions, towers, containers, and storage are infrastructure.
- Hostiles and decay are operational risk.
- Your codebase is the management system.

If the company has no workers, nothing moves. If the workers have unclear jobs, they waste time. If the budget is empty, production stops. If the code has no memory, the colony forgets what it was doing. If there is no strategy, each tick becomes a random scramble.

The game teaches systems thinking because everything is connected.

## Screeps Components at a Glance

| Component | What It Is | Why It Matters | First Strategy Question |
| --- | --- | --- | --- |
| Room | A 50x50 area of the world map | The basic unit of territory, economy, defense, and expansion | Is this room safe and useful enough to become a base? |
| Terrain | Plains, swamps, and walls | Controls movement cost, paths, and building placement | Where will creeps travel every tick? |
| Source | A natural energy generator | Primary early-game income | Can my creeps harvest and return energy efficiently? |
| Energy | The core resource | Powers spawning, building, upgrading, and repair | Is energy being collected faster than it is spent? |
| Spawn | The structure that creates creeps | Your colony cannot function without workers | Is the spawn idle, busy, or starved for energy? |
| Creep | A programmable worker unit | Performs harvesting, hauling, building, upgrading, repairing, and combat | What job should this creep do right now? |
| Body Parts | WORK, CARRY, MOVE, ATTACK, RANGED_ATTACK, HEAL, CLAIM, TOUGH | Define what each creep can do | Does this creep body match the job? |
| Controller | The room ownership/progression object | Upgrading it unlocks more structures and room capacity | Are we investing enough energy into progression? |
| Room Controller Level | The level of your room controller | Determines what structures you can build | What does the next level unlock, and do we need it now? |
| Construction Site | A planned structure not built yet | Turns strategy into future infrastructure | Which build site creates the most leverage first? |
| Extension | Extra energy capacity for spawning | Allows larger, stronger creep bodies | Are extensions full before spawning larger creeps? |
| Road | A structure that lowers movement cost | Saves creep lifetime and CPU over repeated routes | Which paths are traveled often enough to pave? |
| Container | A simple energy drop-off point | Helps separate harvesting from hauling | Should harvesters stand still and haulers move energy? |
| Storage | Large shared room inventory | Enables more advanced logistics | When does the room need a central warehouse? |
| Tower | Automated defense, repair, and healing structure | Protects the room and handles urgent repairs | Is the tower fueled before danger arrives? |
| Memory | Persistent JSON data between ticks | Lets your colony remember assignments, plans, and state | What does the colony need to remember to avoid confusion? |
| Game Object | The live API surface, such as `Game.creeps` and `Game.rooms` | Your code reads the world through `Game` every tick | What facts can the code observe right now? |
| Tick | One world update cycle | Every script loop runs once per tick | What should happen this tick, and what can wait? |
| CPU | Execution budget for your code | Limits inefficient logic as the colony grows | Is this code simple enough to run every tick? |
| Role | A behavior pattern assigned to a creep | Organizes work into reusable systems | Which roles does the colony need first? |
| Pathfinding | Choosing movement routes | Bad paths waste time, energy, and creep lifetime | Are creeps taking reliable routes? |
| Hostile | Enemy or NPC threat | Forces defense and risk management | What detects danger before it becomes a crisis? |
| Market | Player resource economy | Enables later trading and specialization | What resources are worth buying or selling later? |
| Shard | A separate world/server partition | Matters for advanced world scale | Which world are we operating in? |
| Private Server | Local or custom Screeps server | Lets us learn safely and repeat experiments | Can we reset, inspect, and document our own world? |

## The AutoNateAI Lens

Screeps practice becomes AutoNateAI training when we translate game activity into builder competencies.

| Track | In Screeps | In Software Architecture |
| --- | --- | --- |
| Screeps Player | Learn rooms, energy, creeps, controllers, defense, and expansion | Understand the domain before designing systems |
| Screeps Developer | Write reliable loops, roles, modules, tests, deployment, and local workflows | Build maintainable code that runs over time |
| AI Collaborator | Use AI to debug, explain APIs, review code, and propose strategies | Learn how to prompt, inspect, verify, and improve model output |
| Tournament Organizer | Prepare bots, scoring, replays, rankings, rules, and submissions | Design fair systems, evaluation loops, and public demonstrations |

The same room can teach all four tracks.

If your harvester gets stuck, the player asks, "Where is it stuck?"

The developer asks, "What does the movement code assume?"

The AI collaborator asks, "What prompt gives enough context for useful debugging?"

The tournament organizer asks, "How would we turn this failure into a challenge students can learn from?"

That is the program.

## Early Strategy Priorities

Do not try to build a perfect colony first. Build a visible loop.

The first working loop is:

```text
source -> creep -> spawn -> more creeps
```

Then:

```text
source -> creep -> controller -> higher room level
```

Then:

```text
source -> creep -> construction sites -> infrastructure
```

The early strategy is not about cleverness. It is about keeping the colony alive long enough to learn.

Prioritize:

- Spawn uptime: an idle spawn usually means the economy is not using its capacity.
- Energy flow: creeps must harvest, carry, and deliver energy without confusion.
- Role clarity: every creep should have a job.
- Memory hygiene: dead creep memory should be cleaned up.
- Controller progress: upgrading unlocks the next layer of the game.
- Observation: write down what fails before changing too much.

## What Students Should Feel

Students should feel like they have entered a real operating environment.

This is not a worksheet where every answer is already shaped. It is a world where their code has consequences. They will make workers, break workers, forget edge cases, fix loops, rename roles, ask AI for help, reject bad suggestions, and slowly learn to think like system builders.

The first victory is not domination.

The first victory is watching one worker harvest energy, bring it home, and repeat the loop because the system told it to.

That is the beginning of automation.

## First Questions to Carry Forward

As you play, keep these questions nearby:

- What is the colony trying to accomplish this tick?
- What resource is currently limiting progress?
- Which creeps are doing useful work?
- Which creeps are wasting movement?
- What should be automatic but is still manual?
- What state does the code need to remember?
- What changed in the world that the code did not expect?
- What would I need to explain this system to a new student?

Every answer becomes curriculum.

Every bug becomes a lesson.

Every working loop becomes a building block for the league.

## The Story So Far

This document is the world. The chronicle is AutoNate's path through it, and every tutorial is an episode.

- Prologue: `docs/story/00-prologue.md` — how AutoNate got here.
- Story bible: `docs/story/bible.md` — the Foundry, the League, and the terms this chronicle uses.
- Roadmap: `docs/roadmap.md` — every episode, in order, mapped to the four tracks and the Explorer to Architect ladder.
- Episode 1: `docs/tutorials/01-first-spawn-and-harvester.md` — Touchdown.

