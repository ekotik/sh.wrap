#!/bin/bash
# sh.wrap - module system for bash

# common.spec.sh
# Module tests for common.sh

# shellcheck disable=SC1091

__init_user()
{
	local SHWRAP_INIT_DIR
	SHWRAP_INIT_DIR=$(realpath "./src")
	source "${SHWRAP_INIT_DIR}"/init.sh;
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
