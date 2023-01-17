#!/bin/bash

## # all.spec.sh
##
## Test suites for regression testing.
##

# shellcheck disable=SC1091

source "${BASH_SOURCE[0]%/*}"/te/test_suite.sh

## # `test__all`
##
## Test suite for regression testing.
##
test__all()
{
	local spec_filter=(
		test_bug__all			# regression testing of bugs
		test_func__all			# regression testing of functionality
		test_unit__all			# regression testing of modules
	)
	env VERBOSE=true "$0" "${SHWRAP_TEST_SUITE_DIR}"/self.spec.sh \
		-f test_self__all
	env VERBOSE=true "$0" \
		"${SHWRAP_TEST_SUITE_DIR}"/bug.spec.sh \
		"${SHWRAP_TEST_SUITE_DIR}"/func.spec.sh \
		"${SHWRAP_TEST_SUITE_DIR}"/unit.spec.sh \
		-f "$(___shwrap_te_lib_util__array_to_regex "${spec_filter[@]}")"
}
