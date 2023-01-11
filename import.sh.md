# import.sh

Import related functions.

## `__shwrap_partial_name`

Format a string representing a partially loaded module. `.` is for a top
level module.

### Synopsis

```shell
__shwrap_partial_name [__shwrap_parts...]
```

### Parameters

- `__shwrap_parts` \
  Zero or more module hashes.

### Return

String representing a partially loaded module or `.`.

## `__shwrap_circular`

Find an index of a circular module dependency for `__shwrap_module_hash` in a
current *import chain*.

### Synopsis

```shell
__shwrap_circular __shwrap_module_hash
```

### Parameters

- `__shwrap_module_hash` \
  Hash of a module.

### Return

- `i` - index, if founded
- `-1` - otherwise

## `__shwrap_hash`

Calculate hash of a module `__shwrap_module`.

### Synopsis

```shell
__shwrap_hash __shwrap_module
```

### Parameters

- `__shwrap_module` \
  Module name.

### Return

Hash of a module.

## `shwrap_import`

Search a module, calculate its hash and call `__shwrap_import` function with
given arguments.

### Synopsis

```shell
shwrap_import __shwrap_module [__shwrap_names...]
```

### Parameters

- `__shwrap_module` \
  Module name.
- `__shwrap_names` \
  Zero or more function names.

## `__shwrap_import`

Calculate a caller and call `__shwrap__import` function with given arguments.

### Synopsis

```shell
__shwrap_import __shwrap_module __shwrap_scope [__shwrap_names...]
```

### Parameters

- `__shwrap_module` \
  Module name.
- `__shwrap_scope` \
  Module scope.
- `__shwrap_names` \
  Zero or more function names.

## `__shwrap__import`

Import functions from a module `__shwrap_module` with `__shwrap_scope` scope
into a caller `__shwrap_caller`. If `__shwrap_names` is empty, only exported
functions are imported from the module.

### Synopsis

```shell
__shwrap__import __shwrap_module __shwrap_scope __shwrap_caller [__shwrap_names...]
```
### Parameters

- `__shwrap_module` \
  Module name.
- `__shwrap_scope` \
  Module scope.
- `__shwrap_caller` \
  Caller.
- `__shwrap_names` \
  Zero or more function names.

