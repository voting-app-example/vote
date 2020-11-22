#!/bin/sh

set -e

TAG=$(echo $GITHUB_SHA | head -c7)

REGISTRY_BASE_URL="registry.digitalocean.com/voting-app-example"

docker build \
 -t $REGISTRY_BASE_URL/vote:latest \
 -t $REGISTRY_BASE_URL/vote:$TAG .

mkdir -p $GITHUB_WORKSPACE/coverage

docker run \
    --rm \
    -v $GITHUB_WORKSPACE/coverage:/app/coverage \
    $REGISTRY_BASE_URL/vote:$TAG /bin/sh test/run_unit_tests.sh
