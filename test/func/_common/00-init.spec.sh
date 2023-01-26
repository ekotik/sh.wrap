#!/bin/bash
# sh.wrap - module system for bash

## # 00-init.spec.sh
##
## Test cases to validate initialization functionality.
##

# shellcheck disable=SC1091

source "${SHWRAP_TEST_TE_ROOT}"/test_case.sh
source "${SHWRAP_TEST_LIB_ROOT}"/init/init.sh

## ## `test_func_init__init_default`
##
## Check initialization when `SHWRAP_INIT_DIR` is not set.
##
test_func_init__init_default()
{
	___shwrap_te_common_init__init_default_src
}

## ## `test_func_init__init_user`
##
## Check initialization when `SHWRAP_INIT_DIR` is set.
##
test_func_init__init_user()
{
	___shwrap_te_common_init__init_user_src
}

## ## `test_func_init__init_link`
##
## Check initialization from link.
##
test_func_init__init_link()
{
	___shwrap_te_common_init__init_user "${SHWRAP_TEST_CASE_DATA}"/test_func_init__init_link/sh.wrap
}

## ## `test_func_init__init_links`
##
## Check initialization from links.
##
test_func_init__init_links()
{
	___shwrap_te_common_init__init_user "${SHWRAP_TEST_CASE_DATA}"/test_func_init__init_links/sh.wrap
}
