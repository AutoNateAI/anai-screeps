#!/usr/bin/env bash
set -euo pipefail

ROOM="${1:?Usage: sparring-loop.sh <room-name> [wave-count] [delay-seconds]}"
WAVES="${2:-3}"
DELAY="${3:-30}"

for i in $(seq 1 "$WAVES"); do
  echo "Wave $i/$WAVES against $ROOM..."
  curl -s -X POST "http://localhost:21025/local/api/sparring/wave" \
    -H 'Content-Type: application/json' \
    -d "{\"room\": \"$ROOM\"}"
  echo
  if [ "$i" -lt "$WAVES" ]; then
    echo "Waiting ${DELAY}s before the next wave..."
    sleep "$DELAY"
  fi
done
