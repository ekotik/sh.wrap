declare -ag _shwrap_test_data__fd_pool=({20..21} {30..31})

function __shwrap_test_data__get_fd_pool()
{
	while [[ -v _shwrap_fds["${_shwrap_test_data__fd_pool[-1]}"] ]]; do
		unset _shwrap_test_data__fd_pool[-1]
	done
	if [[ "${#_shwrap_test_data__fd_pool[@]}" -gt 0 ]]; then
		echo "${_shwrap_test_data__fd_pool[-1]}"
	else
		echo -1
	fi
}
