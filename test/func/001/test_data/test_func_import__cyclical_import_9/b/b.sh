source "${BASH_SOURCE[0]%/*}"/../../_common/b_scope/b.sh

A="${BASH_SOURCE[0]%/*}"/../a/a.sh

shwrap_test_data__import_a_from_b()
{
	shwrap_import "${A}"
}

shwrap_test_data__change_a_from_b()
{
	shwrap_test_data__change_a "BB"
}

declare -fx shwrap_test_data__import_a_from_b
declare -fx shwrap_test_data__change_a_from_b

shwrap_test_data__print_b
