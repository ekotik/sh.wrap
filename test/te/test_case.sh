#!/bin/bash
# sh.wrap - module system for bash

## # test_case.sh
##
## TE module for test case.
##

# shellcheck source=test/te/test_runner.sh
source "${BASH_SOURCE[0]%/*}"/test_runner.sh

declare -xg SHWRAP_TEST_CASE_FILE
SHWRAP_TEST_CASE_FILE=$(realpath "$(___shwrap_te_lib_util__caller_filename)")
declare -xg SHWRAP_TEST_CASE_DIR
SHWRAP_TEST_CASE_DIR=$(dirname "${SHWRAP_TEST_CASE_FILE}")

declare -xg SHWRAP_TEST_CASE_DIR_REL
if [[ "${SHWRAP_TEST_WORK_DIR}" == "/" ]]; then
	# shellcheck disable=SC2295
	# don't bother
	SHWRAP_TEST_CASE_DIR_REL=./"${SHWRAP_TEST_CASE_DIR#$(pwd)}"
else
	# shellcheck disable=SC2295
	# don't bother
	SHWRAP_TEST_CASE_DIR_REL=./"${SHWRAP_TEST_CASE_DIR#$(pwd)\/}"
fi

declare -xg SHWRAP_TEST_CASE_DATA="${SHWRAP_TEST_CASE_DIR}"/test_data
