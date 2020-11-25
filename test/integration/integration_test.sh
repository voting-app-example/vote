#!/bin/sh

set -e

PLAYWRIGHT_CONFIG=$(echo '{"helpers": {"Playwright": {"url": "http://<URL>:5000"}}}' | sed 's/<URL>/'$VOTE_PUBLIC_IP'/g')

npx codeceptjs run --reporter mochawesome --override "$PLAYWRIGHT_CONFIG" --steps