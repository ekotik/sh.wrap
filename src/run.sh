#!/bin/bash
# sh.wrap - module system for bash
# run.sh
# Module runner and cache functions.

source common.sh

function shwrap_run()
{
	local module="$1"
	local command_string="$2"
	shift 2

	local module_path
	module_path=$(__shwrap_search "${module}")
	__shwrap_run "${module_path}" "${command_string}" "$@"
}

function __shwrap_run()
{
	local module_path="$1"
	local command_string="$2"
	shift 2

	local module_hash
	module_hash="${_shwrap_modules_hashes[${module_path}]}"
	__shwrap__run "${module_path}" "${module_hash}" "${command_string}" "$@"
}

function __shwrap__run()
{
	local module_path="$1"
	local scope="$2"
	local command_string="$3"
	shift 3

	local command module_hash
	local fd_scope fd_scope_cap fd_out fd_out_cap
	module_hash="${_shwrap_modules_hashes[${module_path}]}"
	[[ -v _shwrap_modules["${module_hash}"] ]] || {
		_shwrap_modules+=(["${module_hash}"]="###INITIALIZE MODULE###;")
		__shwrap_cache "${module_path}" "${scope}"
	}
	exec {fd_scope}</dev/null
	exec {fd_out}</dev/null
	# shellcheck disable=SC2016
	# intentional use of single quotes to avoid unwanted expansions
	command='${_MODULE_DEBUG:+set -x}
		source '"${SHWRAP_MODULE}"'
		'"$(declare -p _shwrap_modules)"'
		'"$(declare -p _shwrap_modules_deps)"'
		'"$(declare -p _shwrap_modules_hashes)"'
		'"$(declare -p _shwrap_modules_names)"'
		'"$(declare -p _shwrap_modules_partials)"'
		'"$(declare -p _shwrap_modules_parts)"'
		'"$(declare -p _shwrap_modules_paths)"'
		'"$(declare -p _shwrap_scope)"'
		'"$(declare -p _shwrap_modules_stack)"'
		source /dev/stdin <<< "${_shwrap_modules['"${module_hash}"']}"
		eval "${_shwrap_scope[.]}"
		eval "${_shwrap_scope['"${scope}"']}"
		'"${command_string}"' "$@"
		declare __shwrap_ret=$?
		_shwrap_scope+=(['"${scope}"']=$(__shwrap_scope))
		{
			declare -p _shwrap_modules;
			declare -p _shwrap_modules_deps;
			declare -p _shwrap_modules_hashes;
			declare -p _shwrap_modules_names;
			declare -p _shwrap_modules_partials;
			declare -p _shwrap_modules_parts;
			declare -p _shwrap_modules_paths;
			declare -p _shwrap_scope;
			declare -p _shwrap_modules_stack;
			declare -p __shwrap_ret;
		} | __shwrap_declare >&'"${fd_scope}"'
		exit ${__shwrap_ret}'
	{
		eval "exec ${fd_out}>&1"
		exec {fd_scope_cap}< <(
			exec {fd_out_cap}< <(
				{
					eval "exec ${fd_scope}>&1 1>&${fd_out}"
					cat <<< "${command}" \
						> "${SHWRAP_TMP_PATH}"/"${module_hash}"_run.sh
					env -i ${_MODULE_VERBOSE:+-v} \
						_MODULE_DEBUG="${_MODULE_DEBUG}" \
						_MODULE_LOG="${_MODULE_LOG}" \
						"${SHELL}" --noprofile --norc \
						"${SHWRAP_TMP_PATH}"/"${module_hash}"_run.sh "$@"
					eval "exec ${fd_scope}>&-"
				}
			)
			cat <&"${fd_out_cap}"
			exec {fd_out_cap}<&-
		)
		# shellcheck disable=SC2046
		eval "$(cat <&"${fd_scope_cap}")"
		exec {fd_scope_cap}<&-
		eval "exec ${fd_out}>&-"
	}
	exec {fd_scope}<&-
	exec {fd_out}<&-

	# shellcheck disable=SC2154
	return "${__shwrap_ret}"
}

function __shwrap_cache()
{
	local module_path="$1"
	local scope="$2"

	local command module_hash
	local fd_scope fd_scope_cap fd_out fd_out_cap
	module_hash="${_shwrap_modules_hashes[${module_path}]}"
	local command module_hash
	__shwrap_log "__shwrap_cache: cache '${module_path}' '${scope}'" >&2
	exec {fd_scope}</dev/null
	exec {fd_out}</dev/null
	# shellcheck disable=SC2016
	# intentional use of single quotes to avoid unwanted expansions
	command='${_MODULE_DEBUG:+set -x}
		source '"${SHWRAP_MODULE}"'
		'"$(declare -p _shwrap_modules)"'
		'"$(declare -p _shwrap_modules_deps)"'
		'"$(declare -p _shwrap_modules_hashes)"'
		'"$(declare -p _shwrap_modules_names)"'
		'"$(declare -p _shwrap_modules_partials)"'
		'"$(declare -p _shwrap_modules_parts)"'
		'"$(declare -p _shwrap_modules_paths)"'
		'"$(declare -p _shwrap_scope)"'
		'"$(declare -p _shwrap_modules_stack)"'
		eval "${_shwrap_scope[.]}"
		source '"${module_path}"'
		declare __shwrap_ret=$?
		_shwrap_modules+=(['"${module_hash}"']=$(declare -f))
		_shwrap_scope+=(['"${scope}"']=$(__shwrap_scope))
		{
			declare -p _shwrap_modules;
			declare -p _shwrap_modules_deps;
			declare -p _shwrap_modules_hashes;
			declare -p _shwrap_modules_names;
			declare -p _shwrap_modules_partials;
			declare -p _shwrap_modules_parts;
			declare -p _shwrap_modules_paths;
			declare -p _shwrap_scope;
			declare -p _shwrap_modules_stack;
			declare -p __shwrap_ret;
		} | __shwrap_declare >&'"${fd_scope}"'
		exit ${ret}'
	{
		eval "exec ${fd_out}>&1"
		exec {fd_scope_cap}< <(
			exec {fd_out_cap}< <(
				{
					eval "exec ${fd_scope}>&1 1>&${fd_out}"
					cat <<< "${command}" \
						> "${SHWRAP_TMP_PATH}"/"${module_hash}"_cache.sh
					env -i ${_MODULE_VERBOSE:+-v} \
						_MODULE_DEBUG="${_MODULE_DEBUG}" \
						_MODULE_LOG="${_MODULE_LOG}" \
						"${SHELL}" --noprofile --norc \
						"${SHWRAP_TMP_PATH}"/"${module_hash}"_cache.sh
					eval "exec ${fd_out}>&-"
				}
			)
			cat <&"${fd_out_cap}"
			exec {fd_out_cap}<&-
		)
		# shellcheck disable=SC2046
		eval "$(cat <&"${fd_scope_cap}")"
		exec {fd_scope_cap}<&-
		eval "exec ${fd_out}>&-"
	}
	exec {fd_scope}<&-
	exec {fd_out}<&-

	# shellcheck disable=SC2154
	return "${__shwrap_ret}"
}
