# Story Bible

Reference doc for anyone — human or AI — writing a future episode. Keeps names, tone, and rules consistent across tutorials.

## Protagonist

**AutoNate** — a callsign, not a birth name. Given by the Foundry to every architect who ships out with a terminal, a spawn beacon, and an AI collaborator. The narrative is second person: the student reading the tutorial *is* AutoNate. Do not give AutoNate a face, gender, or backstory beyond what's in `docs/story/00-prologue.md` — the callsign is meant to be worn by whoever is reading.

**The AI collaborator** — deliberately unnamed. It's the stand-in for whatever AI tool the student is actually pairing with (Claude, Codex, Gemini, etc.), so it never gets a proper name or a fixed personality beyond: direct, a little dry, narrates telemetry/state instead of giving orders. It observes and reports; AutoNate decides and types.

## Factions and Terms

| Term | Meaning |
| --- | --- |
| The Foundry | The org that trains architects by dropping them into unclaimed rooms with nothing but a spawn and a console. Source of the framing device, not a literal in-game object. |
| Architect | Top of the progression ladder — someone who ships production-quality colonies and mentors the next drop. |
| The League | The tournament and competition structure AutoNate eventually helps run. Payoff for Track 4 (Tournament Organizer). |
| A room | Both the literal 50x50 Screeps room and, loosely, a stand-in for "the next problem." Don't overload this pun — use it once per episode at most. |

## The Ladder as Story Arcs

The Explorer → Architect competency ladder (see `docs/roadmap.md`) is the season structure. Each arc is a block of episodes, not a single one.

| Rank | Arc Title | What Changes |
| --- | --- | --- |
| Explorer | First Light | AutoNate proves one worker can complete one loop without dying. |
| Builder | Division of Labor | Single hardcoded creep becomes roles, controller progress, and infrastructure. |
| Developer | The Machine Wakes | The colony survives without AutoNate watching every tick: logistics, defense, expansion. |
| Studio Member | Refactor | The code has to survive its own success — CPU, memory, and the AI-collaboration workflow get formalized. |
| Lead Developer | First Blood | First contact with other players — scouting, then combat. |
| Architect | The League | AutoNate stops playing solo and starts running the league other architects drop into. |

## Tone Rules

- Narrative sections are a cold open (before `## Goal`) and a short hook to the next episode (after the learning notes). Keep both under ~150 words. The checklist-driven tutorial body is the curriculum; the story is the reason to keep turning pages, not a replacement for the steps.
- Never rename or fictionalize a real Screeps mechanic. `WORK`/`CARRY`/`MOVE`, RCL, `Game.spawns`, error codes — all real, all stay exactly as the API defines them. The fiction sits on top of the mechanics; it never replaces or obscures them.
- The AI collaborator can foreshadow the *next* episode's problem (e.g., flagging that two harvesters will fight over one source) but should never hand AutoNate the solution before the tutorial teaches it.
- No combat, hostiles, or stakes-raising language until the arc that actually introduces them (Developer arc onward). Early episodes stay about competence, not danger.
