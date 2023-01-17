#!/bin/bash
# sh.wrap - module system for bash

## # version.spec.sh
##
## Test suites to validate and verify lib/version.sh TE core library module.
##

# shellcheck disable=SC1091

source "${BASH_SOURCE[0]%/*}"/../../../te/test_suite.sh

## # `test_self_te_lib_version__correct`
##
## Test suite to verify correctness of lib/version.sh TE core library module.
##
test_self_te_lib_version__correct()
{
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/version/version.correct.spec.sh
}

## # `test_self_te_lib_version__error`
##
## Test suite to verify error detection of lib/version.sh TE core library module.
##
test_self_te_lib_version__error()
{
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/version/version.error.spec.sh
}

## # `test_self_te_lib_version__func`
##
## Test suite to validate functionality of lib/version.sh TE module.
##
test_self_te_lib_version__func()
{
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/version/version.func.spec.sh
}

## # `test_self_te_lib_version__security`
##
## Test suite to verify security of lib/version.sh TE core library module.
##
test_self_te_lib_version__security()
{
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/version/version.secure.spec.sh
}

## # `test_self_te_lib_version__all`
##
## Test suite for regression testing of lib/version.sh TE module.
##
test_self_te_lib_version__all()
{
	env -u VERBOSE "$0" \
		"${SHWRAP_TEST_SUITE_DIR}"/version/version.correct.spec.sh \
		"${SHWRAP_TEST_SUITE_DIR}"/version/version.error.spec.sh \
		"${SHWRAP_TEST_SUITE_DIR}"/version/version.func.spec.sh \
		"${SHWRAP_TEST_SUITE_DIR}"/version/version.secure.spec.sh
}
