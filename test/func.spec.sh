#!/bin/bash

## # func.spec.sh
##
## Test suites for functional tests.
##

# shellcheck disable=SC1091

source "${BASH_SOURCE[0]%/*}"/te/test_suite.sh

## # `test_func__basic`
##
## Test suite to validate basic functionality.
##
test_func__basic()
{
	env VERBOSE=true "$0" \
		"${SHWRAP_TEST_SUITE_DIR}"/func/001.spec.sh -s test_func_001__all
}

## # `test_func__all`
##
## Test suite for regression testing of functionality.
##
test_func__all()
{
	env VERBOSE=true "$0" \
		"${SHWRAP_TEST_SUITE_DIR}"/func/001.spec.sh -f test_func_001__all
}
