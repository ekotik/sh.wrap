#!/bin/bash
# sh.wrap - module system for bash

## # common.spec.sh
##
## Test suites to validate and verify TE library.
##

# shellcheck disable=SC1091

source "${BASH_SOURCE[0]%/*}"/../te/test_suite.sh

## # `test_self_common__init`
##
## Test suite to validate and verify init TE library.
##
test_self_common__init()
{
	env VERBOSE=true "$0" "${SHWRAP_TEST_SUITE_DIR}"/common/init.spec.sh \
		-s test_self_common_init__all
}

## # `test_self_common__stubs`
##
## Test suite to validate and verify stubs TE library.
##
test_self_common__stubs()
{
	env VERBOSE=true "$0" "${SHWRAP_TEST_SUITE_DIR}"/common/stubs.spec.sh \
		-s test_self_common_stubs__all
}

## # `test_self_common__all`
##
## Test suite for regression testing of TE library.
##
test_self_common__all()
{
	local spec_filter=(
		test_self_common_init__all
		test_self_common_stubs__all
	)
	env VERBOSE=true "$0" \
		"${SHWRAP_TEST_SUITE_DIR}"/common/init.spec.sh \
		"${SHWRAP_TEST_SUITE_DIR}"/common/stubs.spec.sh \
		-f "$(___shwrap_te_lib_util__array_to_regex "${spec_filter[@]}")"
}
