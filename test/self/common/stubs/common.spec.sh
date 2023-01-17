#!/bin/bash
# sh.wrap - module system for bash

## # `common.spec.sh`
##
## Test suites to validate and verify stubs/common.sh TE library module.
##

# shellcheck disable=SC1091

source "${BASH_SOURCE[0]%/*}"/../../../te/test_suite.sh

## # `test_self_common_stubs_common__correct`
##
## Test suite to verify correctness of stubs/common.sh TE library module.
##
test_self_common_stubs_common__correct()
{
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/common/common.correct.spec.sh
}

## # `test_self_common_stubs_common__error`
##
## Test suite to verify error detection in stubs/common.sh TE library module.
##
test_self_common_stubs_common__error()
{
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/common/common.error.spec.sh
}

## # `test_self_common_stubs_common__func`
##
## Test suite to validate functionality of stubs/common.sh TE library module.
##
test_self_common_stubs_common__func()
{
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/common/common.func.spec.sh
}

## # `test_self_common_stubs_common__all`
##
## Test suite for regression testing of stubs/common.sh TE library module.
##
test_self_common_stubs_common__all()
{
	env -u VERBOSE "$0" \
		"${SHWRAP_TEST_SUITE_DIR}"/common/common.correct.spec.sh \
		"${SHWRAP_TEST_SUITE_DIR}"/common/common.error.spec.sh \
		"${SHWRAP_TEST_SUITE_DIR}"/common/common.func.spec.sh
}
