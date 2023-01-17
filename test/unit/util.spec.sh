#!/bin/bash
# sh.wrap - module system for bash

## # util.spec.sh
##
## Test suites to validate and verify util.sh module.
##

# shellcheck disable=SC1091,SC2034

source "${BASH_SOURCE[0]%/*}"/../te/test_suite.sh

## # `test_unit_util__correct`
##
## Test suite to verify correctness of util.sh module.
##
test_unit_util__correct()
{
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/util/correct.spec.sh
}

## # `test_unit_util__all`
##
## Test suite for regression testing of util.sh module.
##
test_unit_util__all()
{
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/util/correct.spec.sh
}
