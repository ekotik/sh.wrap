#!/bin/bash

## # gh.spec.sh
##
## Test suites for GH bugs since `0.0.1`.
##

# shellcheck disable=SC1091

source "${BASH_SOURCE[0]%/*}"/../../te/test_suite.sh

source "${SHWRAP_TEST_TE_LIB_ROOT}"/util.sh

# ___shwrap_te_lib_suite__specific_define test_bug_gh_001

## # `test_bug_gh__001`
##
## Test suite for GH bugs since `0.0.1`.
##
test_bug_gh__001()
{
	env VERBOSE=true "$0" "${SHWRAP_TEST_SUITE_DIR}"/gh_001/*.spec.sh
}

## # `test_bug_gh__all`
##
## Test suite for regression testing of GH bugs since `0.0.1`.
##
test_bug_gh__all()
{
	env VERBOSE=true "$0" "${SHWRAP_TEST_SUITE_DIR}"/gh_001/*.spec.sh
	___shwrap_te_lib_suite__specific_run test_bug_gh_001
}

## # `_test_bug_gh_001__bash_eq_44`
##
## Test suite for GH bugs since `0.0.1` specific to bash = `4.4`.
##
_test_bug_gh_001___bash_eq_44()
{
	env VERBOSE=true "$0" "${SHWRAP_TEST_SUITE_DIR}"/gh_001/bash44/gh-64.spec.sh
}

_test_bug_gh_001___bash_eq_44_or_52()
{
	env VERBOSE=true "$0" "${SHWRAP_TEST_SUITE_DIR}"/gh_001/bash44/gh-64.spec.sh
}

setup() {
___shwrap_te_lib_suite__specific_define test_bug_gh_001
}
