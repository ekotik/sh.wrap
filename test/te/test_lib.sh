#!/bin/bash
# sh.wrap - module system for bash

## # test_lib.sh
##
## TE modules.
##

declare -g SHWRAP_TEST_TE_LIB_ROOT="${BASH_SOURCE[0]%/*}"/lib

# shellcheck source=test/te/lib/error.sh
source "${SHWRAP_TEST_TE_LIB_ROOT}"/error.sh
# shellcheck source=test/te/lib/util.sh
source "${SHWRAP_TEST_TE_LIB_ROOT}"/util.sh
# shellcheck source=test/te/lib/version.sh
source "${SHWRAP_TEST_TE_LIB_ROOT}"/version.sh
# shellcheck source=test/te/lib/suite.sh
source "${SHWRAP_TEST_TE_LIB_ROOT}"/suite.sh
