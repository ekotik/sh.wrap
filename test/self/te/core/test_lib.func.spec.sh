#!/bin/bash
# sh.wrap - module system for bash

## # test_lib.spec.sh
##
## Test cases to validate functionality of test_lib.sh TE core module.
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

	# unset test library variables
	unset SHWRAP_TEST_TE_LIB_ROOT

	source "${SHWRAP_SELFTEST_TE_ROOT}"/test_lib.sh
}

## # `test___shwrap_te_core__test_lib___success_1`
##
## Check that global variables are set correctly.
##
test___shwrap_te_core__test_lib___success_1()
{
	# check test library variables
	[[ -v SHWRAP_TEST_TE_LIB_ROOT ]]
	[[ -d "${SHWRAP_TEST_TE_LIB_ROOT}" ]]
}
