#!/bin/bash
# sh.wrap - module system for bash

## # test_suite.sh
##
## TE module for test suite.
##

# shellcheck source=test/te/test_runner.sh
source "${BASH_SOURCE[0]%/*}"/test_runner.sh

declare -xg SHWRAP_TEST_SUITE_FILE
SHWRAP_TEST_SUITE_FILE=$(___shwrap_te_lib_util__caller_filename)
declare -xg SHWRAP_TEST_SUITE_DIR
SHWRAP_TEST_SUITE_DIR=$(dirname "${SHWRAP_TEST_SUITE_FILE}")
