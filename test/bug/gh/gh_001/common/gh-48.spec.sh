#!/bin/bash
# sh.wrap - module system for bash

## # gh-48.spec.sh
##
## Test cases for bug GH-48.
##

# shellcheck disable=SC1091

source "${SHWRAP_TEST_TE_ROOT}"/test_case.sh
source "${SHWRAP_TEST_LIB_ROOT}"/init/init.sh

## ## `test_bug_gh__gh_48`
##
## Check that `SHWRAP_ID` is not equal for different shells.
##
test_bug_gh__gh_48()
{
	___shwrap_te_common_init__init_user_src

	declare -fx ___shwrap_te_common_init__init_user
	declare -fx ___shwrap_te_common_init__init_user_src
	local shwrap_id_sub
	shwrap_id_sub=$(bash -c '___shwrap_te_common_init__init_user_src; echo ${SHWRAP_ID}')
	[[ -n "${shwrap_id_sub}" ]] && [[ "${SHWRAP_ID}" != "${shwrap_id_sub}" ]]
}
