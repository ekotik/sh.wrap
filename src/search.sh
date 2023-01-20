#!/bin/bash
# sh.wrap - module system for bash

## # search.sh
##
## Module search functions.
##

# shellcheck source=src/common.sh
source "${SHWRAP_INIT_DIR}"/common.sh

## ## `__shwrap_path`
##
## Make a given path a path relative to an absolute path.
##
## ### Synopsis
##
## ```shell
## __shwrap_path path
## ```
##
## ### Parameters
##
## - `path` \
##   Absolute path.
##
## ### Return
##
## Absolute path.
##
function __shwrap_path()
{
	local dir="$1"
	local _dir="$1"
	local path="$2"
	local part
	while IFS= read -r -d "/" part; do
		if [[ "${part}" == "" ]] || [[ "${part}" == "." ]]; then
			continue
		elif [[ "${part}" == ".." ]]; then
			dir="${dir%/*}"
		else
			dir="${dir}"/"${part}"
		fi
	done <<< "${path}/"
	echo "${dir}" | sed -Ee 's|/+|/|g'
}

## ## `__shwrap_realpath`
##
## Print the resolved module path.
##
## ### Synopsis
##
## ```shell
## __shwrap_realpath __shwrap_name
## ```
##
## ### Parameters
##
## - `__shwrap_path` \
##   Module path.
##
## ### Return
##
## Resolved module path.
##
## ### Exit status
##
## `0` - success
## `1` - otherwise
##
function __shwrap_realpath()
{
	local __shwrap_path="$1"
	if [[ -e "${__shwrap_path}" ]]; then
		if [[ "${__shwrap_path}" =~ ^/ ]]; then
			__shwrap_path "/" "${__shwrap_path}"
		else
			__shwrap_path "$(pwd)" "${__shwrap_path}"
		fi
		return 0
	fi
	return 1
}

## ## `__shwrap_search`
##
## Search a module path. \
## Firstly it checks for existing modules with name `__shwrap_module` at
## absolute or relative paths. Then it checks special locations - user paths,
## load paths, and default path. User paths are paths from `SHWRAP_MODULE_PATHS`
## array. Load paths are paths of modules in a current *import chain*. A default
## path is a path stored in `SHWRAP_MODULE_PATH` variable. If nothing is found
## it returns a fallback path which is a current working directory plus
## `__shwrap_module` name.
##
## ### Synopsis
##
## ```shell
## __shwrap_search __shwrap_module
## ```
##
## ### Parameters
##
## - `__shwrap_module` \
##   Module name.
##
## ### Return
##
## Module path.
##
function __shwrap_search()
{
	local __shwrap_module="$1"
	local __shwrap_module_hash __shwrap_module_name __shwrap_module_path
	local module_dir
	__shwrap_module_path=$(__shwrap_realpath "${__shwrap_module}")
	__shwrap_log "__shwrap_search: search '${__shwrap_module}'" >&2
	# check absolute path
	if [[ "$(__shwrap_path "/" "${__shwrap_module}")" == \
		  "${__shwrap_module_path}" ]]; then
		printf '%s' "${__shwrap_module_path}"
		return 0
	fi
	# check relative path
	if [[ "${#_shwrap_modules_stack[@]}" -gt 0 ]]; then
		__shwrap_module_hash="${_shwrap_modules_stack[-1]}"
		__shwrap_module_name="${_shwrap_modules_names[${__shwrap_module_hash}]}"
		__shwrap_module_path="${_shwrap_modules_paths[${__shwrap_module_name}]}"
		module_dir=$(dirname "${__shwrap_module_path}")
		if __shwrap_realpath "${module_dir}"/"${__shwrap_module}"; then
			return 0
		fi
	fi
	if [[ "${__shwrap_module}" == "${__shwrap_module#./*}" ]] &&
		   [[ "${__shwrap_module}" == "${__shwrap_module#../*}" ]]; then
		# check user paths
		for module_dir in "${SHWRAP_MODULE_PATHS[@]}"; do
			local path="${module_dir}"/"${__shwrap_module}"
			if [[ "${module_dir}" == "${module_dir#/*}" ]]; then
				if [[ "${#_shwrap_modules_stack[@]}" -gt 0 ]]; then
					__shwrap_module_hash="${_shwrap_modules_stack[-1]}"
					__shwrap_module_name="${_shwrap_modules_names[${__shwrap_module_hash}]}"
					__shwrap_module_path="${_shwrap_modules_paths[${__shwrap_module_name}]}"
					path=$(dirname "${__shwrap_module_path}")/"${module_dir}"/"${__shwrap_module}"
				fi
			fi
			if __shwrap_realpath "${path}"; then
				return 0
			fi
		done
		# check load paths
		if [[ "${#_shwrap_modules_stack[@]}" -gt 0 ]]; then
			local i stack=("${_shwrap_modules_stack[@]}")
			unset 'stack[-1]'
			for i in $(seq 0 "${#stack[@]}" | tac | tail +2); do
				__shwrap_module_hash="${stack[${i}]}"
				__shwrap_module_name="${_shwrap_modules_names[${__shwrap_module_hash}]}"
				__shwrap_module_path="${_shwrap_modules_paths[${__shwrap_module_name}]}"
				module_dir=$(dirname "${__shwrap_module_path}")
				if __shwrap_realpath "${module_dir}"/"${__shwrap_module}"; then
					return 0
				fi
			done
		fi
		# default
		if [[ -v SHWRAP_MODULE_PATH ]]; then
			if __shwrap_realpath "${SHWRAP_MODULE_PATH}"/"${__shwrap_module}"; then
				return 0
			fi
		fi
	fi
	# fallback
	__shwrap_path "$(pwd)" "${__shwrap_module}"
}
