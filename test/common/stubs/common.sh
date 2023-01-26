#!/bin/bash
# sh.wrap - module system for bash

## # common.sh
##
## TE library of stubs for common.sh module.
##

## ## `___shwrap_te_common_stubs_common__empty_stubs`
##
## Define empty function declarations for the dependencies of common.sh module.
##
___shwrap_te_common_stubs_common__empty_stubs()
{
	# shellcheck disable=SC2317
	# don't bother
	__shwrap_md5sum() { :; }
	# shellcheck disable=SC2317
	# don't bother
	__shwrap_random_bytes() { :; }
}

## ## `___shwrap_te_common_stubs_common__source_common`
##
## Run `source` command on common.sh module with empty stubs for the
## dependencies.
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
___shwrap_te_common_stubs_common__source_common()
{
	___shwrap_te_common_stubs_common__empty_stubs
	# shellcheck source=src/common.sh
	source "${SHWRAP_SRC_ROOT}"/common.sh
}
