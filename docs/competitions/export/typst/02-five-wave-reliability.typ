#import "theme.typ": branded-doc
#show: body => branded-doc(title: "Five-Wave Reliability", source: "docs/competitions/02-five-wave-reliability.md", subtitle: "A local Screeps competition module", body)

= Five-Wave Reliability
<five-wave-reliability>
== Summary
<summary>
The learner runs repeated invader waves to test whether defense code is
reliable, not just lucky once.

== Skill Target
<skill-target>
- Primary: regression testing under repeated combat pressure.
- Secondary: repair scheduling, tower energy logistics, creep
  replacement.
- Program track: Architect, Episode 13.
- Recommended episode: `docs/tutorials/13-sparring-ground.md`.

== Prerequisites
<prerequisites>
- First Invasion Defense is passing.
- `scripts/sparring-loop.sh` is available.
- Room has tower refueling logic or enough stored energy.

== Setup
<setup>
Replace `W6N3` with the learner\'s room name.

```sh
scripts/sparring-loop.sh W6N3 5 10
```

This sends five waves with a ten-second delay between requests.

== Challenge
<challenge>
Keep the colony alive through repeated waves without pausing to manually
repair, refuel, or respawn.

== Pressure
<pressure>
Five local sparring waves.

== Win Condition
<win-condition>
The learner passes when:

- `Spawn1` survives all waves.
- Tower energy never stays empty for more than one wave.
- Worker population recovers automatically after losses.
- The learner can name the weakest part of the defense loop.

== Scoring
<scoring>
#figure(
  align(center)[#table(
    columns: 3,
    align: (auto,auto,auto,),
    table.header([Metric], [Full Credit], [Partial Credit],),
    table.hline(),
    [Outcome], [Survives all five waves and recovers.], [Survives but
    stalls economy.],
    [Code behavior], [Defense, refuel, and repair priorities are
    explicit.], [Defense works but logistics are fragile.],
    [Debugging process], [Learner compares wave 1 and wave 5
    state.], [Learner only reports final state.],
  )]
  , kind: table
  )

== Replay
<replay>
Restore tower energy, then rerun the sparring loop. Keep the same delay
when comparing attempts.

== Reflection
<reflection>
- Did the same failure repeat?
- Which metric changed after your code fix?
- Was the bottleneck damage, energy, CPU, or spawning?

== Extensions
<extensions>
- Easier: run three waves.
- Harder: reduce delay to five seconds.
- Team variant: one learner observes logs while another changes code.
