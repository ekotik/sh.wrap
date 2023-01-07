#!/bin/bash
# sh.wrap - module system for bash

# init.sh
# Initialization script intended to be in user shell profile.

[[ -n "${SHWRAP_INIT_DIR}" ]] || SHWRAP_INIT_DIR=$(dirname "${BASH_SOURCE[0]}")
declare -xg SHWRAP_INIT_DIR

# shellcheck source=src/module.sh
source "${SHWRAP_INIT_DIR}"/module.sh

shwrap_import "${SHWRAP_INIT_DIR}"/module.sh
