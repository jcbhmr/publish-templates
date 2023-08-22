#!/bin/bash
set -ex
namespace=${INPUT_COLLECTION#*/}
registry=${INPUT_COLLECTION%/$namespace}
devcontainer features publish -r "$registry" -n "$namespace"
