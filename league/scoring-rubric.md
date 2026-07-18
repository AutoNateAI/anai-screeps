# Scoring Rubric Template

Used alongside raw win/loss for matches where judged categories matter — student cohorts, showcase events, or any format where "won the match" shouldn't be the only signal of learning.

## Match Result (required)

| Category | Points |
| --- | --- |
| Win | 3 |
| Draw / no clear objective met by either side | 1 |
| Loss | 0 |

## Judged Categories (optional, for showcase/cohort formats)

| Category | Points (0-5) | Notes |
| --- | --- | --- |
| Code clarity | | Would another contestant understand this bot's roles from the code alone? |
| Resilience | | Does the bot recover from a dead creep, an empty source, a failed path without crashing or stalling? |
| Strategy | | Did the bot's plan match the scenario, or was it a generic template with no adaptation? |
| CPU discipline | | Did the bot stay within its CPU budget under load, or did it visibly degrade? |

## Disqualification Checklist

Before a match counts, confirm the submission passes every item in Episode 14's anti-cheat checklist. A submission that fails any item is disqualified from that match, not merely penalized.

## Recording a Result

Copy this block into `league/results/<match-id>.md` for each completed match:

```text
Match: <match-id>
Date:
Format: Arena | World
Contestants: <callsign A> vs <callsign B>
Commit hashes: <A commit> / <B commit>
Winner:
Score breakdown: (fill in from the tables above)
Replay link/file:
Notes:
```
