#!/bin/bash

## # unit.spec.sh
##
## Test suites for unit tests.
##

# shellcheck disable=SC1091

source "${BASH_SOURCE[0]%/*}"/te/test_suite.sh

## # `test_unit__correct`
##
## Test suite to verify correctness of modules.
##
test_unit__correct()
{
	env VERBOSE=true "$0" \
		"${SHWRAP_TEST_SUITE_DIR}"/unit/util.spec.sh -f test_unit_util__correct
}

## # `test_unit__all`
##
## Test suite for regression testing of modules.
##
test_unit__all()
{
	env VERBOSE=true "$0" \
		"${SHWRAP_TEST_SUITE_DIR}"/unit/util.spec.sh -f test_unit_util__all
}
