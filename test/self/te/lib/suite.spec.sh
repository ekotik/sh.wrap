#!/bin/bash
# sh.wrap - module system for bash

## # suite.spec.sh
##
## Test suites to validate and verify lib/suite.sh TE core library module.
##

# shellcheck disable=SC1091

source "${BASH_SOURCE[0]%/*}"/../../../te/test_suite.sh

## # `test_self_te_lib_suite__correct`
##
## Test suite to verify correctness of lib/suite.sh TE core library module.
##
test_self_te_lib_suite__correct()
{
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/suite/suite.correct.spec.sh
}

## # `test_self_te_lib_suite__error`
##
## Test suite to verify error detection of lib/suite.sh TE core library module.
##
test_self_te_lib_suite__error()
{
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/suite/suite.error.spec.sh
}

## # `test_self_te_lib_suite__func`
##
## Test suite to validate functionality of lib/suite.sh TE module.
##
test_self_te_lib_suite__func()
{
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/suite/suite.func.spec.sh
}

## # `test_self_te_lib_suite__security`
##
## Test suite to verify security of lib/suite.sh TE core library module.
##
test_self_te_lib_suite__security()
{
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/suite/suite.secure.spec.sh
}

## # `test_self_te_lib_suite__all`
##
## Test suite for regression testing of lib/suite.sh TE module.
##
test_self_te_lib_suite__all()
{
	env -u VERBOSE "$0" \
		"${SHWRAP_TEST_SUITE_DIR}"/suite/suite.correct.spec.sh \
		"${SHWRAP_TEST_SUITE_DIR}"/suite/suite.error.spec.sh \
		"${SHWRAP_TEST_SUITE_DIR}"/suite/suite.func.spec.sh \
		"${SHWRAP_TEST_SUITE_DIR}"/suite/suite.secure.spec.sh
}
