source "${BASH_SOURCE[0]%/*}"/../../_common/a_scope/a.sh

shwrap_import ../b/b.sh
shwrap_import ../c/c.sh

shwrap_test_data__print_b
shwrap_test_data__print_c
