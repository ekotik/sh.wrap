source "${BASH_SOURCE[0]%/*}"/../../_common/a_scope/a.sh

SHWRAP_MODULE_PATHS=(
	"${BASH_SOURCE[0]%/*}"/../../_common
)

shwrap_import ../b/b.sh

shwrap_test_data__print_a
