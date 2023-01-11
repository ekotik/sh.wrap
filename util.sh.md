# util.sh

Utility functions.

## `__shwrap_scope`

Read and re-declare global variables with reserved and shell specific
variables removed.

### Return

Global variable definitions without reserved and shell specific variables.

## `__shwrap_declare`

Read variable definitions. and declare them as global.

### Return

- Global variable definitions.

## `__shwrap_name_is_function`

Check if `__shwrap_name` is a name of a declared function.

### Synopsis

```shell
__shwrap_name_is_function __shwrap_name
```

### Parameters

- `__shwrap_name` \
  Function name.

### Exit status

- `0` - success
- `1` - otherwise

## `__shwrap_log`

Log `message` if `SHWRAP_MODULE_LOG` is not null.

### Synopsis

```shell
__shwrap_log message
```

### Parameters

- `message` \
  Message.

### Return

Message.

## `__shwrap_random_bytes`

Get `count` random bytes.

### Return

Random bytes.

## `__shwrap_md5sum`

Read input and calculate its md5 hash sum.

### Return

md5 hash.

## `__shwrap_fd_is_free`

Checks if `fd` is a free file descriptor.

### Synopsis

```shell
__shwrap_fd_is_free fd
```

### Parameters

- `fd` \
  File descriptor.

### Exit status

- `0` - success
- `1` - otherwise

## `__shwrap_get_fd`

Call function stored in `SHWRAP_FD_FUNC` with given parameters. \
Expected that `fdr_start` and `fdr_end` are valid.

### Synopsis

```shell
__shwrap_get_fd fdr_start fdr_end
```

### Parameters

- `fdr_start` \
  Start of a file descriptors range.
- `fdr_end` \
  End of a file descriptors range.

### Return

Message.

## `__shwrap_get_fd_random`

Get a random free file descriptor from the range between `fdr_start` and
`fdr_end` in a maximum of `SHWRAP_FD_RANDOM_MAXTRY` tries.

### Synopsis

```shell
__shwrap_get_fd_random fdr_start fdr_end
```

### Parameters

- `fdr_start` \
  Start of a file descriptors range.
- `fdr_end` \
  End of a file descriptors range.

### Return

- `fd` - if founded
- `-1` - otherwise

## `__shwrap_get_fd_sequential`

Get a next free file descriptor from the range between `fdr_start` and
`fdr_end`.

### Synopsis

```shell
__shwrap_get_fd_sequential fdr_start fdr_end
```

### Parameters

- `fdr_start` \
  Start of a file descriptors range.
- `fdr_end` \
  End of a file descriptors range.

### Return

- `fd` - if founded
- `-1` - otherwise

