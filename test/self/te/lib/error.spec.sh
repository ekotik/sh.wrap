#!/bin/bash
# sh.wrap - module system for bash

## # error.spec.sh
##
## Test suites to validate and verify lib/error.sh TE core library module.
##

# shellcheck disable=SC1091

source "${BASH_SOURCE[0]%/*}"/../../../te/test_suite.sh

## # `test_self_te_lib_error__correct`
##
## Test suite to verify correctness of lib/error.sh TE core library module.
##
test_self_te_lib_error__correct()
{
	env VERBOSE=true "$0" "${SHWRAP_TEST_SUITE_DIR}"/error/error.correct.spec.sh
}

## # `test_self_te_lib_error__error`
##
## Test suite to verify error detection of lib/error.sh TE core library module.
##
test_self_te_lib_error__error()
{
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/error/error.error.spec.sh
}

## # `test_self_te_lib_error__func`
##
## Test suite to validate functionality of lib/error.sh TE module.
##
test_self_te_lib_error__func()
{
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/error/error.func.spec.sh
}

## # `test_self_te_lib_error__security`
##
## Test suite to verify security of lib/error.sh TE core library module.
##
test_self_te_lib_error__security()
{
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/error/error.secure.spec.sh
}

## # `test_self_te_lib_error__all`
##
## Test suite for regression testing of lib/error.sh TE module.
##
test_self_te_lib_error__all()
{
	env -u VERBOSE "$0" \
		"${SHWRAP_TEST_SUITE_DIR}"/error/error.correct.spec.sh \
		"${SHWRAP_TEST_SUITE_DIR}"/error/error.error.spec.sh \
		"${SHWRAP_TEST_SUITE_DIR}"/error/error.func.spec.sh \
		"${SHWRAP_TEST_SUITE_DIR}"/error/error.secure.spec.sh
}
