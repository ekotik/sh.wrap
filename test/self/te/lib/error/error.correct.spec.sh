#!/bin/bash
# sh.wrap - module system for bash

## # error.correct.spec.sh
##
## Test cases to verify correctness of lib/error.sh TE core library module.
##

# shellcheck disable=SC1091

source "${SHWRAP_TEST_TE_ROOT}"/test_case.sh

## # `test___shwrap_te_lib_error__get_errors___success_args_1`
##
## Check that a call to the library function with valid arguments is successful.
##
test___shwrap_te_lib_error__get_errors___success_args_1()
{
	local error
	error=$(!(
				trap 'declare -p CMD_INFO' EXIT;
			   ! ___shwrap_te_lib_error__get_errors "${BASH_SOURCE[0]}"
			))
	local expected_error="return.*___STLE___SUCCESS"
	[[ "${error}" =~ ${expected_error} ]]
}

## # `test___shwrap_te_lib_error__get_errors___success_args_2`
##
## Check that a call to the library function with valid arguments is successful.
##
test___shwrap_te_lib_error__get_errors___success_args_2()
{
	local error
	error=$(!(
			   trap 'declare -p CMD_INFO' EXIT;
			   ! ___shwrap_te_lib_error__get_errors "${BASH_SOURCE[0]}" ".*"
			))
	local expected_error="return.*___STLE___SUCCESS"
	[[ "${error}" =~ ${expected_error} ]]
}
