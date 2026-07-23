#import "theme.typ": branded-doc
#show: body => branded-doc(title: "Local Competition Modules", source: "docs/competitions/README.md", subtitle: "A local Screeps competition module", body)

= Local Competition Modules
<local-competition-modules>
These modules turn the local Screeps private server into a replayable
training lab. Each module is a short, resettable challenge against
either engine NPC invaders or an autonomous bot colony, tied to one
program skillset.

Use these after the learner can connect to the local server and run
their own code. Server setup lives in `docs/local-screeps.md`.

== Design Rules
<design-rules>
- One module teaches one primary skill.
- The setup must be reproducible from local commands.
- The opponent pressure must be explicit: invader wave, `tooangel`,
  `zeswarm`, or timed benchmark.
- The win condition must be observable in-game.
- The reflection should ask for evidence from code, room state, and
  logs.
- The module should be short enough to replay in one lab block.

== Tooling Available Locally
<tooling-available-locally>
#figure(
  align(center)[#table(
    columns: 3,
    align: (auto,auto,auto,),
    table.header([Tool], [Best For], [Command Surface],),
    table.hline(),
    [Sparring wave], [Fast defense
    repetitions], [`POST /local/api/sparring/wave`],
    [`tooangel` bot], [Persistent rival with attack
    behavior], [`bots.spawn('tooangel', room, opts)`],
    [`zeswarm` bot], [Economy/race-style
    benchmark], [`bots.spawn('zeswarm', room, opts)`],
    [Admin CLI], [World setup, map checks,
    cleanup], [`docker exec -it autonate-screeps screeps-launcher cli`],
    [Journal template], [Debugging and
    reflection], [`docs/journal/TEMPLATE.md`],
  )]
  , kind: table
  )

== Module Progression
<module-progression>
#figure(
  align(center)[#table(
    columns: 5,
    align: (auto,auto,auto,auto,auto,),
    table.header([\#], [Module], [Skill Target], [Pressure], [Status],),
    table.hline(),
    [1], [First Invasion Defense], [Tower logic, hostile detection,
    survival triage], [Sparring wave], [Draft],
    [2], [Five-Wave Reliability], [Regression testing under repeated
    pressure], [Sparring wave loop], [Draft],
    [3], [Scout Before Contact], [Intel collection and room
    classification], [Nearby bot colony], [Draft],
    [4], [Economy Race], [Spawn uptime, source assignment, RCL
    pace], [`zeswarm` benchmark], [Draft],
    [5], [Rival Colony Border], [Expansion timing and threat
    response], [`tooangel` nearby], [Draft],
    [6], [League Scrimmage], [Submission discipline and scoring], [Bot
    or human opponent], [Draft],
  )]
  , kind: table
  )

== Standard Run Flow
<standard-run-flow>
+ Start or restart the local server.
+ Confirm local mods are loaded.
+ Reset or choose the target room state.
+ Run the setup commands from the module.
+ Start the learner code.
+ Trigger the pressure.
+ Observe the win condition.
+ Capture a short journal entry.
+ Repeat with one code improvement.

== Common Commands
<common-commands>
Health check for sparring tools:

```sh
curl http://localhost:21025/local/api/sparring/health
```

Trigger one invader wave:

```sh
curl -X POST http://localhost:21025/local/api/sparring/wave \
  -H 'Content-Type: application/json' \
  -d '{"room": "W6N3"}'
```

Run repeated waves:

```sh
scripts/sparring-loop.sh W6N3 5 10
```

Open the server CLI:

```sh
docker exec -it autonate-screeps screeps-launcher cli
```

Spawn a bot rival:

```js
bots.spawn('tooangel', 'W3N1', { cpu: 100, gcl: 1 })
bots.spawn('zeswarm', 'W3N2', { cpu: 100, gcl: 1 })
```

== Files
<files>
- `module-template.md` - copy this for new modules.
- `01-first-invasion-defense.md` - first combat automation checkpoint.
- `02-five-wave-reliability.md` - repeated pressure and regression
  testing.
- `03-scout-before-contact.md` - scouting and intel before action.
- `04-economy-race.md` - growth race against an economy bot.
- `05-rival-colony-border.md` - expansion under pressure from an
  attacker bot.
