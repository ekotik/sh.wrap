#!/bin/bash
# sh.wrap - module system for bash

## # gh-38.spec.sh
##
## Test cases for bug GH-38.
##

# shellcheck disable=SC1091

source "${SHWRAP_TEST_TE_ROOT}"/test_case.sh
source "${SHWRAP_TEST_LIB_ROOT}"/init/init.sh

## ## `test_bug_gh__gh_38`
##
## Check that module can unset globally exported variable.
##
test_bug_gh__gh_38()
{
	___shwrap_te_common_init__init_default_src

	declare -x GLOBAL_VAR=GLOBAL_VAL
	shwrap_import "${BASH_SOURCE[0]}"
	shwrap_run "${BASH_SOURCE[0]}" 'unset GLOBAL_VAR'
	shwrap_run "${BASH_SOURCE[0]}" '! test -v GLOBAL_VAR'
}
