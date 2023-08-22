#!/bin/bash
set -ex
namespace=${INPUT_COLLECTION#*/}
registry=${INPUT_COLLECTION%/$namespace}
devcontainer features -r "$registry" -n "$namespace"
