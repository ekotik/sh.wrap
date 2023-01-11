#!/bin/bash
# shellcheck disable=SC2034

export WORKFLOW_ID="38942443"
export REF="actions"
export RUN_ID="actions/01/01"
export DOCKERFILE_TEMPLATE_GENERATE_DOCS="./_actions/docker/generate-docs.Dockerfile"
export DOCKERFILE_GENERATE_DOCS="generate-docs.Dockerfile"
export DOCKERFILE_TEMPLATE_GIT_TASKS="./_actions/docker/git-tasks.Dockerfile"
export DOCKERFILE_GIT_TASKS="git-tasks.Dockerfile"
export DOCKERFILE_TEMPLATE_HUGO_SITE="./_actions/docker/hugo-site.Dockerfile"
export DOCKERFILE_HUGO_SITE="hugo-site.Dockerfile"
export DOCKERFILE_TEMPLATE_GH_PUBLISH="./_actions/docker/git-tasks.Dockerfile"
export DOCKERFILE_GH_PUBLISH="git-tasks.Dockerfile"
export WORK_DIR="/github/workspace"
export SCRIPT_GENERATE_DOCS="./_actions/src/generate-docs.sh"
export SCRIPT_GIT_TASKS="./_actions/src/git-tasks.sh"
export SCRIPT_HUGO_SITE="./_actions/src/hugo-site.sh"
export SCRIPT_GH_PUBLISH="./_actions/src/gh-publish.sh"
export IN_DIR="./src"
export OUT_DIR="./.devdoc-out"
export OUT_CACHE="actions-generate-docs-01-01"
export DEVDOCS_REPO="https://github.com/ekotik/sh.wrap"
export DEVDOCS_BRANCH="gh-pages/test-devdocs"
export DEVDOCS_TAG="v0.0.0-test-devdocs"
export GH_BIN_SOURCE="./cli/bin/gh"
export GH_BIN_DEST="/go/gh"
export GH_BIN_PATH="./cli/bin"
export GH_REPO="https://github.com/cli/cli"
export GH_HASH="7d71f807c48600d0d8d9f393ef13387504987f1d"
export GH_BUILD_ARGS=""
export HUGO_BIN_SOURCE="./hugo/hugo"
export HUGO_BIN_DEST="/go/hugo"
export HUGO_BIN_PATH="./hugo"
export HUGO_REPO="https://github.com/gohugoio/hugo"
export HUGO_HASH="bfebd8c02cfc0d4e4786e0f64932d832d3976e92"
export HUGO_BUILD_ARGS="--tags\\nextended"
export DOCS_DIR="./_actions/test/hugo-site/site/content"
export SITE_DIR="./_actions/test/hugo-site/site"
export PUBLIC_DIR="./public"
export PUBLIC_CACHE="actions-01-01"
export GH_PAGES_REPO="https://github.com/ekotik/sh.wrap"
export GH_PAGES_BRANCH="gh-pages/test"
