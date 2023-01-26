#!/bin/bash
# sh.wrap - module system for bash

## # correct.spec.sh
##
## Test cases to verify correctness of util.sh module.
##

# shellcheck disable=SC1091

source "${SHWRAP_TEST_TE_ROOT}"/test_case.sh

## # `setup`
##
## Test cases setup.
##
setup()
{
	source "${SHWRAP_SRC_ROOT}"/util.sh
}

## # `test___util__shwrap_log___success_env_1`
##
## Check that a call to the module function with valid environment is
## successful.
##
test___util__shwrap_log___success_env_1()
{
	declare -xg SHWRAP_MODULE_LOG=true
	__shwrap_log "nothing"
}

## # `test___util__shwrap_log___success_env_2`
##
## Check that a call to the module function with valid environment is
## successful.
##
test___util__shwrap_log___success_env_2()
{
	unset SHWRAP_MODULE_LOG
	__shwrap_log "nothing"
}
