#!/bin/bash
# sh.wrap - module system for bash

## # version.func.spec.sh
##
## Test cases to validate functionality of lib/version.sh TE core library module.
##

# shellcheck disable=SC1091

source "${SHWRAP_TEST_TE_ROOT}"/test_case.sh

## # `test___shwrap_te_lib_version___success_1`
##
## Check that error codes are declared as expected.
##
test___shwrap_te_lib_version___success_1()
{
	[[ "${___STLV__VF___ERROR_NO_VERSINFO}" == 125 ]]
	[[ "${___STLV__VF___ERROR_NO_DEFINITION_FOUND}" == 124 ]]
	[[ "${___STLV__VF___ERROR_INVALID_VERSINFO}" == 123 ]]
	[[ "${___STLV__VF___ERROR_LEVEL_NOT_SUPPORTED}" == 122 ]]
}

## # `test___shwrap_te_lib_version__versinfo_format___success_1`
##
## Check that a version array is formatted as expected in the case of no
## optional arguments given.
##
test___shwrap_te_lib_version__versinfo_format___success_1()
{
	local stdout
	stdout=$(___shwrap_te_lib_version__versinfo_format BASH_VERSINFO)
	local expected_stdout="${BASH_VERSINFO[@]: 0:3}"
	expected_stdout="${expected_stdout// /}"
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test___shwrap_te_lib_version__versinfo_format___success_2`
##
## Check that a version array is formatted as expected in the case of all
## arguments given.
##
test___shwrap_te_lib_version__versinfo_format___success_2()
{
	local bash_versinfo=(1 2 3 4 5 6)
	local levels=(major minor patch)
	local delimiters=($'' $'.')

	local _level _delimiter
	local stdout
	stdout=$(
		for _level in "${levels[@]}"; do
			for _delimiter in "${delimiters[@]}"; do
				___shwrap_te_lib_version__versinfo_format \
					bash_versinfo "${_level}" "${_delimiter}"
			done
		done)
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="1 1 12 1.2 123 1.2.3"
	[[ "${stdout}" == "${expected_stdout}" ]]
}
