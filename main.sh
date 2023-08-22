#!/bin/bash
set -ex
namespace=${INPUT_COLLECTION#*/}
registry=${INPUT_COLLECTION%/$namespace}
devcontainer features publish -r "$registry" -n "$namespace" "$INPUT_PATH"

if [[ $INPUT_TAG == true ]]; then
  for id in "$INPUT_PATH"/*; do
    id=$(basename "$id")
    if [[ ! -d "$INPUT_PATH/$id" ]]; then
      continue
    fi
    version=$(jq -r .version "$INPUT_PATH/$id/devcontainer-feature.json")
    tag="feature_${id}_${version}"
    git tag "$tag" "$GITHUB_SHA"
    git push origin "$tag" || echo "::warn::Unable to push $tag to $(git remote get-url origin)"
  done
fi
