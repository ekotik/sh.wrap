source "${BASH_SOURCE[0]%/*}"/../../_common/b_scope/b.sh

shwrap_import ../c/c.sh

declare -fx shwrap_test_data__print_c
