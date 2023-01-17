source "${BASH_SOURCE[0]%/*}"/../../_common/a_scope/a.sh

shwrap_test_data__print

shwrap_import ../b/b.sh

shwrap_test_data__print
