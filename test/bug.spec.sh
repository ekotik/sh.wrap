#!/bin/bash

## # bug.spec.sh
##
## Test suites for bugs.
##

# shellcheck disable=SC1091

source "${BASH_SOURCE[0]%/*}"/te/test_suite.sh

## # `test_bug__common`
##
## Test suite for common bugs. \
## No dependency on platform, bash version, etc.
##
test_bug__common()
{
	local spec_skip=(
		test_bug_gh__all # regression testing of GH bugs
	)
	env VERBOSE=true "$0" "${SHWRAP_TEST_SUITE_DIR}"/bug/gh.spec.sh \
		-s "$(___shwrap_te_lib_util__array_to_regex "${spec_skip[@]}")"
}

## # `test_bug__all`
##
## Test suite for regression testing of bugs.
##
test_bug__all()
{
	env VERBOSE=true "$0" "${SHWRAP_TEST_SUITE_DIR}"/bug/gh.spec.sh \
		-f test_bug_gh__all
}
