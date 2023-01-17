#!/bin/bash

## # gh.spec.sh
##
## Test suites for GH bugs.
##

# shellcheck disable=SC1091

source "${BASH_SOURCE[0]%/*}"/../../../te/test_suite.sh

## # `test_bug_gh__001`
##
## Test suite for GH bugs since `0.0.1`.
##
test_bug_gh__001()
{
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/gh_001/common/*.spec.sh
}

## # `test_bug_gh__all`
##
## Test suite for regression testing of GH bugs.
##
test_bug_gh__all()
{
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/gh_001/common/*.spec.sh
}
