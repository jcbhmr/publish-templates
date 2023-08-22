#!/bin/bash
set -ex
namespace=${INPUT_COLLECTION#*/}
registry=${INPUT_COLLECTION%/$namespace}
devcontainer templates publish -r "$registry" -n "$namespace" "$INPUT_PATH"

if [[ $INPUT_UPDATE_TAGS == true ]]; then
  for id in "$INPUT_PATH"/*; do
    id=$(basename "$id")
    if [[ ! -d "$INPUT_PATH/$id" ]]; then
      continue
    fi
    version=$(jq -r .version "$INPUT_PATH/$id/devcontainer-template.json")
    tag="template_${id}_${version}"
    git tag "$tag" "$GITHUB_SHA"
    git push origin "$tag" || echo "::warning::Unable to push $tag to $(git remote get-url origin)"
  done
fi
