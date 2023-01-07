#!/bin/bash
# sh.wrap - module system for bash

# common.spec.sh
# Module tests for common.sh

# shellcheck disable=SC1091

__init_user()
{
	declare -g SHWRAP_INIT_DIR
	SHWRAP_INIT_DIR=$(realpath "./src")
	source "${SHWRAP_INIT_DIR}"/init.sh;
}

__stubs_empty()
{
	__shwrap_md5sum() { :; }
	__shwrap_random_bytes() { :; }
}

__source()
{
	__stubs_empty
	local shwrap_init_dir
	shwrap_init_dir=$(realpath "./src")
	source "${shwrap_init_dir}"/common.sh
}

: "test_shwrap_id

This test checks that SHWRAP_ID is not equal for different shells.
"
test_shwrap_id()
{
	__init_user
	declare -fx __init_user
	local shwrap_id_sub
	shwrap_id_sub=$(bash -c '__init_user; echo ${SHWRAP_ID}')
	[[ -n "${shwrap_id_sub}" ]] && [[ "${SHWRAP_ID}" != "${shwrap_id_sub}" ]]
}

: "test_shwrap_globals

This test checks that global variables are declared global in common.sh module.
"
test_common_globals()
{
	__source
	[ -v SHWRAP_ID ]
	[ -v SHWRAP_FD_FUNC ]
	[ -v SHWRAP_FD_RANDOM_MAXTRY ]
	[ -v SHWRAP_FD_RANGE ]
	[ -v SHWRAP_MODULE ]
	[ -v SHWRAP_MODULE_PATH ]
	[ -v SHWRAP_MODULE_PATHS ]
	[ -v SHWRAP_TMP_PATH ]
	[ -v _SHWRAP_FD_FUNC ]
	[ -v _SHWRAP_FD_RANDOM_MAXTRY ]
	[ -v _SHWRAP_FD_RANGE ]
	[ -v _SHWRAP_ID ]
	[ -v _SHWRAP_MODULE ]
	[ -v _SHWRAP_MODULE_PATH ]
	[ -v _SHWRAP_TMP_PATH ]
	# shellcheck disable=SC2154
	{
		declare -p _shwrap_modules > /dev/null
		declare -p _shwrap_modules_deps > /dev/null
		declare -p _shwrap_modules_hashes > /dev/null
		declare -p _shwrap_modules_names > /dev/null
		declare -p _shwrap_modules_partials > /dev/null
		declare -p _shwrap_modules_parts > /dev/null
		declare -p _shwrap_modules_paths > /dev/null
		declare -p _shwrap_scope > /dev/null
		declare -p _shwrap_fds > /dev/null
		declare -p _shwrap_modules_stack > /dev/null
	}
}
