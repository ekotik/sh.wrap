#!/bin/bash
# shellcheck disable=SC2034

export WORKFLOW_ID="XXXXXXXX"
export REF="actions"
export RUN_ID="test-runner/01/01"
export DOCKERFILE_TEMPLATE="./_actions/docker/test-runner.Dockerfile"
export DOCKERFILE="test-runner.Dockerfile"
export WORK_DIR="/github/workspace/_actions"
export SCRIPT="./src/test-runner.sh"
export BASH_DOCKER_VERSION="5.2"
export MICROSPEC_SOURCE="./test/microspec"
export MICROSPEC_DEST="/te/microspec"
export MICROSPEC_EXEC="microspec"
export MICROSPEC_ARGS=""
