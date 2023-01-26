#!/bin/bash
# sh.wrap - module system for bash

## # test_suite.spec.sh
##
## Test cases to validate functionality of test_suite.sh TE core module.
##

# shellcheck disable=SC1091

source "${SHWRAP_TEST_TE_ROOT}"/test_case.sh

## # `setup`
##
## Test cases setup.
##
setup()
{
	export SHWRAP_SELFTEST_TE_ROOT="${SHWRAP_TEST_TE_ROOT}"

	# unset test runner variables
	unset SHWRAP_TEST_WORK_DIR
	unset SHWRAP_SRC_ROOT
	unset SHWRAP_TEST_ROOT
	unset SHWRAP_TEST_TE_ROOT
	unset SHWRAP_TEST_LIB_ROOT
	# unset test library variables
	unset SHWRAP_TEST_TE_LIB_ROOT
	# unset test suite variables
	unset SHWRAP_TEST_SUITE_FILE
	unset SHWRAP_TEST_SUITE_DIR

	source "${SHWRAP_SELFTEST_TE_ROOT}"/test_suite.sh
}

## # `test___shwrap_te_core__test_suite___success_1`
##
## Check that global variables are set correctly.
##
test___shwrap_te_core__test_suite___success_1()
{
	# check test runner variables
	[[ -v SHWRAP_TEST_SUITE_FILE ]]
	[[ -v SHWRAP_TEST_SUITE_DIR ]]
	[[ -f "${SHWRAP_TEST_SUITE_FILE}" ]]
	[[ -d "${SHWRAP_TEST_SUITE_DIR}" ]]
	# check test library variables
	[[ -v SHWRAP_TEST_TE_LIB_ROOT ]]
	[[ -d "${SHWRAP_TEST_TE_LIB_ROOT}" ]]
	# check test suite variables
	[[ -v SHWRAP_TEST_WORK_DIR ]]
	[[ -v SHWRAP_SRC_ROOT ]]
	[[ -v SHWRAP_TEST_ROOT ]]
	[[ -v SHWRAP_TEST_TE_ROOT ]]
	[[ -v SHWRAP_TEST_LIB_ROOT ]]
	[[ -d "${SHWRAP_TEST_WORK_DIR}" ]]
	[[ -d "${SHWRAP_SRC_ROOT}" ]]
	[[ -d "${SHWRAP_TEST_ROOT}" ]]
	[[ -d "${SHWRAP_TEST_TE_ROOT}" ]]
	[[ -d "${SHWRAP_TEST_LIB_ROOT}" ]]
}
