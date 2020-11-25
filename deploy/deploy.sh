#!/bin/sh

set -e

TEMPLATE_FILE="$GITHUB_WORKSPACE/deploy/templates/vote-deployment.template.yaml"

sed 's/<TAG>/'$TAG'/g' $TEMPLATE_FILE > $GITHUB_WORKSPACE/deploy/manifests/vote-deployment.yaml

KUBECONFIG_FILE="$GITHUB_WORKSPACE/deploy/kubeconfig.yml"

echo $KUBECONFIG_FILE

cat $KUBECONFIG_FILE

kubectl --kubeconfig=$KUBECONFIG_FILE apply -f $GITHUB_WORKSPACE/deploy/manifests/
