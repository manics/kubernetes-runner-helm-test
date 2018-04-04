#!/bin/sh

set -eu

# Required environment variables:
test -n "$CI_ENVIRONMENT_NAME"
JUPYTERHUB_PREFIX="${CI_ENVIRONMENT_NAME#*-}"
test -n "$JUPYTERHUB_PREFIX"
# Since we're running inside a Kubernetes pod we can use internal kube-dns
JUPYTERHUB_URL="http://proxy-public.jupyterhub-${CI_ENVIRONMENT_NAME}/${JUPYTERHUB_PREFIX}"

# Is this necessary? Or should helm --wait take care of this?
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
