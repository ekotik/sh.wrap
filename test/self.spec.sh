#!/bin/bash
# sh.wrap - module system for bash

## # self.spec.sh
##
## Test suites for TE selftests.
##

# shellcheck disable=SC1091

source "${BASH_SOURCE[0]%/*}"/te/test_suite.sh

## # `test_self__env`
##
## Test suite to verify correctness of TE environment.
##
test_self__te()
{
	env VERBOSE=true "$0" "${SHWRAP_TEST_SUITE_DIR}"/self/te.spec.sh \
		-s test_self_te__all
}

## # `test_self__lib`
##
## Test suite to verify correctness of TE library.
##
test_self__common()
{
	env VERBOSE=true "$0" "${SHWRAP_TEST_SUITE_DIR}"/self/common.spec.sh \
		-s test_self_common__all
}

## # `test_self__lib`
##
## Test suite for regression testing of TE library.
##
test_self__all()
{
	local spec_filter=(
		test_self_te__all			# regression testing of TE
		test_self_common__all		# regression testing of TE library
	)
	env VERBOSE=true "$0" \
		"${SHWRAP_TEST_SUITE_DIR}"/self/te.spec.sh \
		"${SHWRAP_TEST_SUITE_DIR}"/self/common.spec.sh \
		-f "$(___shwrap_te_lib_util__array_to_regex "${spec_filter[@]}")"
}
