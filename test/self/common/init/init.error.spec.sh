#!/bin/bash
# sh.wrap - module system for bash

## # init.error.spec.sh
##
## Test cases to verify error detection in init/init.sh TE library module.
##

# shellcheck disable=SC1091

source "${SHWRAP_TEST_TE_ROOT}"/test_case.sh

source "${SHWRAP_TEST_LIB_ROOT}"/init/init.sh

## # `test___shwrap_te_common_init_init___error_1`
##
## Check that calls to the library functions with invalid arguments are failed.
##
test___shwrap_te_common_init_init___error_1()
{
	! (___shwrap_te_common_init__init_default)
	! (___shwrap_te_common_init__init_user)
}

## # `test___shwrap_te_common_init_init___invalid_args_1`
##
## Check that calls to the library functions with invalid arguments are failed.
##
test___shwrap_te_common_init_init___invalid_args_1()
{
	local args_init_dir="/not/existing/directory"
	! (___shwrap_te_common_init__init_default "${args_init_dir}")
	! (___shwrap_te_common_init__init_user "${args_init_dir}")
}

## # `test___shwrap_te_common_init_init___invalid_env_1`
##
## Check that calls to the library functions with invalid environment are
## failed.
##
test___shwrap_te_common_init_init___invalid_env_1()
{
	unset SHWRAP_SRC_ROOT
	! (___shwrap_te_common_init__init_default_src)
	! (___shwrap_te_common_init__init_user_src)
}

## # `test___shwrap_te_common_init_init___invalid_env_2`
##
## Check that calls to the library functions with invalid environment are
## failed.
##
test___shwrap_te_common_init_init___invalid_env_2()
{
	# shellcheck disable=SC2034
	# used in functions
	SHWRAP_SRC_ROOT="/not/existing/directory"
	! (___shwrap_te_common_init__init_default_src)
	! (___shwrap_te_common_init__init_user_src)
}
