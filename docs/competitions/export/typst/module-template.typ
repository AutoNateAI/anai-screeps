#import "theme.typ": branded-doc
#show: body => branded-doc(title: "Module Title", source: "docs/competitions/module-template.md", subtitle: "A local Screeps competition module", body)

= Module Title
<module-title>
== Summary
<summary>
One paragraph describing the challenge, the learner skill, and why this
module exists.

== Skill Target
<skill-target>
- Primary:
- Secondary:
- Program track:
- Recommended episode:

== Prerequisites
<prerequisites>
- Local Screeps server is running.
- Learner can deploy code to the local server.
- Required room state:
- Required local tools:

== Setup
<setup>
Document the exact room, bot, or world state needed before the timer
starts.

```sh
# shell commands
```

```js
// server CLI commands
```

== Challenge
<challenge>
Describe what the learner must do in player terms.

== Pressure
<pressure>
Describe what pushes back: invader wave, repeated waves, bot colony,
time limit, resource limit, or scoring rule.

== Win Condition
<win-condition>
The learner passes when:

- Condition 1
- Condition 2
- Condition 3

== Scoring
<scoring>
#figure(
  align(center)[#table(
    columns: 3,
    align: (auto,auto,auto,),
    table.header([Metric], [Full Credit], [Partial Credit],),
    table.hline(),
    [Outcome], [], [],
    [Code behavior], [], [],
    [Debugging process], [], [],
  )]
  , kind: table
  )

== Replay
<replay>
Commands to reset or rerun the module.

== Reflection
<reflection>
- What failed first?
- What did the code detect correctly?
- What was still manual?
- What evidence proves the fix worked?

== Extensions
<extensions>
- Easier:
- Harder:
- Team variant:
