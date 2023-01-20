#!/bin/bash
# sh.wrap - module system for bash

## # gh-63.spec.sh
##
## Test cases for bug GH-63.
##

# shellcheck disable=SC1091

## ## `test_func_init__init_link`
##
## Check initialization from link.
##
test_func_init__init_link()
{
	local shwrap_init_dir="${BASH_SOURCE[0]%/*}"/test_data/test_func_init__init_link/sh.wrap
	declare -g SHWRAP_INIT_DIR
	# shellcheck disable=SC2034
	# used in initialization
	SHWRAP_INIT_DIR="${shwrap_init_dir}"
	# shellcheck source=src/init.sh
	source "${shwrap_init_dir}"/init.sh
}

## ## `test_func_init__init_links`
##
## Check initialization from links.
##
test_func_init__init_links()
{
	local shwrap_init_dir="${BASH_SOURCE[0]%/*}"/test_data/test_func_init__init_links/sh.wrap
	declare -g SHWRAP_INIT_DIR
	# shellcheck disable=SC2034
	# used in initialization
	SHWRAP_INIT_DIR="${shwrap_init_dir}"
	# shellcheck source=src/init.sh
	source "${shwrap_init_dir}"/init.sh
}
