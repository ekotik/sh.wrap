#!/bin/bash
# sh.wrap - module system for bash

## # common.error.spec.sh
##
## Test cases to verify error detection in stubs/common.sh TE library module.
##

# shellcheck disable=SC1091

source "${SHWRAP_TEST_TE_ROOT}"/test_case.sh

source "${SHWRAP_TEST_LIB_ROOT}"/stubs/common.sh

## # `test___shwrap_te_common_stubs_common__source_common___invalid_env_1`
##
## Check that a call to the library function with invalid environment is failed.
##
test___shwrap_te_common_stubs_common__source_common___invalid_env_1()
{
	unset SHWRAP_SRC_ROOT

	! (___shwrap_te_common_stubs_common__source_common)
}

## # `test___shwrap_te_common_stubs_common__source_common___invalid_env_2`
##
## Check that a call to the library function with invalid environment is failed.
##
test___shwrap_te_common_stubs_common__source_common___invalid_env_2()
{
	# shellcheck disable=SC2034
	# used in functions
	SHWRAP_SRC_ROOT="/not/existing/directory"

	! (___shwrap_te_common_stubs_common__source_common)
}
