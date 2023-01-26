#!/bin/bash
# sh.wrap - module system for bash

## # suite.secure.spec.sh
##
## Test cases to verify security of lib/suite.sh TE core library module.
##

# shellcheck disable=SC1091

source "${SHWRAP_TEST_TE_ROOT}"/test_case.sh

## ## `test___shwrap_te_lib_suite__specific_run___security_1`
##
## Check that a call to the library function is not vulnerable to a code
## injection.
##
test___shwrap_te_lib_suite__specific_run___security_1()
{
	local stdout
	stdout=$(!(
				 source "${SHWRAP_TEST_CASE_DATA}"/test___shwrap_te_lib_suite__specific_run___security_1/insecure_1/exploit.sh
				 ___shwrap_te_lib_suite__specific_run "${args_prefix}"
			 ))

	[[ -z "${stdout}" ]]

	stdout=$(!(
				 source "${SHWRAP_TEST_CASE_DATA}"/test___shwrap_te_lib_suite__specific_run___security_1/insecure_2/exploit.sh
				 ___shwrap_te_lib_suite__specific_run "${args_prefix}"
			 ))

	[[ -z "${stdout}" ]]
}

## ## `test___shwrap_te_lib_suite__specific_run___security_2`
##
## Check that a call to the library function is not vulnerable to a code
## injection.
##
test___shwrap_te_lib_suite__specific_run___security_2()
{
	local stdout
	stdout=$(!(
				 source "${SHWRAP_TEST_CASE_DATA}"/test___shwrap_te_lib_suite__specific_run___security_2/insecure_1/exploit.sh
				 ___shwrap_te_lib_suite__specific_run "${args_prefix}"
				 source "${SHWRAP_TEST_CASE_DATA}"/test___shwrap_te_lib_suite__specific_run___security_2/insecure_2/exploit.sh
				 ___shwrap_te_lib_suite__specific_run "${args_prefix}"
			 ))

	[[ -z "${stdout}" ]]
}

## ## `test___shwrap_te_lib_suite__specific_run___security_3`
##
## Check that a call to the library function is not vulnerable to a code
## injection.
##
test___shwrap_te_lib_suite__specific_run___security_3()
{
	local stdout
	stdout=$(!(
				 source "${SHWRAP_TEST_CASE_DATA}"/_common/readonly/insecure/exploit.sh
				 ___shwrap_te_lib_suite__specific_run "${args_prefix}"
			 ))

	[[ -z "${stdout}" ]]
}

## ## `_test___shwrap_te_lib_suite__specific_run___security_4__bash_and_gdb`
##
## Check that a call to the library function is not vulnerable to a code
## injection.
##
## ### Prerequisites:
##
## - `bash`
## - `gdb`
##
_test___shwrap_te_lib_suite__specific_run___security_4___bash_and_gdb()
{
	gdb -ex 'call (void) unbind_variable("SHWRAP_TEST_SPECIFIC_SUITES")' --pid=$$ --batch &> /dev/null

	local stdout
	stdout=$(!(
				 source "${SHWRAP_TEST_CASE_DATA}"/_common/readonly/insecure/exploit.sh
				 ___shwrap_te_lib_suite__specific_run "${args_prefix}"
			 ))

	[[ -z "${stdout}" ]]
}

___shwrap_te_lib_suite__specific_define \
	test___shwrap_te_lib_suite__specific_run___security_4
