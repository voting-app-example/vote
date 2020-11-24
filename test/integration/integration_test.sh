#!/bin/sh

set -e

PUPPETEER_CONFIG=$(echo '{"helpers": {"Puppeteer": {"url": "<URL>:5000"}}}' | sed 's/<URL>/'$VOTE_PUBLIC_IP'/g')

INTEGRATION_DIRECTORY="$GITHUB_WORKSPACE/test/integration"

docker run -v $INTEGRATION_DIRECTORY:/tests codeception/codeceptjs \
    codeceptjs run --reporter mochawesome --override "$PUPPETEER_CONFIG" --steps