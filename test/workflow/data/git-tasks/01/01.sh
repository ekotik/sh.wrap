#!/bin/bash
# shellcheck disable=SC2034

export WORKFLOW_ID="38942442"
export REF="actions"
export RUN_ID="git-tasks/01/01"
export DOCKERFILE_TEMPLATE="./_actions/docker/git-tasks.Dockerfile"
export DOCKERFILE="git-tasks.Dockerfile"
export WORK_DIR="/github/workspace"
export SCRIPT="./_actions/src/git-tasks.sh"
export GH_BIN_SOURCE="./cli/bin/gh"
export GH_BIN_DEST="/go/gh"
export GH_BIN_PATH="./cli/bin"
export GH_REPO="https://github.com/cli/cli"
export GH_HASH="7d71f807c48600d0d8d9f393ef13387504987f1d"
export GH_BUILD_ARGS=""
export GIT_REPO="https://github.com/ekotik/sh.wrap"
export GIT_BRANCH="gh-pages/test"
export GIT_COMMANDS="git status
git log"
