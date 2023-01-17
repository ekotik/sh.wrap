#!/bin/bash
# sh.wrap - module system for bash

## # test_runner.sh
##
## TE module for test runner.
##

# shellcheck source=test/te/test_lib.sh
source "${BASH_SOURCE[0]%/*}"/test_lib.sh

declare -xg SHWRAP_TEST_WORK_DIR
SHWRAP_TEST_WORK_DIR="$(pwd)"

declare -xg SHWRAP_SRC_ROOT
SHWRAP_SRC_ROOT=$(realpath "${BASH_SOURCE[0]%/*}"/../../src)
declare -xg SHWRAP_TEST_ROOT
SHWRAP_TEST_ROOT=$(realpath "${BASH_SOURCE[0]%/*}"/..)

declare -xg SHWRAP_TEST_TE_ROOT="${SHWRAP_TEST_ROOT}"/te
declare -xg SHWRAP_TEST_LIB_ROOT="${SHWRAP_TEST_ROOT}"/common

declare -axgr SHWRAP_TEST_SPECIFIC_SUITES__BASH_VERSION=(
	bash_eq_44
	bash_and_gdb
)
declare -axgr SHWRAP_TEST_SPECIFIC_SUITES=(
	"${SHWRAP_TEST_SPECIFIC_SUITES__BASH_VERSION[@]}"
)
