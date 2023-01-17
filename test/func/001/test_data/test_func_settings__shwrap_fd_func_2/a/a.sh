source "${BASH_SOURCE[0]%/*}"/../../_common/a_scope/a.sh
source "${BASH_SOURCE[0]%/*}"/../../_common/fd_pool/src/util_fd_pool.sh

export SHWRAP_MODULE="${BASH_SOURCE[0]%/*}"/../../_common/fd_pool/src/module.sh

export SHWRAP_FD_FUNC=__shwrap_test_data__get_fd_pool

shwrap_import ../b/b.sh

shwrap_test_data__print_b

echo "[${_shwrap_fds[@]}]"
