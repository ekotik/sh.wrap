# run.sh

Module runner and cache functions.

## `shwrap_run`

Find a module hash and run `__shwrap_run` command with given arguments.

### Synopsis

```shell
shwrap_run __shwrap_module command_string
```

### Parameters

- `__shwrap_module` \
  Module name.
- `command_string` \
  Commands.

### Exit status

Exit status of commands.

## `__shwrap_run`

Find a module hash and run `__shwrap__run` command with given arguments.

### Synopsis

```shell
__shwrap_run __shwrap_module_path command_string
```

### Parameters

- `__shwrap_module_path` \
  Module path.
- `command_string` \
  Commands.

### Exit status

Exit status of commands.

## `__shwrap__run`

Run commands in a module scope.

### Synopsis

```shell
__shwrap__run __shwrap_module_path __shwrap_scope command_string
```
### Parameters

- `__shwrap_module_path` \
  Module path.
- `__shwrap_scope` \
  Module scope.
- `command_string` \
  Commands.

### Exit status

Exit status of commands.

## `__shwrap__cache`

Execute module, cache its function definitions and store its scope.

### Synopsis

```shell
__shwrap__cache __shwrap_module_path __shwrap_scope
```
### Parameters

- `__shwrap_module_path` \
  Module path.
- `__shwrap_scope` \
  Module scope.

### Exit status

Exit status of commands in a module.

