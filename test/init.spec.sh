#!/bin/bash
# sh.wrap - module system for bash

# init.spec.1.sh
# Module tests for init.sh

# shellcheck disable=SC1091

__init_user()
{
	declare -g SHWRAP_INIT_DIR
	SHWRAP_INIT_DIR=$(realpath "./src")
	source "${SHWRAP_INIT_DIR}"/init.sh;
}

: "test_init_globals

This test checks that global variables are declared global in init.sh module.
"
test_init_globals()
{
	__init_user
	[ -v SHWRAP_INIT_DIR ]
}
