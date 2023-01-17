#!/bin/bash
# sh.wrap - module system for bash

## # init.func.spec.sh
##
## Test cases to validate functionality of init/init.sh TE library module.
##

# shellcheck disable=SC1091

source "${SHWRAP_TEST_TE_ROOT}"/test_case.sh

source "${SHWRAP_TEST_LIB_ROOT}"/init/init.sh

## ## `___shwrap_test_case__check_initialization`
##
## Sanity check for an initialization from `args_init_dir` is successful.
##
___shwrap_test_case__check_initialization()
{
	[[ "${SHWRAP_INIT_DIR}" == "${args_init_dir}" ]]
	[[ -v _shwrap_modules_hashes["${args_init_dir}"/module.sh] ]]
}

## ## `test___shwrap_te_common_init_init__init_default___success_1`
##
## Check that initialization of sh.wrap distribution at a given path is
## successful in the case of `SHWRAP_INIT_DIR` is not set.
##
test___shwrap_te_common_init_init__init_default___success_1()
{
	local args_init_dir
	args_init_dir=$(realpath "${SHWRAP_SRC_ROOT}")
	___shwrap_te_common_init__init_default "${args_init_dir}"
	___shwrap_test_case__check_initialization
}

## ## `test___shwrap_te_common_init_init__init_default_src___success_1
##
## Check that initialization of sh.wrap distribution at a source root path is
## successful in the case of `SHWRAP_INIT_DIR` is not set.
##
test___shwrap_te_common_init_init__init_default_src___success_1()
{
	local args_init_dir
	args_init_dir=$(realpath "${SHWRAP_SRC_ROOT}")
	___shwrap_te_common_init__init_default_src
	___shwrap_test_case__check_initialization
}

## ## `test___shwrap_te_common_init_init__init_user___success_1`
##
## Check that initialization of sh.wrap distribution at a given path is
## successful in the case of `SHWRAP_INIT_DIR` is set.
##
test___shwrap_te_common_init_init__init_user___success_1()
{
	local args_init_dir
	args_init_dir=$(realpath "${SHWRAP_SRC_ROOT}")
	___shwrap_te_common_init__init_user "${args_init_dir}"
	___shwrap_test_case__check_initialization
}

## ## `test___shwrap_te_common_init_init__init_user_src___success_1`
##
## Check that initialization of sh.wrap distribution at a source root path is
## successful in the case of `SHWRAP_INIT_DIR` is set.
##
test___shwrap_te_common_init_init__init_user_src___success_1()
{
	local args_init_dir
	args_init_dir=$(realpath "${SHWRAP_SRC_ROOT}")
	___shwrap_te_common_init__init_user_src
	___shwrap_test_case__check_initialization
}
