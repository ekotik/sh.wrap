#!/bin/bash
# sh.wrap - module system for bash

## # version.error.spec.sh
##
## Test cases to verify error detection in lib/version.sh TE core library module.
##

# shellcheck disable=SC1091

source "${SHWRAP_TEST_TE_ROOT}"/test_case.sh

## # `test___shwrap_te_lib_version__versinfo_format___error_1`
##
## Check that a call to the library function with invalid arguments is failed.
##
test___shwrap_te_lib_version__versinfo_format___error_1()
{
	local error
	error=$(!(
				trap 'declare -p CMD_INFO' EXIT;
				___shwrap_te_lib_version__versinfo_format
			))
	local expected_error="return.*___STLV__VF___ERROR_NO_VERSINFO"
	[[ "${error}" =~ ${expected_error} ]]
}

## # `test___shwrap_te_lib_version__versinfo_format___error_2`
##
## Check that a call to the library function with invalid arguments is failed.
##
test___shwrap_te_lib_version__versinfo_format___error_2()
{
	local error
	error=$(!(
				trap 'declare -p CMD_INFO' EXIT;
				___shwrap_te_lib_version__versinfo_format BASH_VERSINF
			))
	local expected_error="return.*___STLV__VF___ERROR_NO_DEFINITION_FOUND"
	[[ "${error}" =~ ${expected_error} ]]
}

## # `test___shwrap_te_lib_version__versinfo_format___error_3`
##
## Check that a call to the library function with invalid arguments is failed.
##
test___shwrap_te_lib_version__versinfo_format___error_3()
{
	local error
	error=$(!(
				trap 'declare -p CMD_INFO' EXIT;
				local bash_versinfo=()
				___shwrap_te_lib_version__versinfo_format bash_versinfo
			))
	local expected_error="return.*___STLV__VF___ERROR_INVALID_VERSINFO"
	[[ "${error}" =~ ${expected_error} ]]
}

## # `test___shwrap_te_lib_version__versinfo_format___error_4`
##
## Check that a call to the library function with invalid arguments is failed.
##
test___shwrap_te_lib_version__versinfo_format___error_4()
{
	local error
	error=$(!(
				trap 'declare -p CMD_INFO' EXIT;
				___shwrap_te_lib_version__versinfo_format BASH_VERSINFO majo
			))
	local expected_error="return.*___STLV__VF___ERROR_LEVEL_NOT_SUPPORTED"
	[[ "${error}" =~ ${expected_error} ]]
}
