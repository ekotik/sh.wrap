#!/bin/bash
# sh.wrap - module system for bash

## # init.sh
##
## TE library for sh.wrap initialization.
##

## ## `___shwrap_te_common_init__init_default`
##
## Initialize sh.wrap distribution at a given path in the case of
## `SHWRAP_INIT_DIR` is not set.
##
## ### Synopsis
##
## ```shell
## ___shwrap_te_common_init__init_default shwrap_init_dir
## ```
##
## ### Parameters
##
## - `shwrap_init_dir`
##   Distribution path.
##
## ### Exit status
##
## - `0` - success
## - `1` - otherwise
##
___shwrap_te_common_init__init_default()
{
	unset SHWRAP_INIT_DIR
	local shwrap_init_dir="$1"
	[[ -n "${shwrap_init_dir}" ]] || return 1
	# shellcheck source=src/init.sh
	source "${shwrap_init_dir}"/init.sh
}

## ## `___shwrap_te_common_init__init_default_src`
##
## Initialize sh.wrap distribution at a source root path in the case of
## `SHWRAP_INIT_DIR` is not set.
##
## ### Environment
##
## - `SHWRAP_SRC_ROOT`
##   Source code path.
##
## ### Exit status
##
## - `0` - success
## - `1` - otherwise
##
___shwrap_te_common_init__init_default_src()
{
	___shwrap_te_common_init__init_default "${SHWRAP_SRC_ROOT}"
}

## ## `___shwrap_te_common_init__init_user`
##
## Initialize sh.wrap distribution at a given path in the case of
## `SHWRAP_INIT_DIR` is set.
##
## ### Synopsis
##
## ```shell
## ___shwrap_te_common_init__init_user shwrap_init_dir
## ```
##
## ### Parameters
##
## - `shwrap_init_dir`
##   Distribution path.
##
## ### Exit status
##
## - `0` - success
## - `1` - otherwise
##
___shwrap_te_common_init__init_user()
{
	local shwrap_init_dir="$1"
	[[ -n "${shwrap_init_dir}" ]] || return 1
	declare -g SHWRAP_INIT_DIR
	# shellcheck disable=SC2034
	# used in initialization
	SHWRAP_INIT_DIR="${shwrap_init_dir}"
	# shellcheck source=src/init.sh
	source "${shwrap_init_dir}"/init.sh
}

## ## `___shwrap_te_common_init__init_user_src`
##
## Initialize sh.wrap distribution at a source root path in the case of
## `SHWRAP_INIT_DIR` is set.
##
## ### Environment
##
## - `SHWRAP_SRC_ROOT`
##   Source code path.
##
## ### Exit status
##
## - `0` - success
## - `1` - otherwise
##
___shwrap_te_common_init__init_user_src()
{
	___shwrap_te_common_init__init_user "${SHWRAP_SRC_ROOT}"
}
