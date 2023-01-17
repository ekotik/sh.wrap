#!/bin/bash
# sh.wrap - module system for bash

## # suite.correct.spec.sh
##
## Test cases to verify correctness of lib/suite.sh TE core library module.
##

# shellcheck disable=SC1091

source "${SHWRAP_TEST_TE_ROOT}"/test_case.sh

## # `test___shwrap_te_lib_suite__specific_check___success_args_1`
##
## Check that a call to the library function with valid arguments is successful.
##
test___shwrap_te_lib_suite__specific_check___success_args_1()
{
	___STLS___SPECIFIC_CHECK_PREFIX="___STD___"
	___STLS___SPECIFIC_CHECK_SUFFIX="_CHECK"
	local args_suffix="specific"

	local error
	error=$(!(
				source "${SHWRAP_TEST_CASE_DATA}/_common/suite/check.sh"
				trap 'declare -p CMD_INFO' EXIT;
				! ___shwrap_te_lib_suite__specific_check "${args_suffix}"
			))

	local expected_error="return.*___STLE___SUCCESS"
	[[ "${error}" =~ ${expected_error} ]]
}
