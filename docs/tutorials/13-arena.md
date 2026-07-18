# Tutorial 13: Arena

*Episode 13: The Arena*

"The World is the wrong place to learn this the hard way," your collaborator says. "Arena exists so you can lose fifty times in an afternoon and only spend an afternoon."

Everything you've built so far lives in one persistent colony that took thirteen episodes to grow. Arena throws that away on purpose.

## Goal

Understand what Screeps Arena is, how it differs from the World server this whole season has run on, and use it as a fast-iteration lab for combat and pathing logic before trusting that logic in a real colony:

- Understand why Arena exists as a separate product, not a mode of the World client
- Recognize the shape of an Arena script versus a World script
- Port the pattern from `role.defender.js` into Arena's API shape
- Know what does not carry over between the two

## Prerequisites

Tutorial 12 is complete:

- `role.defender.js` exists and you understand the combat numbers from its Step 1 table.
- You've internalized the honest limitation from Episodes 7 and 12: this local World server doesn't give you real hostiles to test against.

## Step 1: What Arena Actually Is

Screeps Arena is a separate product from Screeps World — its own client, its own matchmaking, its own scripting environment. Where World is a persistent, always-running economy you grow over weeks, Arena matches are short, fixed-map, ranked contests: capture an objective, destroy a spawn, out-fight an opponent — usually resolved in a few thousand ticks, not the open-ended timeline your colony has been running on since Episode 1.

That difference is the entire point. Arena strips away everything this season spent twelve episodes building — no RCL grind, no multi-room logistics, no CPU budget shared across nine roles — and leaves just the mechanic you want to practice. Losing a match costs you minutes. Losing a real fight in your World colony can cost you a colony.

## Step 2: How Arena Scripts Differ From World Scripts

Every World script in this season has used global objects — `Game.creeps`, `Game.spawns`, `Memory`. Arena does not use those globals. Arena scripts are ES modules: you `import` what you need from packages like `game`, `game/prototypes`, `game/constants`, and `game/utils`, and export a `loop` function the same way `main.js` does in World.

The shape is illustrative of the pattern, not a guaranteed drop-in — Arena's exact API surface has changed between seasons, and the authoritative reference is the in-client documentation and starter examples that ship with Arena itself, not this document:

```js
import { Creep } from 'game/prototypes';
import { getObjectsByPrototype } from 'game/utils';
import { ATTACK, RANGED_ATTACK } from 'game/constants';

export function loop() {
  const myCreeps = getObjectsByPrototype(Creep).filter((creep) => creep.my);
  const enemyCreeps = getObjectsByPrototype(Creep).filter((creep) => !creep.my);

  myCreeps.forEach((creep) => {
    const target = creep.findClosestByRange(enemyCreeps);
    if (!target) {
      return;
    }
    if (creep.getRangeTo(target) <= 1) {
      creep.attack(target);
    } else {
      creep.moveTo(target);
    }
  });
}
```

## Step 3: Recognize the Pattern, Not the Syntax

Compare that loop against `role.defender.js` from Episode 12:

- Both find hostile creeps.
- Both check range before choosing an action.
- Both fall back to movement when nothing is in range yet.

The syntax changed — `getObjectsByPrototype(Creep).filter(...)` instead of `room.find(FIND_HOSTILE_CREEPS)`, `import` statements instead of ambient globals. The underlying decision tree — find target, check range, act or close distance — is identical. That's the actual transferable skill this episode is teaching: the pattern survives the API change. Memorizing one API's exact method names doesn't.

## Step 4: What Does Not Carry Over

- **No persistent Memory across matches.** Each Arena match starts clean. There's no equivalent to `Memory.rooms` surviving between one match and the next the way it survives between World ticks.
- **No multi-room economy.** Arena scenarios are typically single-map, objective-driven. The role-population system from Episodes 3–8 doesn't have anywhere to go in a match this short.
- **Scenario-restricted constants.** A given Arena season may cap which body parts, structures, or actions are legal for that specific scenario. Check the scenario rules before assuming everything from World is available.

What does carry over: body part costs and effects (the Step 1 table from Episode 12 is the same math), the value of range-checking before acting, and the discipline of testing a small piece of logic in isolation before trusting it inside a bigger system.

## Step 5: Practice the Loop, Not Just the Match

Play at least one Arena match with combat logic modeled on `role.defender.js`'s pattern. When it goes wrong — and the first one usually does — apply Episode 10's structured-prompt debugging process to it: what you expected, what happened, the relevant code, what you already tried, what "fixed" looks like. Log it in `docs/journal/` the same way.

This is the actual payoff of Arena existing separately from World: a fast enough loss-to-lesson cycle that debugging combat logic stops being expensive.

## Troubleshooting

If your Arena script doesn't run at all, the most common cause is an import path or API name that changed between seasons — check the current in-client documentation and starter scripts rather than assuming this tutorial's example is exact.

If `creep.my` behaves unexpectedly, confirm you're filtering the right collection — `getObjectsByPrototype(Creep)` returns every creep on the map, both yours and your opponent's, in a single flat list.

If a scenario rejects your creep body, check that scenario's specific constant restrictions before assuming your World-side `ROLE_BODIES` values are portable as-is.

## Completion Criteria

You are done when:

- You can explain, in one sentence, why Arena and World are separate products instead of one client with two modes.
- You've played at least one Arena match using logic modeled on `role.defender.js`.
- You can point to the specific lines in an Arena script that correspond to `findClosestByRange`, range-checking, and the attack/move fallback in your World defender.
- You've logged at least one Arena debugging session in `docs/journal/`.

## Learning Notes

After completing the tutorial, write down:

- What broke on your first Arena attempt that wouldn't have broken in World, purely because of the compressed timeline?
- Which parts of `role.defender.js`'s logic ported over almost unchanged, and which needed real rework?
- If Arena and World shared a Memory store, what's one thing you'd want to carry over between them? What's one thing you'd specifically want kept separate?
- What's the fastest iteration loop you found — how many matches could you realistically run and review in one sitting?

## Next: Episode 14 — Open the Gates

You've played the game from every angle this season offers: economy, infrastructure, logistics, defense, expansion, and now combat.

"There's one role left," your collaborator says, "and it's not a creep. It's you. Somebody has to run the league the next architect drops into."

See `docs/roadmap.md` for the full season.
