source "${BASH_SOURCE[0]%/*}"/../../_common/a_scope/a.sh

shwrap_import ../b/b.sh

echo "${SHWRAP_FD_FUNC}"
echo "{${SHWRAP_FD_RANGE[@]}}"
echo "${SHWRAP_FD_RANDOM_MAXTRY}"

shwrap_test_data__print_a
