#!/bin/bash
# sh.wrap - module system for bash
# search.sh
# Module search functions.

source "${SHWRAP_INIT_DIR}"/common.sh

function __shwrap_path()
{
	local module="$1"
	realpath -qsm "${module}"
}

function __shwrap_search()
{
	local module="$1"
	local module_dir module_hash module_name module_path
	module_path=$(__shwrap_path "${module}")
	__shwrap_log "__shwrap_search: search '${module}'" >&2
	# check absolute path
	if [[ "${module}" == "${module_path}" ]]; then
		printf '%s' "${module_path}"
		return 0
	fi
	# check relative path
	if [[ "${#_shwrap_modules_stack[@]}" -gt 0 ]]; then
		module_hash="${_shwrap_modules_stack[-1]}"
		module_name="${_shwrap_modules_names[${module_hash}]}"
		module_path="${_shwrap_modules_paths[${module_name}]}"
		module_dir=$(dirname "${module_path}")
		if realpath -qse "${module_dir}"/"${module}"; then
			return 0
		fi
	fi
	# check user paths
	if [[ "${module}" == "${module#./*}" ]] &&
		   [[ "${module}" == "${module#../*}" ]]; then
		for module_dir in "${SHWRAP_MODULE_PATHS[@]}"; do
			local path="${module_dir}"/"${module}"
			if [[ "${module_dir}" == "${module_dir#/*}" ]]; then
				if [[ "${#_shwrap_modules_stack[@]}" -gt 0 ]]; then
					module_hash="${_shwrap_modules_stack[-1]}"
					module_name="${_shwrap_modules_names[${module_hash}]}"
					module_path="${_shwrap_modules_paths[${module_name}]}"
					path=$(dirname "${module_path}")/"${module_dir}"/"${module}"
				fi
			fi
			if realpath -qse "${path}"; then
				return 0
			fi
		done
		# check load paths
		if [[ "${#_shwrap_modules_stack[@]}" -gt 0 ]]; then
			local i stack=("${_shwrap_modules_stack[@]}")
			unset 'stack[-1]'
			for i in $(seq 0 "${#stack[@]}" | tac | tail +2); do
				module_hash="${stack[${i}]}"
				module_name="${_shwrap_modules_names[${module_hash}]}"
				module_path="${_shwrap_modules_paths[${module_name}]}"
				module_dir=$(dirname "${module_path}")
				if realpath -qse "${module_dir}"/"${module}"; then
					return 0
				fi
			done
		fi
		# default
		if [[ -v SHWRAP_MODULE_PATH ]]; then
			if realpath -qse "${SHWRAP_MODULE_PATH}"/"${module}"; then
				return 0
			fi
		fi
	fi
	# fallback
	__shwrap_path "${module}"
}
