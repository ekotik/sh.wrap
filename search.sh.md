# search.sh

Module search functions.

## `__shwrap_path`

Concatenate an absolute path of a current working directory with a module
name.

### Synopsis

```shell
__shwrap_path __shwrap_module
```

### Parameters

- `__shwrap_module` \
  Module name.

### Return

Module path.

## `__shwrap_search`

Search a module path. \
Firstly it checks for existing modules with name `__shwrap_module` at
absolute or relative paths. Then it checks special locations - user paths,
load paths, and default path. User paths are paths from `SHWRAP_MODULE_PATHS`
array. Load paths are paths of modules in a current *import chain*. A default
path is a path stored in `SHWRAP_MODULE_PATH` variable. If nothing is found
it returns a fallback path which is a current working directory plus
`__shwrap_module` name.

### Synopsis

```shell
__shwrap_search __shwrap_module
```

### Parameters

- `__shwrap_module` \
  Module name.

### Return

Module path.

