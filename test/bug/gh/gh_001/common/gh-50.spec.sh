#!/bin/bash
# sh.wrap - module system for bash

## # gh-50.spec.sh
##
## Test cases for bug GH-50.
##

# shellcheck disable=SC1091

source "${SHWRAP_TEST_TE_ROOT}"/test_case.sh
source "${SHWRAP_TEST_LIB_ROOT}"/init/init.sh
source "${SHWRAP_TEST_LIB_ROOT}"/stubs/common.sh

## ## `test_bug_gh__gh_50_1`
##
## Check that global variables are declared global in common.sh module.
##
test_bug_gh__gh_50_1()
{
	___shwrap_te_common_stubs_common__source_common

	[ -v SHWRAP_ID ]
	[ -v SHWRAP_FD_FUNC ]
	[ -v SHWRAP_FD_RANDOM_MAXTRY ]
	[ -v SHWRAP_FD_RANGE ]
	[ -v SHWRAP_MODULE ]
	[ -v SHWRAP_MODULE_PATH ]
	[ -v SHWRAP_MODULE_PATHS ]
	[ -v SHWRAP_TMP_PATH ]
	[ -v _SHWRAP_FD_FUNC ]
	[ -v _SHWRAP_FD_RANDOM_MAXTRY ]
	[ -v _SHWRAP_FD_RANGE ]
	[ -v _SHWRAP_ID ]
	[ -v _SHWRAP_MODULE ]
	[ -v _SHWRAP_MODULE_PATH ]
	[ -v _SHWRAP_TMP_PATH ]
	# shellcheck disable=SC2154
	{
		declare -p _shwrap_modules > /dev/null
		declare -p _shwrap_modules_deps > /dev/null
		declare -p _shwrap_modules_hashes > /dev/null
		declare -p _shwrap_modules_names > /dev/null
		declare -p _shwrap_modules_partials > /dev/null
		declare -p _shwrap_modules_parts > /dev/null
		declare -p _shwrap_modules_paths > /dev/null
		declare -p _shwrap_scope > /dev/null
		declare -p _shwrap_fds > /dev/null
		declare -p _shwrap_modules_stack > /dev/null
	}
}

## ## `test_bug_gh__gh_50_2`
##
## Check that global variables are declared global in init.sh module.
##
test_bug_gh__gh_50_2()
{
	___shwrap_te_common_init__init_user_src

	[ -v SHWRAP_INIT_DIR ]
}
