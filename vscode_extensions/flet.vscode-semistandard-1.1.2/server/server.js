/* --------------------------------------------------------------------------------------------
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See License.txt in the project root for license information.
 * ------------------------------------------------------------------------------------------ */
'use strict';
var vscode_languageserver_1 = require('vscode-languageserver');
var vscode_uri_1 = require('vscode-uri');
var path = require('path');
var ID = (function () {
    function ID() {
    }
    ID.next = function () {
        return "" + ID.base + ID.counter++;
    };
    ID.base = Date.now().toString() + "-";
    ID.counter = 0;
    return ID;
}());
function makeDiagnostic(problem) {
    var message = (problem.ruleId != null)
        ? problem.message + " (" + problem.ruleId + ")"
        : "" + problem.message;
    var startLine = Math.max(0, problem.line - 1);
    var startChar = Math.max(0, problem.column - 1);
    var endLine = problem.endLine != null ? Math.max(0, problem.endLine - 1) : startLine;
    var endChar = problem.endColumn != null ? Math.max(0, problem.endColumn - 1) : startChar;
    return {
        message: message,
        severity: convertSeverity(problem.severity),
        source: 'semistandard',
        range: {
            start: { line: startLine, character: startChar },
            end: { line: endLine, character: endChar }
        },
        code: problem.ruleId
    };
}
function computeKey(diagnostic) {
    var range = diagnostic.range;
    return "[" + range.start.line + "," + range.start.character + "," + range.end.line + "," + range.end.character + "]-" + diagnostic.code;
}
var codeActions = Object.create(null);
function recordCodeAction(document, diagnostic, problem) {
    if (!problem.fix || !problem.ruleId) {
        return;
    }
    var uri = document.uri;
    var edits = codeActions[uri];
    if (!edits) {
        edits = Object.create(null);
        codeActions[uri] = edits;
    }
    edits[computeKey(diagnostic)] = { label: "Fix this " + problem.ruleId + " problem", documentVersion: document.version, ruleId: problem.ruleId, edit: problem.fix };
}
function convertSeverity(severity) {
    switch (severity) {
        // Eslint 1 is warning
        case 1:
            return 2 /* Warning */;
        case 2:
            return 1 /* Error */;
        default:
            return 1 /* Error */;
    }
}
var exitCalled = { method: 'eslint/exitCalled' };
var nodeExit = process.exit;
process.exit = function (code) {
    var stack = new Error('stack');
    connection.sendNotification(exitCalled, [code ? code : 0, stack.stack]);
    setTimeout(function () {
        nodeExit(code);
    }, 1000);
};
var connection = vscode_languageserver_1.createConnection(new vscode_languageserver_1.IPCMessageReader(process), new vscode_languageserver_1.IPCMessageWriter(process));
var lib = null;
var eslintModulePath = null;
var settings = null;
var options = null;
var documents = new vscode_languageserver_1.TextDocuments();
var supportedLanguages = {
    'javascript': true,
    'javascriptreact': true
};
// The documents manager listen for text document create, change
// and close on the connection
documents.listen(connection);
// A text document has changed. Validate the document according the run setting.
documents.onDidChangeContent(function (event) {
    if (settings.semistandard.run === 'onType') {
        validateSingle(event.document);
    }
});
// A text document has been saved. Validate the document according the run setting.
documents.onDidSave(function (event) {
    if (settings.semistandard.run === 'onSave') {
        validateSingle(event.document);
    }
});
// Clear diagnostics on close.
documents.onDidClose(function (event) {
    connection.sendDiagnostics({ uri: event.document.uri, diagnostics: [] });
});
function trace(message, verbose) {
    connection.tracer.log(message, verbose);
}
connection.onInitialize(function (params) {
    var rootPath = params.rootPath;
    var initOptions = params.initializationOptions;
    var noStandardLib = new vscode_languageserver_1.ResponseError(100, 'Failed to load semistandard library.', { retry: false });
    var noLintText = new vscode_languageserver_1.ResponseError(101, 'The semistandard library doesn\'t export a lintText.', { retry: false });
    var result = { capabilities: { textDocumentSync: documents.syncKind, codeActionProvider: true } };
    var legacyModuleResolve = initOptions ? !!initOptions.legacyModuleResolve : false;
    if (legacyModuleResolve) {
        return vscode_languageserver_1.Files.resolveModule(rootPath, 'semistandard').then(function (value) {
            if (!value.lintText) {
                return noLintText;
            }
            lib = value;
            return result;
        }, function (error) {
            return noStandardLib;
        });
    }
    else {
        var nodePath = initOptions ? (initOptions.nodePath ? initOptions.nodePath : undefined) : undefined;
        var resolve = legacyModuleResolve ? vscode_languageserver_1.Files.resolveModule : vscode_languageserver_1.Files.resolveModule2;
        return vscode_languageserver_1.Files.resolveModule2(rootPath, 'semistandard', nodePath, trace).then(function (value) {
            if (!value.lintText) {
                return noLintText;
            }
            lib = value;
            return result;
        }, function (error) {
            return noStandardLib;
        });
    }
});
function getMessage(err, document) {
    var result = null;
    if (typeof err.message === 'string' || err.message instanceof String) {
        result = err.message;
        result = result.replace(/\r?\n/g, ' ');
        if (/^CLI: /.test(result)) {
            result = result.substr(5);
        }
    }
    else {
        result = "An unknown error occured while validating file: " + vscode_languageserver_1.Files.uriToFilePath(document.uri);
    }
    return result;
}
function validate(document) {
    if (!supportedLanguages[document.languageId]) {
        return;
    }
    var content = document.getText();
    var uri = document.uri;
    // Clean previously computed code actions.
    delete codeActions[uri];
    var diagnostics = [];
    lib.lintText(content, options, function (error, results) {
        var report = results;
        if (report && report.results && Array.isArray(report.results) && report.results.length > 0) {
            var docReport = report.results[0];
            if (docReport.messages && Array.isArray(docReport.messages)) {
                docReport.messages.forEach(function (problem) {
                    if (problem) {
                        var diagnostic = makeDiagnostic(problem);
                        diagnostics.push(diagnostic);
                        recordCodeAction(document, diagnostic, problem);
                    }
                });
            }
        }
        // Publish the diagnostics
        return connection.sendDiagnostics({ uri: uri, diagnostics: diagnostics });
    });
}
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
var NoConfigRequest;
(function (NoConfigRequest) {
    NoConfigRequest.type = { get method() { return 'eslint/noConfig'; } };
})(NoConfigRequest || (NoConfigRequest = {}));
var noConfigReported = Object.create(null);
function isNoConfigFoundError(error) {
    var candidate = error;
    return candidate.messageTemplate === 'no-config-found' || candidate.message === 'No ESLint configuration found.';
}
function tryHandleNoConfig(error, document) {
    if (!isNoConfigFoundError(error)) {
        return undefined;
    }
    if (!noConfigReported[document.uri]) {
        connection.sendRequest(NoConfigRequest.type, {
            message: getMessage(error, document),
            document: {
                uri: document.uri
            }
        })
            .then(undefined, function (error) { });
        noConfigReported[document.uri] = true;
    }
    return Status.warn;
}
var configErrorReported = Object.create(null);
function isConfigSyntaxError(err) {
    return err.message && /^Cannot read config file:/.test(err.message);
}
function tryHandleConfigError(error, document) {
    if (!error.message) {
        return undefined;
    }
    function handleFileName(filename) {
        if (!configErrorReported[filename]) {
            connection.console.warn(getMessage(error, document));
            if (!documents.get(vscode_uri_1.default.file(filename).toString())) {
                connection.window.showInformationMessage(getMessage(error, document));
            }
            configErrorReported[filename] = true;
        }
        return Status.warn;
    }
    var filename = undefined;
    var matches = /Cannot read config file:\s+(.*)\nError:\s+(.*)/.exec(error.message);
    if (matches && matches.length === 3) {
        return handleFileName(matches[1]);
    }
    matches = /(.*):\n\s*Configuration for rule \"(.*)\" is /.exec(error.message);
    if (matches && matches.length === 3) {
        return handleFileName(matches[1]);
    }
    matches = /Cannot find module '([^']*)'\nReferenced from:\s+(.*)/.exec(error.message);
    if (matches && matches.length === 3) {
        return handleFileName(matches[2]);
    }
    return undefined;
}
function showErrorMessage(error, document) {
    connection.window.showErrorMessage(getMessage(error, document));
    return Status.error;
}
var singleErrorHandlers = [
    tryHandleNoConfig,
    tryHandleConfigError,
    showErrorMessage
];
function validateSingle(document) {
    try {
        validate(document);
        connection.sendNotification(StatusNotification.type, { state: Status.ok });
    }
    catch (err) {
        var status_1 = undefined;
        for (var _i = 0, singleErrorHandlers_1 = singleErrorHandlers; _i < singleErrorHandlers_1.length; _i++) {
            var handler = singleErrorHandlers_1[_i];
            status_1 = handler(err, document);
            if (status_1) {
                break;
            }
        }
        status_1 = status_1 || Status.error;
        connection.sendNotification(StatusNotification.type, { state: status_1 });
    }
}
var manyErrorHandlers = [
    tryHandleNoConfig,
    tryHandleConfigError
];
function validateMany(documents) {
    var tracker = new vscode_languageserver_1.ErrorMessageTracker();
    var status = Status.ok;
    documents.forEach(function (document) {
        try {
            validate(document);
        }
        catch (err) {
            var handled = false;
            for (var _i = 0, manyErrorHandlers_1 = manyErrorHandlers; _i < manyErrorHandlers_1.length; _i++) {
                var handler = manyErrorHandlers_1[_i];
                status = handler(err, document);
                if (status) {
                    handled = true;
                    break;
                }
            }
            if (!handled) {
                tracker.add(getMessage(err, document));
            }
        }
    });
    tracker.sendErrors(connection);
    status = status || Status.error;
    connection.sendNotification(StatusNotification.type, { state: status });
}
connection.onDidChangeConfiguration(function (params) {
    settings = params.settings;
    if (settings.semistandard) {
        options = settings.semistandard.options || {};
    }
    // Settings have changed. Revalidate all documents.
    validateMany(documents.all());
});
connection.onDidChangeWatchedFiles(function (params) {
    // A .eslintrc has change. No smartness here.
    // Simply revalidate all file.
    noConfigReported = Object.create(null);
    params.changes.forEach(function (change) {
        var fspath = vscode_languageserver_1.Files.uriToFilePath(change.uri);
        var dirname = path.dirname(fspath);
        if (dirname) {
            try {
                lib.lintText("", options, function (error, results) { });
                delete configErrorReported[fspath];
            }
            catch (error) {
            }
        }
    });
    validateMany(documents.all());
});
var Fixes = (function () {
    function Fixes(edits) {
        this.edits = edits;
        this.keys = Object.keys(edits);
    }
    Fixes.overlaps = function (lastEdit, newEdit) {
        return !!lastEdit && lastEdit.edit.range[1] > newEdit.edit.range[0];
    };
    Fixes.prototype.isEmpty = function () {
        return this.keys.length === 0;
    };
    Fixes.prototype.getDocumentVersion = function () {
        return this.edits[this.keys[0]].documentVersion;
    };
    Fixes.prototype.getScoped = function (diagnostics) {
        var result = [];
        for (var _i = 0, diagnostics_1 = diagnostics; _i < diagnostics_1.length; _i++) {
            var diagnostic = diagnostics_1[_i];
            var key = computeKey(diagnostic);
            var editInfo = this.edits[key];
            if (editInfo) {
                result.push(editInfo);
            }
        }
        return result;
    };
    Fixes.prototype.getAllSorted = function () {
        var _this = this;
        var result = this.keys.map(function (key) { return _this.edits[key]; });
        return result.sort(function (a, b) {
            var d = a.edit.range[0] - b.edit.range[0];
            if (d !== 0) {
                return d;
            }
            if (a.edit.range[1] === 0) {
                return -1;
            }
            if (b.edit.range[1] === 0) {
                return 1;
            }
            return a.edit.range[1] - b.edit.range[1];
        });
    };
    Fixes.prototype.getOverlapFree = function () {
        var sorted = this.getAllSorted();
        if (sorted.length <= 1) {
            return sorted;
        }
        var result = [];
        var last = sorted[0];
        result.push(last);
        for (var i = 1; i < sorted.length; i++) {
            var current = sorted[i];
            if (!Fixes.overlaps(last, current)) {
                result.push(current);
                last = current;
            }
        }
        return result;
    };
    return Fixes;
}());
connection.onCodeAction(function (params) {
    var result = [];
    var uri = params.textDocument.uri;
    var edits = codeActions[uri];
    if (!edits) {
        return result;
    }
    var fixes = new Fixes(edits);
    if (fixes.isEmpty()) {
        return result;
    }
    var textDocument = documents.get(uri);
    var documentVersion = -1;
    var ruleId;
    function createTextEdit(editInfo) {
        return vscode_languageserver_1.TextEdit.replace(vscode_languageserver_1.Range.create(textDocument.positionAt(editInfo.edit.range[0]), textDocument.positionAt(editInfo.edit.range[1])), editInfo.edit.text || '');
    }
    function getLastEdit(array) {
        var length = array.length;
        if (length === 0) {
            return undefined;
        }
        return array[length - 1];
    }
    for (var _i = 0, _a = fixes.getScoped(params.context.diagnostics); _i < _a.length; _i++) {
        var editInfo = _a[_i];
        documentVersion = editInfo.documentVersion;
        ruleId = editInfo.ruleId;
        result.push(vscode_languageserver_1.Command.create(editInfo.label, 'semistandard.applySingleFix', uri, documentVersion, [
            createTextEdit(editInfo)
        ]));
    }
    ;
    if (result.length > 0) {
        var same = [];
        var all = [];
        for (var _b = 0, _c = fixes.getAllSorted(); _b < _c.length; _b++) {
            var editInfo = _c[_b];
            if (documentVersion === -1) {
                documentVersion = editInfo.documentVersion;
            }
            if (editInfo.ruleId === ruleId && !Fixes.overlaps(getLastEdit(same), editInfo)) {
                same.push(editInfo);
            }
            if (!Fixes.overlaps(getLastEdit(all), editInfo)) {
                all.push(editInfo);
            }
        }
        if (same.length > 1) {
            result.push(vscode_languageserver_1.Command.create("Fix all " + ruleId + " problems", 'semistandard.applySameFixes', uri, documentVersion, same.map(createTextEdit)));
        }
        if (all.length > 1) {
            result.push(vscode_languageserver_1.Command.create("Fix all auto-fixable problems", 'semistandard.applyAllFixes', uri, documentVersion, all.map(createTextEdit)));
        }
    }
    return result;
});
var AllFixesRequest;
(function (AllFixesRequest) {
    AllFixesRequest.type = { get method() { return 'textDocument/eslint/allFixes'; } };
})(AllFixesRequest || (AllFixesRequest = {}));
connection.onRequest(AllFixesRequest.type, function (params) {
    var result = null;
    var uri = params.textDocument.uri;
    var textDocument = documents.get(uri);
    var edits = codeActions[uri];
    function createTextEdit(editInfo) {
        return vscode_languageserver_1.TextEdit.replace(vscode_languageserver_1.Range.create(textDocument.positionAt(editInfo.edit.range[0]), textDocument.positionAt(editInfo.edit.range[1])), editInfo.edit.text || '');
    }
    if (edits) {
        var fixes = new Fixes(edits);
        if (!fixes.isEmpty()) {
            result = {
                documentVersion: fixes.getDocumentVersion(),
                edits: fixes.getOverlapFree().map(createTextEdit)
            };
        }
    }
    return result;
});
connection.listen();
//# sourceMappingURL=server.js.map