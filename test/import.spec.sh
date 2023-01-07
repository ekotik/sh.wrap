#!/bin/bash
# sh.wrap - module system for bash

# import.spec.sh
# Module tests for import.sh

# shellcheck disable=SC1091

__init()
{
	local shwrap_init_dir
	shwrap_init_dir=$(realpath "./src")
	source "${shwrap_init_dir}"/init.sh
}

: "test_set

This test checks that globally exported variable is visible in the module scope
"
test_set()
{
	__init
	declare -x GLOBAL_VAR=GLOBAL_VAL
	shwrap_import "${BASH_SOURCE[0]}"
	shwrap_run "${BASH_SOURCE[0]}" 'test -v GLOBAL_VAR'
}

test_unset()
{
	__init
	declare -x GLOBAL_VAR=GLOBAL_VAL
	shwrap_import "${BASH_SOURCE[0]}"
	shwrap_run "${BASH_SOURCE[0]}" 'unset GLOBAL_VAR'
	shwrap_run "${BASH_SOURCE[0]}" '! test -v GLOBAL_VAR'
}
