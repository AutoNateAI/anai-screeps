# Day 0 — Example Entry

This is a worked example for `docs/tutorials/10-ai-collaboration.md`, Step 2. Copy `TEMPLATE.md` for your own entries — don't edit this one.

## Today I Learned

Haulers stopped delivering energy after I touched `role.hauler.js`. Every hauler sat next to the spawn, full of energy, doing nothing.

## Mistakes

I inverted a condition while refactoring: `creep.store.getFreeCapacity() === 0` became `creep.store.getFreeCapacity() > 0`. That flipped "I'm full, go deliver" into "I have room left, go deliver" — so a hauler would only try to deliver *before* it had picked anything up, then immediately fail and stop.

## Interesting

The bug never threw an error. `creep.transfer()` on an empty creep just returns `ERR_NOT_ENOUGH_RESOURCES` silently. Nothing crashed — the colony just quietly stopped moving energy. Logic bugs that don't error are the ones that cost the most time, because nothing points at them.

## Prompt That Unstuck Me

"My haulers in `role.hauler.js` aren't delivering energy — they sit next to the spawn full of energy and don't transfer. Here's the toggle logic: `[pasted the `if (creep.memory.hauling...)` block]`. I expected a full hauler to switch to delivery mode. Instead nothing happens. I haven't changed the delivery-target logic, only the toggle condition above it recently. What's wrong with the toggle?"

Naming the exact lines I'd recently touched, instead of pasting the whole file, is what got a useful answer on the first try.

## Ideas for Curriculum

A "silent failure" challenge: hand students a role file with a bug that returns an error code instead of throwing, and see who checks the return value of `transfer`/`harvest`/`build` instead of assuming success.
