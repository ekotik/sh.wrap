#!/bin/bash
# sh.wrap - module system for bash

## # common.func.spec.sh
##
## Test cases to validate functionality of stubs/common.sh TE library module.
##

# shellcheck disable=SC1091

source "${SHWRAP_TEST_TE_ROOT}"/test_case.sh

source "${SHWRAP_TEST_LIB_ROOT}"/stubs/common.sh

## # `test___shwrap_te_common_stubs_common__empty_stubs___success_1`
##
## Check that empty stubs are defined successfully.
##
test___shwrap_te_common_stubs_common__empty_stubs___success_1()
{
	___shwrap_te_common_stubs_common__empty_stubs

	declare -F __shwrap_md5sum > /dev/null
	declare -F __shwrap_random_bytes > /dev/null
}

## # `test___shwrap_te_common_stubs_common__source_common___success_1`
##
## Check that common.sh module is successfully executed with empty stubs.
##
test___shwrap_te_common_stubs_common__source_common___success_1()
{
	! [[ -v SHWRAP_ID ]]

	___shwrap_te_common_stubs_common__source_common

	[[ -v SHWRAP_ID ]]
	[[ -z "${SHWRAP_ID}" ]]
}
