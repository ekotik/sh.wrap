#!/bin/bash
# sh.wrap - module system for bash

## # gh-64.spec.sh
##
## Test cases for bug GH-64.
##

# shellcheck disable=SC1091

## # `setup`
##
## Test cases setup.
##
setup()
{
	local shwrap_src_dir
	shwrap_src_dir=$(realpath "./src")
	source "${shwrap_src_dir}"/init.sh
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
				# shellcheck disable=SC2016
				# intentional use of single quotes
				local command='eval "$(__shwrap_scope)";:'
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
				# shellcheck disable=SC2016
				# intentional use of single quotes
				local command='[[ "." =~ . ]]; eval "$(__shwrap_scope)";:'
				shwrap_run "${BASH_SOURCE[0]}" "${command}"
			} 2>&1 > /dev/null)
	! (cat <<< "${stderr}" | grep 'BASH_REMATCH: readonly variable')
}
