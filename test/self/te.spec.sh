#!/bin/bash
# sh.wrap - module system for bash

## # te.spec.sh
##
## Test suites to validate and verify TE core.
##

# shellcheck disable=SC1091

source "${BASH_SOURCE[0]%/*}"/../te/test_suite.sh

## # `test_self_te__core`
##
## Test suite to validate and verify TE core modules.
##
test_self_te__core()
{
	env VERBOSE=true "$0" "${SHWRAP_TEST_SUITE_DIR}"/te/core.spec.sh \
		-s test_self_te_core__all
}

## # `test_self_te__lib`
##
## Test suite to validate and verify TE core library modules.
##
test_self_te__lib()
{
	env VERBOSE=true "$0" "${SHWRAP_TEST_SUITE_DIR}"/te/lib.spec.sh \
		-s test_self_te_lib__all
}

## # `test_self_te__all`
##
## Test suite for regression testing of TE core.
##
test_self_te__all()
{
	local spec_filter=(
		test_self_te_core__all
		test_self_te_lib__all
	)
	env VERBOSE=true "$0" \
		"${SHWRAP_TEST_SUITE_DIR}"/te/core.spec.sh \
		"${SHWRAP_TEST_SUITE_DIR}"/te/lib.spec.sh \
		-f "$(___shwrap_te_lib_util__array_to_regex "${spec_filter[@]}")"
}
