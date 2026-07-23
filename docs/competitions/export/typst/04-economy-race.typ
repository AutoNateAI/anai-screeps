#import "theme.typ": branded-doc
#show: body => branded-doc(title: "Economy Race", source: "docs/competitions/04-economy-race.md", subtitle: "A local Screeps competition module", body)

= Economy Race
<economy-race>
== Summary
<summary>
The learner races an NPC economy bot to hit early growth milestones,
focusing on reliable harvesting, source assignment, spawn uptime, and
controller progress.

== Skill Target
<skill-target>
- Primary: economy stability and growth pacing.
- Secondary: source assignment, role counts, construction timing.
- Program track: Builder, Episodes 2-5.
- Recommended episodes: `docs/tutorials/02-target-selection.md` through
  `docs/tutorials/05-construction-and-roads.md`.

== Prerequisites
<prerequisites>
- Learner has a fresh or reset room.
- ZeSwarm is installed and registered as `zeswarm`.
- Learner can inspect RCL, creep count, and spawn idle time.

== Setup
<setup>
Open the CLI:

```sh
docker exec -it autonate-screeps screeps-launcher cli
```

Spawn ZeSwarm in a separate unowned room:

```js
bots.spawn('zeswarm', 'W3N2', { cpu: 100, gcl: 1 })
```

== Challenge
<challenge>
Reach the agreed milestone before the benchmark bot or before a fixed
time box expires.

Suggested first milestone:

- Reach RCL 2.
- Maintain at least three useful creeps.
- Build at least one extension.
- Keep spawn idle time low enough that the learner can explain every
  idle period.

== Pressure
<pressure>
The bot acts as a benchmark, not necessarily a direct attacker.

== Win Condition
<win-condition>
The learner passes when:

- The colony reaches the milestone inside the time box.
- Both sources are used intentionally or the learner can justify not
  using both.
- Spawn behavior is role-count driven, not hand-spawned.
- The learner compares their progress to the bot or to their previous
  run.

== Scoring
<scoring>
#figure(
  align(center)[#table(
    columns: 3,
    align: (auto,auto,auto,),
    table.header([Metric], [Full Credit], [Partial Credit],),
    table.hline(),
    [Outcome], [Reaches milestone and keeps economy running.], [Reaches
    milestone with manual intervention.],
    [Code behavior], [Role targets adapt to room state.], [Role targets
    exist but are brittle.],
    [Debugging process], [Learner identifies one wasted tick
    pattern.], [Learner only reports final RCL.],
  )]
  , kind: table
  )

== Replay
<replay>
Use a fresh local room or reset the world state, then run the same
benchmark again.

== Reflection
<reflection>
- Where did energy wait too long?
- Which role blocked progress first?
- What did the bot do earlier than you?

== Extensions
<extensions>
- Easier: race only against the clock.
- Harder: require RCL 3 and tower construction.
- Team variant: compare two learner colonies against the same benchmark.
