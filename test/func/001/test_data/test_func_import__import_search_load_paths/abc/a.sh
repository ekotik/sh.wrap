source "${BASH_SOURCE[0]%/*}"/../../_common/a_scope/a.sh

shwrap_import ../b/b.sh

shwrap_test_data__print_a
shwrap_test_data__print_b
