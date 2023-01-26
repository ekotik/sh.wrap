#!/bin/bash
# sh.wrap - module system for bash

## # `init.spec.sh`
##
## Test suites to validate and verify init TE library.
##

# shellcheck disable=SC1091

source "${BASH_SOURCE[0]%/*}"/../../te/test_suite.sh

## # `test_self_common_init__correct`
##
## Test suite to verify correctness of init TE library.
##
test_self_common_init__correct()
{
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/init/init.correct.spec.sh
}

## # `test_self_common_init__error`
##
## Test suite to verify error detection in init TE library.
##
test_self_common_init__error()
{
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/init/init.error.spec.sh
}

## # `test_self_common_init__func`
##
## Test suite to validate functionality of init TE library.
##
test_self_common_init__func()
{
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/init/init.func.spec.sh
}

## # `test_self_common_init__all`
##
## Test suite for regression testing of init TE library.
##
test_self_common_init__all()
{
	env -u VERBOSE "$0" \
		"${SHWRAP_TEST_SUITE_DIR}"/init/init.correct.spec.sh \
		"${SHWRAP_TEST_SUITE_DIR}"/init/init.error.spec.sh \
		"${SHWRAP_TEST_SUITE_DIR}"/init/init.func.spec.sh
}
