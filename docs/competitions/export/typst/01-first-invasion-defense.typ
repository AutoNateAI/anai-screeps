#import "theme.typ": branded-doc
#show: body => branded-doc(title: "First Invasion Defense", source: "docs/competitions/01-first-invasion-defense.md", subtitle: "A local Screeps competition module", body)

= First Invasion Defense
<first-invasion-defense>
== Summary
<summary>
The learner triggers one real NPC invader wave against their local room
and proves their colony can detect hostiles, fire towers, protect
critical structures, and keep the economy alive.

== Skill Target
<skill-target>
- Primary: hostile detection and tower automation.
- Secondary: defensive population targets, repair triage, observation.
- Program track: Developer, Episode 7.
- Recommended episode: `docs/tutorials/07-defense.md`.

== Prerequisites
<prerequisites>
- Local Screeps server is running.
- Sparring health check returns `ok: 1`.
- Learner owns one room with `Spawn1`.
- Room has at least one tower with energy.
- Learner code calls tower logic every tick.

== Setup
<setup>
Replace `W6N3` with the learner\'s room name.

```sh
curl http://localhost:21025/local/api/sparring/health
```

```sh
curl -X POST http://localhost:21025/local/api/sparring/wave \
  -H 'Content-Type: application/json' \
  -d '{"room": "W6N3"}'
```

== Challenge
<challenge>
Survive the first invasion without manual combat commands. The learner
may watch the room, but all attacks, repairs, and defender spawning must
come from code.

== Pressure
<pressure>
One engine-generated invader wave from the local sparring endpoint.

== Win Condition
<win-condition>
The learner passes when:

- The invader is destroyed.
- `Spawn1` survives.
- At least one worker survives or the colony automatically recovers its
  worker population.
- Tower behavior is visible in code, not manually controlled.

== Scoring
<scoring>
#figure(
  align(center)[#table(
    columns: 3,
    align: (auto,auto,auto,),
    table.header([Metric], [Full Credit], [Partial Credit],),
    table.hline(),
    [Outcome], [Invader dies and economy continues.], [Invader dies but
    recovery needs manual spawning.],
    [Code behavior], [Towers attack hostiles before repairs.], [Towers
    work, but priority is unclear.],
    [Debugging process], [Learner records wave result, failure point,
    and one code change.], [Learner describes result without evidence.],
  )]
  , kind: table
  )

== Replay
<replay>
Run the same sparring wave command after restoring tower energy. If the
room stops producing invaders, choose a room with an exit into a neutral
room.

== Reflection
<reflection>
- How did your code find the hostile?
- What did the tower do first?
- What structure or creep was most at risk?
- What is one automated recovery behavior you added after the wave?

== Extensions
<extensions>
- Easier: allow one tower and no defender creep requirement.
- Harder: require tower refueling while the wave is active.
- Team variant: one learner writes tower logic, one writes population
  recovery.
