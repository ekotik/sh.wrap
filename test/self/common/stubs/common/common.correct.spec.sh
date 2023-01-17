#!/bin/bash
# sh.wrap - module system for bash

## # common.correct.spec.sh
##
## Test cases to verify correctness of stubs/common.sh TE library module.
##

# shellcheck disable=SC1091

source "${SHWRAP_TEST_TE_ROOT}"/test_case.sh

source "${SHWRAP_TEST_LIB_ROOT}"/stubs/common.sh

## # `test___shwrap_te_common_stubs_common__source_common___success_env_1`
##
## Check that a call to the library function with valid environment is
## successful.
##
test___shwrap_te_common_stubs_common__source_common___success_env_1()
{
	# shellcheck disable=SC2034
	# used in functions
	SHWRAP_SRC_ROOT="${SHWRAP_TEST_CASE_DATA}"/_common/src

	local SHWRAP_TEST_DATA__COMMON="NOK"
	___shwrap_te_common_stubs_common__source_common

	[[ "${SHWRAP_TEST_DATA__COMMON}" == "OK" ]]
}
