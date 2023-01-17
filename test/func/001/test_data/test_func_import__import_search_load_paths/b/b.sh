source "${BASH_SOURCE[0]%/*}"/../../_common/b_scope/b.sh

shwrap_import b/c/c.sh

shwrap_test_data__print_b
shwrap_test_data__print_c
