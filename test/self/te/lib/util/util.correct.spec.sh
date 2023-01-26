#!/bin/bash
# sh.wrap - module system for bash

## # util.correct.spec.sh
##
## Test cases to verify correctness of lib/util.sh TE core library module.
##

# shellcheck disable=SC1091

source "${SHWRAP_TEST_TE_ROOT}"/test_case.sh

## # `test___shwrap_te_lib_util__define___success_args_1`
##
## Check that a call to the library function with valid arguments is successful.
##
test___shwrap_te_lib_util__define___success_args_1()
{
	local args_id="BASH_VERSINFO"

	local error
	error=$(!(
				trap 'declare -p CMD_INFO' EXIT;
				! ___shwrap_te_lib_util__define "${args_id}"
			))

	local expected_error="return.*___STLE___SUCCESS"
	[[ "${error}" =~ ${expected_error} ]]
}
