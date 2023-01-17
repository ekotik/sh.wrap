source "${BASH_SOURCE[0]%/*}"/../../_common/a_scope/a.sh

SHWRAP_MODULE_PATHS+=(../b)

shwrap_import b.sh
shwrap_import c_scope/c.sh

shwrap_test_data__print_c
