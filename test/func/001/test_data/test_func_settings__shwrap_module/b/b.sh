set -e

source "${BASH_SOURCE[0]%/*}"/../../_common/b_scope/b.sh

declare -F __shwrap_test_data__get_fd_pool

[[ -v _shwrap_test_data__fd_pool ]]

shwrap_test_data__print_b
