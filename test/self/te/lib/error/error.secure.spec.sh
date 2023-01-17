#!/bin/bash
# sh.wrap - module system for bash

## # error.secure.spec.sh
##
## Test cases to verify security of lib/error.sh TE core library module.
##

# shellcheck disable=SC1091

source "${SHWRAP_TEST_TE_ROOT}"/test_case.sh

## # `test___shwrap_te_lib_error__get_errors___security_1`
##
## Check that a call to the library function is not vulnerable to a code
## injection.
##
test___shwrap_te_lib_error__get_errors___security_1()
{
	local stdout
	local pattern='SHWRAP_TEST_DATA___ERROR.*=[0-9]\+'
	stdout=$(___shwrap_te_lib_error__get_errors "${SHWRAP_TEST_CASE_DATA}"/test___shwrap_te_lib_error__get_errors___security_1/insecure/exploit.sh "${pattern}")
	[[ -z "${stdout}" ]]
}

## # `test___shwrap_te_lib_error__get_errors___security_2`
##
## Check that a call to the library function is not vulnerable to a code
## injection.
##
test___shwrap_te_lib_error__get_errors___security_2()
{
	local stdout
	local pattern='SHWRAP_TEST_DATA___ERROR.*=[0-9]\+'
	stdout=$(___shwrap_te_lib_error__get_errors "${SHWRAP_TEST_CASE_DATA}"/test___shwrap_te_lib_error__get_errors___security_2/insecure/exploit.sh "${pattern}")
	[[ -z "${stdout}" ]]
}

## # `test___shwrap_te_lib_error__get_errors___security_3`
##
## Check that a call to the library function is not vulnerable to a code
## injection.
##
test___shwrap_te_lib_error__get_errors___security_3()
{
	local stdout
	local pattern='SHWRAP_TEST_DATA___ERROR.*=[0-9]\+'
	stdout=$(___shwrap_te_lib_error__get_errors "${SHWRAP_TEST_CASE_DATA}"/test___shwrap_te_lib_error__get_errors___security_3/insecure/exploit_1.sh "${pattern}")
	[[ -z "${stdout}" ]]
	stdout=$(___shwrap_te_lib_error__get_errors "${SHWRAP_TEST_CASE_DATA}"/test___shwrap_te_lib_error__get_errors___security_3/insecure/exploit_2.sh "${pattern}")
	[[ -z "${stdout}" ]]
}

## # `test___shwrap_te_lib_error__get_errors___security_4`
##
## Check that a call to the library function is not vulnerable to a code
## injection.
##
test___shwrap_te_lib_error__get_errors___security_4()
{
	local stdout
	local pattern='SHWRAP_TEST_DATA___ERROR.*=[0-9]+'
	stdout=$(___shwrap_te_lib_error__get_errors "${SHWRAP_TEST_CASE_DATA}"/test___shwrap_te_lib_error__get_errors___security_4/insecure/exploit_1.sh "${pattern}")
	[[ -z "${stdout}" ]]
	stdout=$(___shwrap_te_lib_error__get_errors "${SHWRAP_TEST_CASE_DATA}"/test___shwrap_te_lib_error__get_errors___security_4/insecure/exploit_2.sh "${pattern}")
	[[ -z "${stdout}" ]]
}

## # `test___shwrap_te_lib_error__get_errors___security_5`
##
## Check that a call to the library function is not vulnerable to a code
## injection.
##
test___shwrap_te_lib_error__get_errors___security_5()
{
	local stdout
	local pattern='SHWRAP_TEST_DATA___EXPLOIT.*'
	stdout=$(___shwrap_te_lib_error__get_errors "${SHWRAP_TEST_CASE_DATA}"/test___shwrap_te_lib_error__get_errors___security_5/insecure/exploit.sh "${pattern}")
	[[ -z "${stdout}" ]]
}
