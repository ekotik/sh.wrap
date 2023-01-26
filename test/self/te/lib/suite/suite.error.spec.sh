#!/bin/bash
# sh.wrap - module system for bash

## # suite.error.spec.sh
##
## Test cases to verify error detection in lib/suite.sh TE core library module.
##

# shellcheck disable=SC1091

source "${SHWRAP_TEST_TE_ROOT}"/test_case.sh

## # `test___shwrap_te_lib_suite__specific_check___error_1`
##
## Check that a call to the library function with valid arguments is failed as
## expected.
##
test___shwrap_te_lib_suite__specific_check___error_1()
{
	___STLS___SPECIFIC_CHECK_PREFIX="___STD___"
	___STLS___SPECIFIC_CHECK_SUFFIX="_CHECK"
	local args_suffix="not_specific"

	local error
	error=$(!(
				source "${SHWRAP_TEST_CASE_DATA}/_common/suite/check.sh"
				trap 'declare -p CMD_INFO' EXIT;
				___shwrap_te_lib_suite__specific_check "${args_suffix}"
			))

	local expected_error="return.*___STLS__SC___ERROR_NOT_SPECIFIC"
	[[ "${error}" =~ ${expected_error} ]]
}

## # `test___shwrap_te_lib_suite__specific_check___error_2`
##
## Check that a call to the library function with valid arguments is failed as
## expected.
##
test___shwrap_te_lib_suite__specific_check___error_2()
{
	___STLS___SPECIFIC_CHECK_PREFIX="___STD___"
	___STLS___SPECIFIC_CHECK_SUFFIX="_NOT_EXISTING_CHECK"
	local args_suffix="specific"

	local error
	error=$(!(
				source "${SHWRAP_TEST_CASE_DATA}/_common/suite/check.sh"
				trap 'declare -p CMD_INFO' EXIT;
				___shwrap_te_lib_suite__specific_check "${args_suffix}"
			))

	local expected_error="return.*___STLS__SC___ERROR_NO_CHECK"
	[[ "${error}" =~ ${expected_error} ]]
}

## # `test___shwrap_te_lib_suite__specific_check___invalid_args_1`
##
## Check that a call to the library function with invalid arguments is failed.
##
test___shwrap_te_lib_suite__specific_check___invalid_args_1()
{
	___STLS___SPECIFIC_CHECK_PREFIX="___STD___"
	___STLS___SPECIFIC_CHECK_SUFFIX="_CHECK"

	local error
	error=$(!(
				source "${SHWRAP_TEST_CASE_DATA}/_common/suite/check.sh"
				trap 'declare -p CMD_INFO' EXIT;
				___shwrap_te_lib_suite__specific_check
				___shwrap_te_lib_suite__specific_check $''
			))

	local expected_error="return.*___STLE___ERROR"
	[[ "${error}" =~ ${expected_error} ]]
}
