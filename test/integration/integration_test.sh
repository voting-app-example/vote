#!/bin/sh

set -e

PLAYWRIGHT_CONFIG=$(echo '{"helpers": {"Playwright": {"url": "<URL>:5000"}}}' | sed 's/<URL>/'$VOTE_PUBLIC_IP'/g')

npx codeceptjs run --reporter mochawesome --override "$PUPPETEER_CONFIG" --steps