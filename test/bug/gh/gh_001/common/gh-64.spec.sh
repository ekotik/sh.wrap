#!/bin/bash
# sh.wrap - module system for bash

## # gh-64.spec.sh
##
## Test cases for bug GH-64.
##

# shellcheck disable=SC1091

source "${BASH_SOURCE[0]%/*}"/../../../../te/test_suite.sh

source "${SHWRAP_TEST_LIB_ROOT}"/init/init.sh

## # `setup`
##
## Test cases setup.
##
setup()
{
	___shwrap_te_common_init__init_default_src
	shwrap_import "${BASH_SOURCE[0]}"
}

## ## `test_bug_gh__gh_64_1`
##
## `BASHPID` is not filtered from scope.
##
test_bug_gh__gh_64_1()
{
	local stderr
	stderr=$({
				local command='eval "$(declare -p BASHPID)";:'
				shwrap_run "${BASH_SOURCE[0]}" "${command}"
			} 2>&1 > /dev/null)
	! (cat <<< "${stderr}" | grep 'BASHPID: readonly variable')
}

## ## `test_bug_gh__gh_64_2`
##
## `BASH_REMATCH` is not filtered from scope.
##
test_bug_gh__gh_64_2()
{
	local stderr
	stderr=$({
				local command='[[ "." =~ . ]]; eval "$(declare -p BASH_REMATCH)";:'
				shwrap_run "${BASH_SOURCE[0]}" "${command}"
			} 2>&1 > /dev/null)
	! (cat <<< "${stderr}" | grep 'BASH_REMATCH: readonly variable')
}
