source "${BASH_SOURCE[0]%/*}"/../../_common/b_scope/b.sh

shwrap_test_data__print

shwrap_import ../a/a.sh

shwrap_test_data__print
