#!/bin/bash
# sh.wrap - module system for bash

## # util.spec.sh
##
## Test suites to validate and verify lib/util.sh TE core library module.
##

# shellcheck disable=SC1091

source "${BASH_SOURCE[0]%/*}"/../../../te/test_suite.sh

## # `test_self_te_lib_util__correct`
##
## Test suite to verify correctness of lib/util.sh TE core library module.
##
test_self_te_lib_util__correct()
{
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/util/util.correct.spec.sh
}

## # `test_self_te_lib_util__error`
##
## Test suite to verify error detection of lib/util.sh TE core library module.
##
test_self_te_lib_util__error()
{
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/util/util.error.spec.sh
}

## # `test_self_te_lib_util__func`
##
## Test suite to validate functionality of lib/util.sh TE module.
##
test_self_te_lib_util__func()
{
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/util/util.func.spec.sh
}

## # `test_self_te_lib_util__all`
##
## Test suite for regression testing of lib/util.sh TE module.
##
test_self_te_lib_util__all()
{
	env -u VERBOSE "$0" \
		"${SHWRAP_TEST_SUITE_DIR}"/util/util.correct.spec.sh \
		"${SHWRAP_TEST_SUITE_DIR}"/util/util.error.spec.sh \
		"${SHWRAP_TEST_SUITE_DIR}"/util/util.func.spec.sh
}
