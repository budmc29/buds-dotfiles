# vscode-semistandard

VSCode extension to integrate [JavaScript Semistandard Style](https://github.com/flet/semistandard) into VSCode.

Forked from the [chenxsan.vscode-standardjs extension](https://github.com/chenxsan/vscode-standardjs)

## Settings Options

This extension contributes the following variables to the [settings](https://code.visualstudio.com/docs/customization/userandworkspace):

- `semistandard.enable`: enable/disable semistandard. Is enabled by default.
- `semistandard.options`: options to configure how semistandard is started. Defaults to an empty option bag.
- `semistandard.run` - run the linter `onSave` or `onType`, default is `onType`.
- `semistandard.nodePath` - use this setting if an installed StandardJS package can't be detected, for example `/myGlobalNodePackages/node_modules`.

## Commands:

This extension contributes the following commands to the Command palette.

- `Fix all auto-fixable problems`: applies Standard auto-fix resolutions to all fixable problems.

## Release Notes:

### 1.0.8

- Supports auto fix on save. Needs to be enabled via `"semistandard.autoFixOnSave": true`. Please note that auto fix on save will only happen
if the save happened manually or via focus lost. This is consistent with VS Code's format on save behaviour. Auto fix on save requires
VS Code version 1.6 or newer.

### 1.0.5

- Moving to official 2.5.0 language server libraries.

### 1.0.4

- Bug fixing: semistandard is validating package.json files

### 1.0.3

- Errors in configuration files are only shown in a status message if the file is not open in the editor. Otherwise message are shown in the output channel only.

### 1.0.2

- Added a status bar item to inform the user about problems with Standard. A message box only appears if the user attention is required.
- Improved handling of missing corrupted configuration files.
- The Standard package is now loaded from parent folders as well.
