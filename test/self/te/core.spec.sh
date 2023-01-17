#!/bin/bash
# sh.wrap - module system for bash

## # lib.spec.sh
##
## Test suites to validate and verify TE core.
##

# shellcheck disable=SC1091

source "${BASH_SOURCE[0]%/*}"/../../te/test_suite.sh

## # `test_self_te_core__func`
##
## Test suite to validate functionality of TE core modules.
##
test_self_te_core__func()
{
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/core/test_case.func.spec.sh
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/core/test_lib.func.spec.sh
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/core/test_runner.func.spec.sh
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/core/test_suite.func.spec.sh
}

## # `test_self_te_core__all`
##
## Test suite for regression testing of TE core modules.
##
test_self_te_core__all()
{
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/core/test_*.*.spec.sh
}
