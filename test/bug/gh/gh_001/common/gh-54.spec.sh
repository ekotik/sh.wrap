#!/bin/bash
# sh.wrap - module system for bash

## # gh-54.spec.sh
##
## Test cases for bug GH-54.
##

# shellcheck disable=SC1091

source "${SHWRAP_TEST_TE_ROOT}"/test_case.sh
source "${SHWRAP_TEST_LIB_ROOT}"/init/init.sh

## ## `test_bug_gh__gh_54`
##
## Check initialization when `SHWRAP_INIT_DIR` is not set.
##
test_bug_gh__gh_54()
{
	___shwrap_te_common_init__init_default_src
}
