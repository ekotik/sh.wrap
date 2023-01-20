#!/bin/bash
# sh.wrap - module system for bash

# util.spec.sh
# Module tests for util.sh

# shellcheck disable=SC1091,SC2034

: "
test__issues

This test checks GH issues.
"
test__issues()
{
	env -u VERBOSE "$0" "${BASH_SOURCE[0]%/*}"/issues/scope.sh
}
