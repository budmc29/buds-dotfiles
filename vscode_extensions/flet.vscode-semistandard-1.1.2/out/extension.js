/* --------------------------------------------------------------------------------------------
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See License.txt in the project root for license information.
 * ------------------------------------------------------------------------------------------ */
'use strict';
const path = require('path');
const vscode_1 = require('vscode');
const vscode_languageclient_1 = require('vscode-languageclient');
var AllFixesRequest;
(function (AllFixesRequest) {
    AllFixesRequest.type = { get method() { return 'textDocument/eslint/allFixes'; } };
})(AllFixesRequest || (AllFixesRequest = {}));
let noConfigShown = false;
var NoConfigRequest;
(function (NoConfigRequest) {
    NoConfigRequest.type = { get method() { return 'eslint/noConfig'; } };
})(NoConfigRequest || (NoConfigRequest = {}));
var Status;
(function (Status) {
    Status[Status["ok"] = 1] = "ok";
    Status[Status["warn"] = 2] = "warn";
    Status[Status["error"] = 3] = "error";
})(Status || (Status = {}));
var StatusNotification;
(function (StatusNotification) {
    StatusNotification.type = { get method() { return 'eslint/noConfig'; } };
})(StatusNotification || (StatusNotification = {}));
const exitCalled = { method: 'eslint/exitCalled' };
let willSaveTextDocument;
function activate(context) {
    let statusBarItem = vscode_1.window.createStatusBarItem(vscode_1.StatusBarAlignment.Right, 0);
    let eslintStatus = Status.ok;
    let serverRunning = false;
    statusBarItem.text = 'JavaScript Semistandard Style';
    statusBarItem.command = 'semistandard.showOutputChannel';
    function showStatusBarItem(show) {
        if (show) {
            statusBarItem.show();
        }
        else {
            statusBarItem.hide();
        }
    }
    function updateStatus(status) {
        switch (status) {
            case Status.ok:
                statusBarItem.color = undefined;
                break;
            case Status.warn:
                statusBarItem.color = 'yellow';
                break;
            case Status.error:
                statusBarItem.color = 'darkred';
                break;
        }
        eslintStatus = status;
        udpateStatusBarVisibility(vscode_1.window.activeTextEditor);
    }
    function udpateStatusBarVisibility(editor) {
        statusBarItem.text = eslintStatus === Status.ok ? 'JavaScript Semistandard Style' : 'JavaScript Semistandard Style!';
        showStatusBarItem(serverRunning &&
            (eslintStatus !== Status.ok ||
                (editor && (editor.document.languageId === 'javascript' || editor.document.languageId === 'javascriptreact'))));
    }
    vscode_1.window.onDidChangeActiveTextEditor(udpateStatusBarVisibility);
    udpateStatusBarVisibility(vscode_1.window.activeTextEditor);
    // We need to go one level up since an extension compile the js code into
    // the output folder.
    // serverModule
    let serverModule = path.join(__dirname, '..', 'server', 'server.js');
    let debugOptions = { execArgv: ["--nolazy", "--debug=6004"] };
    let serverOptions = {
        run: { module: serverModule, transport: vscode_languageclient_1.TransportKind.ipc },
        debug: { module: serverModule, transport: vscode_languageclient_1.TransportKind.ipc, options: debugOptions }
    };
    let defaultErrorHandler;
    let serverCalledProcessExit = false;
    let languages = ['javascript', 'javascriptreact'];
    let languageIds = new Set(languages);
    let clientOptions = {
        documentSelector: languages,
        diagnosticCollectionName: 'eslint',
        synchronize: {
            configurationSection: 'semistandard',
            fileEvents: [
                vscode_1.workspace.createFileSystemWatcher('**/package.json')
            ],
            textDocumentFilter: (textDocument) => {
                let fsPath = textDocument.fileName;
                if (fsPath) {
                    let basename = path.basename(fsPath);
                    return /^package.json$/.test(basename);
                }
            }
        },
        initializationOptions: () => {
            let configuration = vscode_1.workspace.getConfiguration('semistandard');
            return {
                legacyModuleResolve: configuration ? configuration.get('_legacyModuleResolve', false) : false,
                nodePath: configuration ? configuration.get('nodePath', undefined) : undefined
            };
        },
        initializationFailedHandler: (error) => {
            if (error instanceof vscode_languageclient_1.ResponseError) {
                let responseError = error;
                if (responseError.code === 100) {
                    const key = 'noSemistandardMessageShown';
                    let state = context.globalState.get(key, {});
                    if (vscode_1.workspace.rootPath) {
                        client.info([
                            'Failed to load the semistandard library.',
                            'To use semistandard in this workspace please install semistandard using \'npm install semistandard\' or globally using \'npm install -g semistandard\'.',
                            'You need to reopen the workspace after installing semistandard.',
                        ].join('\n'));
                        if (!state.workspaces) {
                            state.workspaces = Object.create(null);
                        }
                        if (!state.workspaces[vscode_1.workspace.rootPath]) {
                            state.workspaces[vscode_1.workspace.rootPath] = true;
                            client.outputChannel.show(true);
                            context.globalState.update(key, state);
                        }
                    }
                    else {
                        client.info([
                            'Failed to load the semistandard library.',
                            'To use semistandard for single JavaScript files install semistandard globally using \'npm install -g semistandard\'.',
                            'You need to reopen VS Code after installing semistandard.',
                        ].join('\n'));
                        if (!state.global) {
                            state.global = true;
                            client.outputChannel.show(true);
                            context.globalState.update(key, state);
                        }
                    }
                }
                else {
                    client.error('Server initialization failed.', error);
                    client.outputChannel.show(true);
                }
            }
            else {
                client.error('Server initialization failed.', error);
                client.outputChannel.show(true);
            }
            return false;
        },
        errorHandler: {
            error: (error, message, count) => {
                return defaultErrorHandler.error(error, message, count);
            },
            closed: () => {
                if (serverCalledProcessExit) {
                    return vscode_languageclient_1.CloseAction.DoNotRestart;
                }
                return defaultErrorHandler.closed();
            }
        }
    };
    let client = new vscode_languageclient_1.LanguageClient('semistandard', serverOptions, clientOptions);
    const running = 'JavaScript Semistandard Style server is running.';
    const stopped = 'JavaScript Semistandard Style server stopped.';
    client.onDidChangeState((event) => {
        if (event.newState === vscode_languageclient_1.State.Running) {
            client.info(running);
            statusBarItem.tooltip = running;
            serverRunning = true;
        }
        else {
            client.info(stopped);
            statusBarItem.tooltip = stopped;
            serverRunning = false;
        }
        udpateStatusBarVisibility(vscode_1.window.activeTextEditor);
    });
    client.onNotification(StatusNotification.type, (params) => {
        updateStatus(params.state);
    });
    defaultErrorHandler = client.createDefaultErrorHandler();
    client.onNotification(exitCalled, (params) => {
        serverCalledProcessExit = true;
        client.error(`Server process exited with code ${params[0]}. This usually indicates a misconfigured semistandard setup.`, params[1]);
        vscode_1.window.showErrorMessage(`JavaScript Semistandard Style server shut down itself. See 'JavaScript Semistandard Style' output channel for details.`);
    });
    function applyTextEdits(uri, documentVersion, edits) {
        let textEditor = vscode_1.window.activeTextEditor;
        if (textEditor && textEditor.document.uri.toString() === uri) {
            if (textEditor.document.version !== documentVersion) {
                vscode_1.window.showInformationMessage(`JavaScript Semistandard Style fixes are outdated and can't be applied to the document.`);
            }
            textEditor.edit(mutator => {
                for (let edit of edits) {
                    mutator.replace(vscode_languageclient_1.Protocol2Code.asRange(edit.range), edit.newText);
                }
            }).then((success) => {
                if (!success) {
                    vscode_1.window.showErrorMessage('Failed to apply JavaScript Semistandard Style fixes to the document. Please consider opening an issue with steps to reproduce.');
                }
            });
        }
    }
    function runAutoFix() {
        let textEditor = vscode_1.window.activeTextEditor;
        if (!textEditor) {
            return;
        }
        let uri = textEditor.document.uri.toString();
        client.sendRequest(AllFixesRequest.type, { textDocument: { uri } }).then((result) => {
            if (result) {
                applyTextEdits(uri, result.documentVersion, result.edits);
            }
        }, (error) => {
            vscode_1.window.showErrorMessage('Failed to apply JavaScript Semistandard Style fixes to the document. Please consider opening an issue with steps to reproduce.');
        });
    }
    function configurationChanged() {
        let config = vscode_1.workspace.getConfiguration('semistandard');
        let autoFix = config.get('autoFixOnSave', false);
        if (autoFix && !willSaveTextDocument) {
            willSaveTextDocument = vscode_1.workspace.onWillSaveTextDocument((event) => {
                let document = event.document;
                if (!languageIds.has(document.languageId) || event.reason === vscode_1.TextDocumentSaveReason.AfterDelay) {
                    return;
                }
                const version = document.version;
                event.waitUntil(client.sendRequest(AllFixesRequest.type, { textDocument: { uri: document.uri.toString() } }).then((result) => {
                    if (result && version === result.documentVersion) {
                        return vscode_languageclient_1.Protocol2Code.asTextEdits(result.edits);
                    }
                    else {
                        return [];
                    }
                }));
            });
        }
        else if (!autoFix && willSaveTextDocument) {
            willSaveTextDocument.dispose();
            willSaveTextDocument = undefined;
        }
    }
    vscode_1.workspace.onDidChangeConfiguration(configurationChanged);
    configurationChanged();
    context.subscriptions.push(new vscode_languageclient_1.SettingMonitor(client, 'semistandard.enable').start(), vscode_1.commands.registerCommand('semistandard.applySingleFix', applyTextEdits), vscode_1.commands.registerCommand('semistandard.applySameFixes', applyTextEdits), vscode_1.commands.registerCommand('semistandard.applyAllFixes', applyTextEdits), vscode_1.commands.registerCommand('semistandard.executeAutofix', runAutoFix), vscode_1.commands.registerCommand('semistandard.showOutputChannel', () => { client.outputChannel.show(); }), statusBarItem);
}
exports.activate = activate;
function deactivate() {
    if (willSaveTextDocument) {
        willSaveTextDocument.dispose();
        willSaveTextDocument = undefined;
    }
}
exports.deactivate = deactivate;
//# sourceMappingURL=extension.js.map