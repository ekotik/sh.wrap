#!/bin/bash
# sh.wrap - module system for bash

## # util.spec.sh
##
## Test cases to validate functionality of lib/util.sh TE module.
##

# shellcheck disable=SC1091

source "${SHWRAP_TEST_TE_ROOT}"/test_case.sh

## # `test___shwrap_te_lib_util__array_to_regex___success_1`
##
## Check that empty string is returned for empty array.
##
test___shwrap_te_lib_util__array_to_regex___success_1()
{
	local args_arr=()

	local stdout
	stdout=$(___shwrap_te_lib_util__array_to_regex "${args_arr[@]}")

	local expected_stdout=""
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test___shwrap_te_lib_util__array_to_regex___success_2`
##
## Check that a correct regex expression returned for a non-empty array.
##
test___shwrap_te_lib_util__array_to_regex___success_2()
{
	local args_arr=(1 2 3)

	local stdout
	stdout=$(___shwrap_te_lib_util__array_to_regex "${args_arr[@]}")

	local expected_stdout="1\|2\|3"
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test___shwrap_te_lib_util__define___success_1`
##
## Check that a correct definition is found for an existing identifier.
##
test___shwrap_te_lib_util__define___success_1()
{
	local args_id="bash_version"

	local bash_version=(1 2 3 4 5 6)
	local stdout
	stdout=$(___shwrap_te_lib_util__define "${args_id}")

	local expected_stdout='([0]="1" [1]="2" [2]="3" [3]="4" [4]="5" [5]="6")'
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test___shwrap_te_lib_util__caller_filename___success_1`
##
## Check that a caller filename is correct.
##
test___shwrap_te_lib_util__caller_filename___success_1()
{
	local stdout
	stdout=$(source "${SHWRAP_TEST_CASE_DATA}"/test___shwrap_te_lib_util__caller_filename___success_1/caller/caller.sh)

	local expected_stdout="${SHWRAP_TEST_CASE_DATA}"/test___shwrap_te_lib_util__caller_filename___success_1/caller/caller.sh
	[[ "${stdout}" == "${expected_stdout}" ]]
}
