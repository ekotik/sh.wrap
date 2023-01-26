#!/bin/bash
# sh.wrap - module system for bash

## # error.error.spec.sh
##
## Test cases to verify error detection in lib/error.sh TE core library module.
##

# shellcheck disable=SC1091

source "${SHWRAP_TEST_TE_ROOT}"/test_case.sh

## # `test___shwrap_te_lib_error__get_errors___error_1`
##
## Check that a call to the library function with invalid arguments is failed.
##
test___shwrap_te_lib_error__get_errors___error_1()
{
	local error
	error=$(!(
				trap 'declare -p CMD_INFO' EXIT;
				___shwrap_te_lib_error__get_errors
			))
	local expected_error="return.*___STLE__GE___ERROR_NO_FILE"
	[[ "${error}" =~ ${expected_error} ]]
}

## # `test___shwrap_te_lib_error__get_errors___error_2`
##
## Check that a call to the library function with invalid data is failed.
##
test___shwrap_te_lib_error__get_errors___error_2()
{
	local pattern='SHWRAP_TEST_DATA___ERROR.*=[0-9]\+'
	local error
	error=$(!(
				trap 'declare -p CMD_INFO' EXIT;
				___shwrap_te_lib_error__get_errors "${SHWRAP_TEST_CASE_DATA}"/test___shwrap_te_lib_error__get_errors___error_2/error/error.sh "${pattern}" 2> /dev/null
			))
	local expected_error="return.*___STLE__GE___ERROR_EVAL_FAILED"
	[[ "${error}" =~ ${expected_error} ]]
}
