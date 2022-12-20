#!/bin/bash
# sh.wrap - module system for bash
# common.sh
# Common global, environment variables and function definitions for them.

declare -x _SHWRAP_MODULE_PATH=~/.sh.wrap
declare -x _SHWRAP_MODULE="${SHWRAP_INIT_DIR}"/module.sh
declare -x _SHWRAP_TMP_PATH=/tmp/sh.wrap
declare -ax SHWRAP_MODULE_PATHS

[[ -n "${SHWRAP_MODULE_PATH}" ]] ||
	declare -x SHWRAP_MODULE_PATH="${_SHWRAP_MODULE_PATH}"
[[ -n "${SHWRAP_MODULE}" ]] ||
	declare -x SHWRAP_MODULE="${_SHWRAP_MODULE}"
[[ -n "${SHWRAP_TMP_PATH}" ]] ||
	declare -x SHWRAP_TMP_PATH="${_SHWRAP_TMP_PATH}"
[[ -n "${SHWRAP_MODULE_PATHS[*]}" ]] ||
	SHWRAP_MODULE_PATHS+=(.)

declare -A _shwrap_modules
declare -A _shwrap_modules_deps
declare -A _shwrap_modules_hashes
declare -A _shwrap_modules_names
declare -A _shwrap_modules_partials
declare -A _shwrap_modules_parts
declare -A _shwrap_modules_paths
declare -A _shwrap_scope
declare -a _shwrap_modules_stack

[[ -v _shwrap_scope[.] ]] || _shwrap_scope+=([.]=$(declare -px))
[[ -d "${SHWRAP_TMP_PATH}" ]] || mkdir -p "${SHWRAP_TMP_PATH}"

function __shwrap_clean()
{
	declare -Ag _shwrap_modules=()
	declare -Ag _shwrap_modules_deps=()
	declare -Ag _shwrap_modules_hashes=()
	declare -Ag _shwrap_modules_names=()
	declare -Ag _shwrap_modules_partials=()
	declare -Ag _shwrap_modules_parts=()
	declare -Ag _shwrap_modules_paths=()
	declare -Ag _shwrap_scope=([.]=$(declare -px))
	declare -ag _shwrap_modules_stack=()
}
