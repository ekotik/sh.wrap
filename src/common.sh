#!/bin/bash
# sh.wrap - module system for bash

## # common.sh
##
## Common global, environment variables and function definitions for them.
##

# environment variables
declare -g _SHWRAP_ID
_SHWRAP_ID=$(__shwrap_random_bytes 256 | __shwrap_md5sum)

[[ -n "${SHWRAP_ID}" ]] || declare -g SHWRAP_ID="${_SHWRAP_ID}"

declare -xg _SHWRAP_MODULE_PATH=~/.sh.wrap
declare -xg _SHWRAP_MODULE="${SHWRAP_INIT_DIR}"/module.sh
declare -xg _SHWRAP_TMP_PATH=/tmp/sh.wrap
declare -axg SHWRAP_MODULE_PATHS

[[ -n "${SHWRAP_MODULE_PATH}" ]] ||
	declare -xg SHWRAP_MODULE_PATH="${_SHWRAP_MODULE_PATH}"
[[ -n "${SHWRAP_MODULE}" ]] ||
	declare -xg SHWRAP_MODULE="${_SHWRAP_MODULE}"
[[ -n "${SHWRAP_TMP_PATH}" ]] ||
	declare -xg SHWRAP_TMP_PATH="${_SHWRAP_TMP_PATH}"
[[ -n "${SHWRAP_MODULE_PATHS[*]}" ]] ||
	SHWRAP_MODULE_PATHS+=(.)
[[ -d "${SHWRAP_TMP_PATH}" ]] || mkdir -p "${SHWRAP_TMP_PATH}"

declare -axg _SHWRAP_FD_RANGE=(666 777)
declare -xg _SHWRAP_FD_RANDOM_MAXTRY=10
declare -xg _SHWRAP_FD_FUNC=__shwrap_get_fd_sequential

[[ -n "${SHWRAP_FD_RANGE[*]}" ]] ||
	declare -ag SHWRAP_FD_RANGE+=("${_SHWRAP_FD_RANGE[@]}")
[[ -n "${SHWRAP_FD_RANDOM_MAXTRY}" ]] ||
	declare -g SHWRAP_FD_RANDOM_MAXTRY="${_SHWRAP_FD_RANDOM_MAXTRY}"
[[ -n "${SHWRAP_FD_FUNC}" ]] ||
	declare -g SHWRAP_FD_FUNC="${_SHWRAP_FD_FUNC}"

# global variables
declare -Ag _shwrap_modules
declare -Ag _shwrap_modules_deps
declare -Ag _shwrap_modules_hashes
declare -Ag _shwrap_modules_names
declare -Ag _shwrap_modules_partials
declare -Ag _shwrap_modules_parts
declare -Ag _shwrap_modules_paths
declare -Ag _shwrap_scope
declare -ag _shwrap_fds
declare -ag _shwrap_modules_stack

# update global scope
[[ -v _shwrap_scope[.] ]] || _shwrap_scope+=([.]=$(declare -px))

## ## `__shwrap_clean`
##
## Reset internal structures to the initialization state.
##
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
	declare -ag _shwrap_fds=()
	declare -ag _shwrap_modules_stack=()
}
