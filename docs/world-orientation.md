# Welcome to the Screeps World

You wake up in a room you did not build. No handoff doc, no README, no departing engineer to Slack you with "quick question."

They call you AutoNate. It's a callsign, not a birth name — the Foundry gives it to every architect who ships out with nothing but a terminal, a spawn beacon, and an AI collaborator riding along. The full story of how you got here is in `docs/story/00-prologue.md`. This document is the world; that one is the plot.

There's no avatar walking around with a sword. No quest marker hovering over your next objective like the game feels bad for you. There's only terrain, energy, a controller, a spawn, and the code you're willing to write.

Screeps is a persistent programming world. The world keeps ticking whether you're staring at it or not — closer to a production server than a video game. Your colony survives because your systems keep working, not because you personally showed up. A good decision becomes a reusable behavior. A bad assumption becomes a broken economy. A missing fallback becomes an idle spawn — the Screeps version of a stalled deploy nobody's watching. Every line of code either helps the colony adapt or teaches you why it failed. Both outcomes ship you information.

That's why this game belongs inside AutoNateAI.

We're not only learning JavaScript. We're learning how to design systems with feedback loops, constraints, resources, agents, memory, automation, debugging, and strategy — the actual job, underneath whatever language you happen to be writing it in. We're learning how to work with AI as a collaborator while still understanding the world well enough to judge the answer, because "the AI said so" has never once shipped a good system on its own. The goal isn't to copy code into the console. The goal is to become the kind of builder who can observe a complex world, describe what's happening, make a plan, implement a system, test it, and improve it over time — then do it again next tick, because there's always a next tick.

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

Think of your colony as a startup that crash-landed on an alien world with no runway extension coming.

- The spawn is your factory.
- Energy is your budget.
- Creeps are your workers.
- Roles are job descriptions.
- Memory is your shared operating notebook.
- The controller is your license to build bigger.
- Roads, extensions, towers, containers, and storage are infrastructure.
- Hostiles and decay are operational risk.
- Your codebase is the management system.

If the company has no workers, nothing moves. If the workers have unclear jobs, they waste time — same as any team with no job descriptions, they'll just do whatever felt most urgent five minutes ago. If the budget is empty, production stops, full stop, no exceptions, no bridge round. If the code has no memory, the colony forgets what it was doing, same as a team with no documentation. If there's no strategy, each tick becomes a random scramble, which is a nice way of saying "everyone's in react mode and nobody's driving."

The game teaches systems thinking because everything is connected. You will feel this in your chest the first time an idle spawn costs you real progress and you realize it was entirely your fault.

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

That's the program. Four job titles, one stuck creep.

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

Students should feel like they've entered a real operating environment, not a demo.

This isn't a worksheet where every answer is already shaped for you. It's a world where their code has real consequences — nobody's grading on effort. They'll make workers, break workers, forget edge cases, fix loops, rename roles, ask AI for help, reject bad suggestions, and slowly learn to think like system builders instead of people copying tutorials.

The first victory isn't domination.

The first victory is watching one worker harvest energy, bring it home, and repeat the loop — because the system told it to, not because you're standing there micromanaging it like a nervous manager.

That's the beginning of automation. Everything after this is just that same feeling, at a bigger scale, with higher stakes.

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

Every working loop becomes a building block for the league. Nothing here gets thrown away, including the stuff that breaks.

## The Story So Far

This document is the world. The chronicle is AutoNate's path through it, and every tutorial is an episode.

- Prologue: `docs/story/00-prologue.md` — how AutoNate got here.
- Story bible: `docs/story/bible.md` — the Foundry, the League, and the terms this chronicle uses.
- Roadmap: `docs/roadmap.md` — every episode, in order, mapped to the four tracks and the Explorer to Architect ladder.
- Episode 1: `docs/tutorials/01-first-spawn-and-harvester.md` — Touchdown.

