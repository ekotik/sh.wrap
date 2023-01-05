#!/bin/bash
# sh.wrap - module system for bash

# common.spec.sh
# Module tests for common.sh

# shellcheck disable=SC1091

setup()
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
	declare -fx setup
	local shwrap_id_sub
	shwrap_id_sub=$(bash -c 'setup; echo ${SHWRAP_ID}')
	[[ -n "${shwrap_id_sub}" ]] && [[ "${SHWRAP_ID}" != "${shwrap_id_sub}" ]]
}
