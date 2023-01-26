source "${BASH_SOURCE[0]%/*}"/../../_common/b_scope/b.sh

echo "${_shwrap_fds[@]}"
echo "${SHWRAP_FD_FUNC}"
echo "{${SHWRAP_FD_RANGE[@]}}"
echo "${SHWRAP_FD_RANDOM_MAXTRY}"

shwrap_test_data__print_b
