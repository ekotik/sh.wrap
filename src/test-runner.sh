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

gh_mode=0
# shellcheck disable=SC2153
[[ -v GH_MODE ]] && gh_mode=1

gh_echo() {
	local gh_commands

	[[ "${gh_mode}" == 0 ]] && return 0;
	read -d $'\0' -r gh_commands || true;
	echo -en "${gh_commands}\n"
}

help-test-runner() {
	printf "Usage: %s: <MICROSPEC_PATH> <MICROSPEC_EXEC> [MICROSPEC_ARGS...]\n" "$0"
	help "$@"
}

echo '::notice::Test runner action started!' | gh_echo

# check parameters
if [[ $# -eq 0 ]]; then
	echo >&2 "No microspec path specified"
	help-test-runner "$@"
fi

if [[ $# -eq 1 ]]; then
	echo >&2 "No microspec executable specified"
	help-test-runner "$@"
fi

microspec_path=$(realpath "$1")
microspec_exec="$2"
shift 2
microspec="${microspec_path}"/"${microspec_exec}"
# shellcheck disable=SC2206
# intentional use of word splitting
microspec_args="$*"

# check paths
LAST_ERROR="microspec executable not found"
[[ -f "${microspec}" ]] || $live_or_die

echo '::group::Run tests' | gh_echo

# run tests
LAST_ERROR="test running failed"
env -i VERBOSE=true bash -c "${microspec} ${microspec_args}" || $live_or_die

echo '::endgroup::' | gh_echo

echo '::notice::Test runner action ended!' | gh_echo

exit 0
