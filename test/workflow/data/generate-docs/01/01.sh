#!/bin/bash
# shellcheck disable=SC2034

export WORKFLOW_ID="45154393"
export REF="actions"
export RUN_ID="generate-docs/01/01"
export DOCKERFILE_TEMPLATE="./_actions/docker/generate-docs.Dockerfile"
export DOCKERFILE="generate-docs.Dockerfile"
export WORK_DIR="/github/workspace"
export SCRIPT="./_actions/src/generate-docs.sh"
export IN_DIR="./src"
export OUT_DIR="./.devdoc-out"
export OUT_CACHE="generate-docs-01-01"
export OUT_CACHE_DIR="./.devdoc-out"
