#!/bin/bash

## # gh.spec.sh
##
## Test suites for GH bugs.
##

# shellcheck disable=SC1091

source "${BASH_SOURCE[0]%/*}"/../te/test_suite.sh

## # `test_bug_gh__001`
##
## Test suite for GH bugs since `0.0.1`.
##
test_bug_gh__001()
{
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/gh_001.spec.sh
}

## # `test_bug_gh__bash44`
##
## Test suite for GH regression testing of GH bugs.
##
test_bug_gh__bash44()
{
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/gh_001.spec.sh \
		-f test_bug_gh_001__bash44
}

## # `test_bug_gh__all`
##
## Test suite for regression testing of GH bugs.
##
test_bug_gh__all()
{
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/gh_001/*.spec.sh
}

# == bash-4.4
if [[ "$(___shwrap_te_lib_version__versinfo_format minor)" -eq 44 ]]; then
## # `test_bug_gh__bash_eq_44`
##
## Test suite for GH bugs since `0.0.1` specific to bash==4.4.
##
test_bug_gh__bash_eq_44()
{
	env VERBOSE=true "$0" "${SHWRAP_TEST_SUITE_DIR}"/bug/gh_001.spec.sh \
		-f test_bug_gh_001__bash_eq_44
}
fi
