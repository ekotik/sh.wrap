#!/bin/bash
# shellcheck disable=all
# sh.wrap - module system for bash

unset _scope
unset _globals
declare -A _scope
declare -a _globals

_DEFAULT_MODULE_PATH=~/.sh.wrap

function _get_module_path()
{
	local _module_path="$_DEFAULT_MODULE_PATH"
	if [[ -n "$_MODULE_PATH" ]]; then
		_module_path="$_MODULE_PATH":"$_DEFAULT_MODULE_PATH"
	fi

	_MODULE_PATH="$_module_path"
	_module::export _MODULE_PATH
	declare -pg _MODULE_PATH
}

function _get_scope()
{
	local module_id="$1"
	_scope["$module_id"]=$( for name in "${_globals[@]}"; do
		declare -p "$name";
	done )
}

function _name_is_function()
{
	local name="$1"
	declare -F "$name" &>/dev/null
}

function _name_is_variable()
{
	local module="$1"
	local name="$2"
	declare -p "$name" &>/dev/null
}

function _module::search()
{
	local module="$1"
	local module_id="."
	local module_paths=()

	readarray -t -d':' module_paths <<< ".":"$_MODULE_PATH":
	unset module_paths[-1]

	local module_path
	for module_path in "${module_paths[@]}"; do
		if [[ -f "${module_path}"/"$module" ]]; then
			local module_id=$(realpath "$module_path"/"$module")
			break
		fi
	done

	echo "$module_id"
}

function _module::run()
{
	local module="$1"
	local command_string="$2"
	shift 2
	local module_id=$(_module::search "$module")
	local module_dir=$(dirname "$module_id")

	if [[ "$module_id" == "." ]]; then
		"$command_string" "$@"
		return $?
	fi
	local fd_scope=
	local fd_out=
	{
		exec {fd_scope}< \
			 <(exec {fd_out}< \
			   <({
					env -i ${_MODULE_DEBUG:+-v} _MODULE_DEBUG="$_MODULE_DEBUG" _MODULE_PATH="$module_dir":"$_MODULE_PATH" \
						"$SHELL" -c '${_MODULE_DEBUG:+set -x}; \
						source '"$module_id"'; # import module \
						'"$(declare -p _scope)"'; # transfer scope to module \
						# eval "${_scope[.]}"; # eval global scope \
						eval "${_scope['"$module_id"']}"; # eval module scope \
						_get_scope .; # ??? \
						'"$command_string"' "$@"; # run function \
						declare ret=$?; # save return status \
						_get_scope '"$module_id"'; # ??? \
						{ declare -p _scope; echo ";"; declare -p ret; } | sed -e "s|declare -A|declare -Ag|" >&4; # transfer scope back \
						exit $ret;' \
						"$module" "$@"
				} 4>&1 1>&5 )
			   cat <&"${fd_out}"
			   {fd_out}<&- )
	} 5>&1

	eval $(cat <&"${fd_scope}")
	{fd_scope}<&-

	return "$ret"
}

function _module::import()
{
	local module="$1"
	shift
	local names="$@"
	local name
	if [[ $# == 0 ]]; then
		_module::run "." 'declare -f $(_module::name)::'"$name"
	else
		for name in "${names[@]}"; do
			if _module::run "$module" '_name_is_function '"$name"; then
				source <(cat <<EOF
function $name() {
	_module::run "$module" "$name" "\$@"
}
EOF
)
			elif _module::run "$module" '_name_is_variable '"$name"; then
				source <(cat <<EOF
function $name() {
	_module::run "$module" "$name" "\$@"
}
EOF
)
			fi
		done
	fi
}

function _module::export()
{
	local name="$1"
	_globals+=("$name")
}

eval $(_get_module_path)
