#!/bin/sh

# Do not use -x as there are secret variables
set -eu

# Required environment variables:
test -n "$JUPYTERHUB_DEPLOYMENT_NAME"
test -n "$JUPYTERHUB_CHART_VERSION"
test -n "$JUPYTERHUB_DEPLOYMENT_NAME"

helm upgrade --install \
    "$JUPYTERHUB_DEPLOYMENT_NAME" \
    jupyterhub/jupyterhub \
    --version="$JUPYTERHUB_CHART_VERSION" \
    --namespace="$JUPYTERHUB_DEPLOYMENT_NAME" \
    --wait --timeout 1200 \
    "$@"

i=1
while [ $i -lt 60 ]; do
    sleep 10
    let i++
    if curl --fail -s -L --max-time 2 $JUPYTERHUB_URL/hub/api; then
        break
    fi
    echo "Waited ${i}0 seconds"
done

# Check the response contains the expected content
curl --fail -s $JUPYTERHUB_URL/hub/api | grep version
