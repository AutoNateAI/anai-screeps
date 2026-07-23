#import "theme.typ": branded-doc
#show: body => branded-doc(title: "Rival Colony Border", source: "docs/competitions/05-rival-colony-border.md", subtitle: "A local Screeps competition module", body)

= Rival Colony Border
<rival-colony-border>
== Summary
<summary>
The learner expands near a persistent attacker-capable bot and must
balance growth, scouting, and defense before the border becomes unsafe.

== Skill Target
<skill-target>
- Primary: expansion under pressure.
- Secondary: remote-room routing, reservation, threat response,
  contingency planning.
- Program track: Lead Developer to Architect, Episodes 8, 11, and 12.
- Recommended episodes: `docs/tutorials/08-expansion.md`,
  `docs/tutorials/11-scouting.md`,
  `docs/tutorials/12-pvp-fundamentals.md`.

== Prerequisites
<prerequisites>
- Learner can sustain one room.
- Scout code records nearby intel.
- TooAngel is installed and registered as `tooangel`.

== Setup
<setup>
Spawn TooAngel two to four rooms away from the learner:

```sh
docker exec -it autonate-screeps screeps-launcher cli
```

```js
bots.spawn('tooangel', 'W3N1', { cpu: 100, gcl: 1 })
```

== Challenge
<challenge>
Choose whether to reserve, claim, or avoid a nearby room based on scout
data while the rival colony grows.

== Pressure
<pressure>
A persistent bot colony with autonomous behavior. The pressure is
strategic: the map is changing while the learner decides.

== Win Condition
<win-condition>
The learner passes when:

- The scout identifies the rival colony and border rooms.
- The learner records a decision: expand, delay, defend, or avoid.
- The chosen action is implemented in code.
- The home room remains stable while the expansion plan runs.

== Scoring
<scoring>
#figure(
  align(center)[#table(
    columns: 3,
    align: (auto,auto,auto,),
    table.header([Metric], [Full Credit], [Partial Credit],),
    table.hline(),
    [Outcome], [Expansion decision is executed without collapsing home
    economy.], [Decision exists but requires manual correction.],
    [Code behavior], [Scout, expansion, and defense logic share Memory
    data.], [Logic exists in separate one-off scripts.],
    [Debugging process], [Learner explains tradeoff with room
    evidence.], [Learner explains from intuition only.],
  )]
  , kind: table
  )

== Replay
<replay>
Move the bot to a different border room or change the time box. Compare
decisions across runs.

== Reflection
<reflection>
- What signal told you the border was unsafe?
- What did you delay to keep the home room stable?
- When would you switch from expansion to defense?

== Extensions
<extensions>
- Easier: make the bot farther away.
- Harder: spawn two rival bots in different directions.
- Team variant: one learner is expansion lead, one is defense lead.
