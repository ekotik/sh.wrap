#!/bin/bash
# sh.wrap - module system for bash

# init.spec.sh
# Module tests for init.sh

# shellcheck disable=SC1091

__init()
{
	local shwrap_init_dir
	shwrap_init_dir=$(realpath "./src")
	source "${shwrap_init_dir}"/init.sh
}

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

: "test_shwrap_init

This test checks initialization when SHWRAP_INIT_DIR is unset.
"
test_shwrap_init()
{
	__init
}
