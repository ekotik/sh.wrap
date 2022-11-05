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
trap '$live_or_die' ERR

gh_mode=0
# shellcheck disable=SC2153
[[ -v GH_MODE ]] && gh_mode=1

gh_echo() {
	local gh_commands

	[[ "$gh_mode" == 0 ]] && return 0;
	read -d $'\0' -r gh_commands || true;
	echo -en "${gh_commands}\n"
}

help-hugo-site() {
	printf "Usage: %s: <HUGOPATH> <DOCSDIR> <SITEDIR> <PUBLICDIR>\n" "$0"
	help "$@"
}

# greetings for github runner
echo '::notice::Hugo site action started!' | gh_echo

# check parameters
if [[ $# -eq 0 ]]; then
	echo >&2 "No hugo binary path specified"
	help-hugo-site "$@"
fi

if [[ $# -eq 1 ]]; then
	echo >&2 "No documentation directory specified"
	help-hugo-site "$@"
fi

if [[ $# -eq 2 ]]; then
	echo >&2 "No site directory specified"
	help-hugo-site "$@"
fi

if [[ $# -eq 3 ]]; then
	echo >&2 "No publish directory specified"
	help-hugo-site "$@"
fi

hugo_bin=$(realpath "$1")
docs_dir=$(realpath "$2")
site_dir=$(realpath "$3")
public_dir=$(realpath "$4")

# check paths
LAST_ERROR="hugo binary not found"
[[ -f "$hugo_bin" ]] || $live_or_die
LAST_ERROR="documentation directory not found"
[[ -d "$site_dir" ]] || $live_or_die

function org_to_md()
{
	local page="$1"
	local clean="$2"
	local extensions=""
	if [[ "$clean" == 1 ]]; then
		extensions="-raw_attribute-raw_html-header_attributes-bracketed_spans"
	fi
	pandoc -s "$page" -t markdown"$extensions"
}

# generate documentation
LAST_ERROR="generating documentation failed"
while IFS= read -d $'\0' -r page; do
	page_out="${page/${docs_dir}\//}"
	page_dir="${page_out%/*}"
	section_dir=""
	if [[ "$page_dir" != "$page_out" ]]; then
		section_dir="$page_dir"
	fi

	mkdir -p "$site_dir"/content/"$section_dir" || true 2> /dev/null
	org_to_md "$page" 1 > "$site_dir"/content/"${page_out%.org}".md
done < <(find "$docs_dir" -name '*.org' -print0)

echo '::group::Generate hugo site' | gh_echo
# hugo run
chmod u+x "$hugo_bin"
{ pushd "$site_dir"; "$hugo_bin" mod get -u; popd; } || $live_or_die
"$hugo_bin" -s "$site_dir" -d "$public_dir" || $live_or_die
echo '::endgroup::' | gh_echo

# goodbye
echo '::notice::Hugo site action ended!' | gh_echo