#!/bin/bash
# shellcheck disable=SC2034

export WORKFLOW_ID="38942441"
export REF="actions"
export RUN_ID="hugo-site/01/01"
export DOCKERFILE_TEMPLATE="./_actions/docker/hugo-site.Dockerfile"
export DOCKERFILE="hugo-site.Dockerfile"
export WORK_DIR="/github/workspace"
export SCRIPT="./_actions/src/hugo-site.sh"
export HUGO_BIN_SOURCE="./hugo/hugo"
export HUGO_BIN_DEST="/go/hugo"
export HUGO_BIN_PATH="./hugo"
export HUGO_REPO="https://github.com/gohugoio/hugo"
export HUGO_HASH="bfebd8c02cfc0d4e4786e0f64932d832d3976e92"
export HUGO_BUILD_ARGS="--tags\\nextended"
export DOCS_DIR="./test/hugo-site"
export SITE_DIR="./test/hugo-site/site"
export PUBLIC_DIR="./_actions/public"
export PUBLIC_CACHE="hugo-site-01-01"
