#!/bin/bash
# sh.wrap - module system for bash

## # error.func.spec.sh
##
## Test cases to validate functionality of lib/error.sh TE core library module.
##

# shellcheck disable=SC1091

source "${SHWRAP_TEST_TE_ROOT}"/test_case.sh

## # `test___shwrap_te_lib_error___success_1`
##
## Check that error codes are declared as expected.
##
test___shwrap_te_lib_error___success_1()
{
	[[ "${___STLE___SUCCESS}" == 0 ]]
	[[ "${___STLE___ERROR}" == 1 ]]
	[[ "${___STLE__GE___ERROR_NO_FILE}" == 125 ]]
	[[ "${___STLE__GE___ERROR_EVAL_FAILED}" == 124 ]]
}

## # `test___shwrap_te_lib_error___success_2`
##
## Check that global variables are set as expected.
##
test___shwrap_te_lib_error___success_2()
{
	[[ "${___STLE___PATTERN}" == '___STL.*___ERROR.*=[0-9]\+' ]]
}

## # `test___shwrap_te_lib_error__get_errors___success_1`
##
## Check that no error codes are declared in the case of no defined errors in a
## file.
##
test___shwrap_te_lib_error__get_errors___success_1()
{
	local pattern='SHWRAP_TEST_DATA___ERROR.*=[0-9]\+'
	local stdout
	stdout=$(___shwrap_te_lib_error__get_errors "${BASH_SOURCE[0]}" "${pattern}"
			 echo "${!SHWRAP_TEST_DATA___ERROR*}")
	[[ -z "${stdout}" ]]
}

## # `test___shwrap_te_lib_error__get_errors___success_2`
##
## Check that no error codes are declared in the case of pattern matches an
## error code in a comment.
##
test___shwrap_te_lib_error__get_errors___success_2()
{
	local pattern='SHWRAP_TEST_DATA___ERROR.*=[0-9]\+'
	local stdout
	stdout=$(___shwrap_te_lib_error__get_errors "${SHWRAP_TEST_CASE_DATA}"/test___shwrap_te_lib_error__get_errors___success_2/comment/comment.sh "${pattern}"
			 echo "${!SHWRAP_TEST_DATA___ERROR*}")
	[[ -z "${stdout}" ]]
}

## # `test___shwrap_te_lib_error__get_errors___success_3`
##
## Check that all error codes are declared in the case of a default pattern
## matches.
##
test___shwrap_te_lib_error__get_errors___success_3()
{
	local stdout
	stdout=$({
				___shwrap_te_lib_error__get_errors "${SHWRAP_TEST_CASE_DATA}"/test___shwrap_te_lib_error__get_errors___success_3/default/default.sh
				echo "${!___STLE__STD*}"
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="___STLE__STD_F1___ERROR_1 ___STLE__STD_F1___ERROR_2 ___STLE__STD_F2___ERROR_1 ___STLE__STD_F2___ERROR_2"
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test___shwrap_te_lib_error__get_errors___success_4`
##
## Check that all error codes are declared in the case of a given pattern
## matches.
##
test___shwrap_te_lib_error__get_errors___success_4()
{
	local pattern='SHWRAP_TEST_DATA.*___ERROR.*=[0-9]\+'
	local stdout
	stdout=$({
				___shwrap_te_lib_error__get_errors "${SHWRAP_TEST_CASE_DATA}"/test___shwrap_te_lib_error__get_errors___success_4/pattern/pattern.sh "${pattern}"
				echo "${!SHWRAP_TEST_DATA*}"
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="SHWRAP_TEST_DATA_F1___ERROR_1 SHWRAP_TEST_DATA_F1___ERROR_2 SHWRAP_TEST_DATA_F2___ERROR_1 SHWRAP_TEST_DATA_F2___ERROR_2"
	[[ "${stdout}" == "${expected_stdout}" ]]
}
