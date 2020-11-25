#!/bin/sh

set -e

TAG=$(echo $GITHUB_SHA | head -c7)

TEMPLATE_FILE="$GITHUB_WORKSPACE/deploy/templates/vote-deployment.template.yaml"

sed 's/<TAG>/'$TAG'/g' $TEMPLATE_FILE > $GITHUB_WORKSPACE/deploy/manifests/vote-deployment.yaml

KUBECONFIG_FILE="$GITHUB_WORKSPACE/deploy/kubeconfig.yml"

kubectl --kubeconfig=$KUBECONFIG_FILE apply -f $GITHUB_WORKSPACE/deploy/manifests/

kubectl --kubeconfig=$KUBECONFIG_FILE rollout restart deployment/vote -n vote