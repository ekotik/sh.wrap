#!/bin/bash
# sh.wrap - module system for bash

## # util.error.spec.sh
##
## Test cases to verify error detection in lib/util.sh TE core library module.
##

# shellcheck disable=SC1091

source "${SHWRAP_TEST_TE_ROOT}"/test_case.sh

## # `test___shwrap_te_lib_util__define___error_1`
##
## Check that a call to the library function with invalid arguments is failed.
##
test___shwrap_te_lib_util__define___error_1()
{
	local error
	error=$(!(
				trap 'declare -p CMD_INFO' EXIT;
				___shwrap_te_lib_util__define
			))

	local expected_error="return.*___STLU_D___ERROR_NO_DEFINITION_FOUND}"
	[[ "${error}" =~ ${expected_error} ]]
}

## # `test___shwrap_te_lib_util__define___error_2`
##
## Check that a call to the library function with invalid arguments is failed.
##
test___shwrap_te_lib_util__define___error_2()
{
	local args_id="NOT EXISTING ID"

	local error
	error=$(!(
				trap 'declare -p CMD_INFO' EXIT;
				___shwrap_te_lib_util__define "${args_id}"
			))

	local expected_error="return.*___STLU_D___ERROR_NO_DEFINITION_FOUND}"
	[[ "${error}" =~ ${expected_error} ]]
}
