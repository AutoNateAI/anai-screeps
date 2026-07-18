# League Scaffold

This is the minimal structure for running an AutoNateAI Screeps league match, referenced by `docs/tutorials/14-running-the-league.md` (Episode 14). It exists so "run a tournament" has somewhere real to point at instead of only being a set of instructions.

## Structure

```text
league/
├── submissions/       one subfolder per contestant, named after their team/callsign
├── scoring-rubric.md  the judged-category rubric used alongside win/loss
└── results/           match records: participants, commit hashes, scores, replay links
```

`submissions/` and `results/` are intentionally empty until a real season runs — see Episode 14 for the workflow that populates them.

## Submission Format

Each contestant gets a folder under `submissions/<callsign>/` containing:

- Their bot's source files (matching whatever format the match environment expects — Arena script or World branch export).
- A `SUBMISSION.md` with: contestant name/callsign, submission git commit hash, submission timestamp, and a one-line description of the bot's strategy.

Submissions are locked at the deadline by tagging the commit — see Episode 14, Step 2. No changes to a submission folder after its tag is cut.
