#!/bin/bash
# sh.wrap - module system for bash

## # `stubs.spec.sh`
##
## Test suites to validate and verify stubs TE library.
##

# shellcheck disable=SC1091

source "${BASH_SOURCE[0]%/*}"/../../te/test_suite.sh

## # `test_self_common_stubs__common`
##
## Test suite to validate functionality of stubs/common.sh TE library module.
##
test_self_common_stubs__common()
{
	env VERBOSE=true "$0" "${SHWRAP_TEST_SUITE_DIR}"/stubs/common.spec.sh \
		-s test_self_common_stubs_common__all
}

## # `test_self_common_stubs__all`
##
## Test suite for regression testing of stubs TE library.
##
test_self_common_stubs__all()
{
	env VERBOSE=true "$0" "${SHWRAP_TEST_SUITE_DIR}"/stubs/common.spec.sh \
		-f test_self_common_stubs_common__all
}
