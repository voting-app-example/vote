#!/bin/sh

set -e

TAG=$(echo $GITHUB_SHA | head -c7)

REGISTRY_BASE_URL="registry.digitalocean.com/voting-app-example"

for t in latest $TAG; do
    docker push $REGISTRY_BASE_URL/vote:${t}
done
