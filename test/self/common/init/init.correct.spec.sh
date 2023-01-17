#!/bin/bash
# sh.wrap - module system for bash

## # init.correct.spec.sh
##
## Test cases to verify correctness of init/init.sh TE library module.
##

# shellcheck disable=SC1091

source "${SHWRAP_TEST_TE_ROOT}"/test_case.sh

source "${SHWRAP_TEST_LIB_ROOT}"/init/init.sh

## # `test___shwrap_te_common_init__init_default___success_args_1`
##
## Check that a call to the library function with valid arguments is
## successful.
##
test___shwrap_te_common_init__init_default___success_args_1()
{
	local init_dir="${SHWRAP_TEST_CASE_DATA}"/_common/src
	local SHWRAP_TEST_DATA__MODULE="NOK"
	___shwrap_te_common_init__init_default "${init_dir}"
	[[ "${SHWRAP_TEST_DATA__MODULE}" == "OK" ]]
	[[ "${SHWRAP_INIT_DIR}" == "${init_dir}" ]]
}

## # `test___shwrap_te_common_init__init_default_src___success_env_1`
##
## Check that a call to the library function with valid environment is
## successful.
##
test___shwrap_te_common_init__init_default_src___success_env_1()
{
	SHWRAP_SRC_ROOT="${SHWRAP_TEST_CASE_DATA}"/_common/src
	local SHWRAP_TEST_DATA__MODULE="NOK"
	___shwrap_te_common_init__init_default_src
	[[ "${SHWRAP_TEST_DATA__MODULE}" == "OK" ]]
	[[ "${SHWRAP_INIT_DIR}" == "${SHWRAP_SRC_ROOT}" ]]
}

## # `test___shwrap_te_common_init__init_user___success_args_1`
##
## Check that a call to the library function with valid arguments is
## successful.
##
test___shwrap_te_common_init__init_user___success_args_1()
{
	local init_dir="${SHWRAP_TEST_CASE_DATA}"/_common/src
	local SHWRAP_TEST_DATA__MODULE="NOK"
	___shwrap_te_common_init__init_user "${init_dir}"
	[[ "${SHWRAP_TEST_DATA__MODULE}" == "OK" ]]
	[[ "${SHWRAP_INIT_DIR}" == "${init_dir}" ]]
}

## # `test___shwrap_te_common_init__init_user_src___success_env_1`
##
## Check that a call to the library function with valid environment is
## successful.
##
test___shwrap_te_common_init__init_user_src___success_env_1()
{
	SHWRAP_SRC_ROOT="${SHWRAP_TEST_CASE_DATA}"/_common/src
	local SHWRAP_TEST_DATA__MODULE="NOK"
	___shwrap_te_common_init__init_user_src
	[[ "${SHWRAP_TEST_DATA__MODULE}" == "OK" ]]
	[[ "${SHWRAP_INIT_DIR}" == "${SHWRAP_SRC_ROOT}" ]]
}
