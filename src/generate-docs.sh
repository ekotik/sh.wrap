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

help-generate-docs() {
	printf "Usage: %s: <IN_DIR> <OUT_DIR>\n" "$0"
	help "$@"
}

# check source directory
if [[ $# -eq 0 ]]; then
	echo >&2 "No source directory specified"
	help-generate-docs "$@"
fi
# check destination directory
if [[ $# -eq 1 ]]; then
	echo >&2 "No destination directory specified"
	help-generate-docs "$@"
fi

in_dir=$(realpath "$1")
out_dir=$(realpath -m "$2")

function generate_docs()
{
	local file="$1"
	grep -rl "^[[:space:]]*##" "${file}" |
		sort --version-sort |
		xargs -n1 grep -h "^[[:space:]]*##" |
		sed 's/^[[:space:]]*//' |
		sed 's/^##[[:space:]]\?//'
}

# greetings for github runner
echo '::notice::Documentation generation action started!' | gh_echo

# generate documentation
echo '::group::Generate docs' | gh_echo
LAST_ERROR="generation failed"
while IFS= read -d $'\0' -r path; do
	dir=$(dirname "$(realpath -m -s "${path}" --relative-base "${in_dir}")")
	file=$(basename "${path}")

	mkdir -p "${out_dir}"/"${dir}" || true 2> /dev/null
	generate_docs "${in_dir}"/"${dir}"/"${file}" > \
				  "${out_dir}"/"${dir}"/"${file}.md" || $live_or_die
done < <(find "${in_dir}" -name '*.sh' -print0)
echo '::endgroup::' | gh_echo

# goodbye
echo '::notice::Documentation generation action ended!' | gh_echo

exit 0
