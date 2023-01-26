#!/bin/bash
# sh.wrap - module system for bash

## # version.correct.spec.sh
##
## Test cases to verify correctness of lib/version.sh TE core library module.
##

# shellcheck disable=SC1091

source "${SHWRAP_TEST_TE_ROOT}"/test_case.sh

## # `test___shwrap_te_lib_version__versinfo_format___success_args_1`
##
## Check that a call to the library function with valid arguments is successful.
##
test___shwrap_te_lib_version__versinfo_format___success_args_1()
{
	local error
	error=$(!(
				trap 'declare -p CMD_INFO' EXIT;
				! ___shwrap_te_lib_version__versinfo_format BASH_SOURCE
			))
	local expected_error="return.*___STLE___SUCCESS"
	[[ "${error}" =~ ${expected_error} ]]
}

## # `test___shwrap_te_lib_version__versinfo_format___success_args_2`
##
## Check that a call to the library function with valid arguments is successful.
##
test___shwrap_te_lib_version__versinfo_format___success_args_2()
{
	local args _args
	readarray -t -d $'\n' args < \
			  <(printf '%s\n' $(echo -n {"major","minor","patch"}))
	for _args in "${args[@]}"; do
		local error
		error=$(!(
					trap 'declare -p CMD_INFO' EXIT;
					! ___shwrap_te_lib_version__versinfo_format \
					  BASH_SOURCE ${_args}
				))
		local expected_error="return.*___STLE___SUCCESS"
		[[ "${error}" =~ ${expected_error} ]]
	done
}

## # `test___shwrap_te_lib_version__versinfo_format___success_args_3`
##
## Check that a call to the library function with valid arguments is successful.
##
test___shwrap_te_lib_version__versinfo_format___success_args_3()
{
	local args _args
	readarray -t -d $'\n' args < \
			  <(printf '%s %s\n' \
					   $(echo -n {"major ","minor ","patch "}{"'' ","'.' "}))
	for _args in "${args[@]}"; do
		local error
		error=$(!(
					trap 'declare -p CMD_INFO' EXIT;
					! ___shwrap_te_lib_version__versinfo_format \
					  BASH_SOURCE ${_args}
				))
		local expected_error="return.*___STLE___SUCCESS"
		[[ "${error}" =~ ${expected_error} ]]
	done
}
