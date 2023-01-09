#!/bin/bash

set -o errexit

[[ -v LIVE_DEBUG ]] && set -o xtrace

help() {
	echo "$*" >&2
	exit 1
}

die() {
	printf "%s: ${LAST_ERROR}\n" "$0" >&2
	exit 1
}

live() {
	true
}

live_or_die=${LIVE_OR_DIE:-die}

LAST_ERROR=
trap '${live_or_die}' ERR

help-dockerfile() {
	printf "Usage: %s: <DOCKERFILE_TEMPLATE> <DOCKERFILE>\n" "$0"
	help "$@"
}

# check dockerfile
if [[ $# -eq 0 ]]; then
	echo >&2 "No dockerfile template specified"
	help-dockerfile "$@"
fi

# check output dockerfile
if [[ $# -eq 1 ]]; then
	echo >&2 "No output dockerfile path specified"
	help-dockerfile "$@"
fi

dockerfile_template=$(realpath "$1")
dockerfile=$(realpath "$2")

LAST_ERROR="dockerfile template and output dockerfile are the same file"
[[ "${dockerfile_template}" != "${dockerfile}" ]] || $live_or_die

LAST_ERROR="no dockerfile template '${dockerfile_template}' found"
[[ -f "${dockerfile_template}" ]] || $live_or_die

env envsubst < "${dockerfile_template}" > "${dockerfile}"

exit 0
