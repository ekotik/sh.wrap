#!/bin/bash
# sh.wrap - module system for bash

## # lib.spec.sh
##
## Test suites to validate and verify TE core library.
##

# shellcheck disable=SC1091

source "${BASH_SOURCE[0]%/*}"/../../te/test_suite.sh

## # `test_self_te_lib__error`
##
## Test suite to validate and verify lib/error.sh TE core library module.
##
test_self_te_lib__error()
{
	env VERBOSE=true "$0" "${SHWRAP_TEST_SUITE_DIR}"/lib/error.spec.sh \
		-s test_self_te_lib_error__all
}

## # `test_self_te_lib__util`
##
## Test suite to validate and verify lib/util.sh TE core library module.
##
test_self_te_lib__util()
{
	env VERBOSE=true "$0" "${SHWRAP_TEST_SUITE_DIR}"/lib/util.spec.sh \
		-s test_self_te_lib_util__all
}

## # `test_self_te_lib__version`
##
## Test suite to validate and verify lib/version.sh TE core library module.
##
test_self_te_lib__version()
{
	env VERBOSE=true "$0" "${SHWRAP_TEST_SUITE_DIR}"/lib/version.spec.sh \
		-s test_self_te_lib_version__all
}

## # `test_self_te_lib__all`
##
## Test suite for regression testing of TE core library modules.
##
test_self_te_lib__all()
{
	local spec_filter=(
		test_self_te_lib_error__all
		test_self_te_lib_util__all
		test_self_te_lib_version__all
	)
	env VERBOSE=true "$0" \
		"${SHWRAP_TEST_SUITE_DIR}"/lib/error.spec.sh \
		"${SHWRAP_TEST_SUITE_DIR}"/lib/util.spec.sh \
		"${SHWRAP_TEST_SUITE_DIR}"/lib/version.spec.sh \
		-f "$(___shwrap_te_lib_util__array_to_regex "${spec_filter[@]}")"
}
