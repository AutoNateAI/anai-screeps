# Five-Wave Reliability

## Summary

The learner runs repeated invader waves to test whether defense code is reliable, not just lucky once.

## Skill Target

- Primary: regression testing under repeated combat pressure.
- Secondary: repair scheduling, tower energy logistics, creep replacement.
- Program track: Architect, Episode 13.
- Recommended episode: `docs/tutorials/13-sparring-ground.md`.

## Prerequisites

- First Invasion Defense is passing.
- `scripts/sparring-loop.sh` is available.
- Room has tower refueling logic or enough stored energy.

## Setup

Replace `W6N3` with the learner's room name.

```sh
scripts/sparring-loop.sh W6N3 5 10
```

This sends five waves with a ten-second delay between requests.

## Challenge

Keep the colony alive through repeated waves without pausing to manually repair, refuel, or respawn.

## Pressure

Five local sparring waves.

## Win Condition

The learner passes when:

- `Spawn1` survives all waves.
- Tower energy never stays empty for more than one wave.
- Worker population recovers automatically after losses.
- The learner can name the weakest part of the defense loop.

## Scoring

| Metric | Full Credit | Partial Credit |
| --- | --- | --- |
| Outcome | Survives all five waves and recovers. | Survives but stalls economy. |
| Code behavior | Defense, refuel, and repair priorities are explicit. | Defense works but logistics are fragile. |
| Debugging process | Learner compares wave 1 and wave 5 state. | Learner only reports final state. |

## Replay

Restore tower energy, then rerun the sparring loop. Keep the same delay when comparing attempts.

## Reflection

- Did the same failure repeat?
- Which metric changed after your code fix?
- Was the bottleneck damage, energy, CPU, or spawning?

## Extensions

- Easier: run three waves.
- Harder: reduce delay to five seconds.
- Team variant: one learner observes logs while another changes code.
