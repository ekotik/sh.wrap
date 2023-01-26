#!/bin/bash
# sh.wrap - module system for bash

## # 001.spec.sh
##
## Test suites to validate functionality since `0.0.1`.
##

# shellcheck disable=SC1091

source "${BASH_SOURCE[0]%/*}"/../te/test_suite.sh

declare -a init_spec_skip=(
	test_func_init__init_link # GH-63
	test_func_init__init_links # GH-63
)

## # `test_func_001__settings`
##
## Test suite to validate settings functionality since `0.0.1`.
##
test_func_001__settings()
{
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/_common/00-init.spec.sh \
		-s "$(___shwrap_te_lib_util__array_to_regex "${init_spec_skip[@]}")"
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/001/01-settings.spec.sh
}

## # `test_func_001__import`
##
## Test suite to validate import functionality since `0.0.1`.
##
test_func_001__import()
{
	declare -a spec_skip=(
		test_func_import__cyclical_import_4	# GH-XX
		test_func_import__cyclical_import_9	# GH-XX
		test_func_import__import_relative_links # GH-63
		test_func_import__import_absolute_links # GH-63
	)
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/_common/00-init.spec.sh \
		-s "$(___shwrap_te_lib_util__array_to_regex "${init_spec_skip[@]}")"
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/001/01-import.spec.sh \
		-s "$(___shwrap_te_lib_util__array_to_regex "${spec_skip[@]}")"
}

## # `test_func_001__run`
##
## Test suite to validate run functionality since `0.0.1`.
##
test_func_001__run()
{
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/_common/00-init.spec.sh \
		-s "$(___shwrap_te_lib_util__array_to_regex "${init_spec_skip[@]}")"
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/001/01-run.spec.sh
}

## # `test_func_001__all`
##
## Test suite for regression testing of functionality since `0.0.1`.
##
test_func_001__all()
{
	env -u VERBOSE "$0" "${SHWRAP_TEST_SUITE_DIR}"/_common/00-init.spec.sh
	env -u VERBOSE "$0" \
		"${SHWRAP_TEST_SUITE_DIR}"/001/01-settings.spec.sh \
		"${SHWRAP_TEST_SUITE_DIR}"/001/01-import.spec.sh \
		"${SHWRAP_TEST_SUITE_DIR}"/001/01-run.spec.sh
}
