set -e

source "${BASH_SOURCE[0]%/*}"/../../_common/a_scope/a.sh

shwrap_import ../b/b.sh

declare -F __shwrap_test_data__get_fd_pool

[[ -v _shwrap_test_data__fd_pool ]]

shwrap_test_data__print_a
