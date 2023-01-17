#!/bin/bash
# sh.wrap - module system for bash

## # suite.func.spec.sh
##
## Test cases to validate functionality of lib/suite.sh TE core library module.
##

# shellcheck disable=SC1091

source "${SHWRAP_TEST_TE_ROOT}"/test_case.sh

## # `test___shwrap_te_lib_suite___success_1`
##
## Check that error codes are declared as expected.
##
test___shwrap_te_lib_suite___success_1()
{
	[[ "${___STLS__SC___ERROR_NOT_SPECIFIC}" == 125 ]]
	[[ "${___STLS__SC___ERROR_NO_CHECK}" == 124 ]]
}

## # `test___shwrap_te_lib_suite___success_2`
##
## Check that global variables are set as expected.
##
test___shwrap_te_lib_suite___success_2()
{
	[[ "${___STLS___SPECIFIC_PREFIX}" == "_test_" ]]
	[[ "${___STLS___SPECIFIC_CHECK_PREFIX}" == "___STLS___" ]]
	[[ "${___STLS___SPECIFIC_CHECK_SUFFIX}" == "_CHECK" ]]
	[[ "${___STLS___SPECIFIC_STATUS}" == 0 ]]
}

## # `test___shwrap_te_lib_suite__specific_check___success_args_1`
##
## Check that a specific check function is called as expected in the case of all
## arguments given.
##
test___shwrap_te_lib_suite__specific_check___success_1()
{
	___STLS___SPECIFIC_CHECK_PREFIX="___STD___"
	___STLS___SPECIFIC_CHECK_SUFFIX="_CHECK"
	local args_suffix="specific"

	local stdout
	stdout=$({
				source "${SHWRAP_TEST_CASE_DATA}/_common/suite/check.sh"
				___shwrap_te_lib_suite__specific_check "${args_suffix}"
			})

	local expected_stdout="specific 2"
	echo [[ "${stdout}" == "${expected_stdout}" ]]
}
