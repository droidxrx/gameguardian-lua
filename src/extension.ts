import { join as pathJoin, normalize as pathNormalize } from "path";
import fs from "fs";
import * as vscode from "vscode";

interface Extension {
	id: string;
	path: string;
	workspaceFolders: string[] | null;
}

interface LuarcJson {
	"workspace.library": string[];
	"diagnostics.disable": string[];
}

const extension: Extension = {
	id: "",
	path: "",
	workspaceFolders: null,
};

const keyWorkspaceLibrary = "workspace.library";
const keyDiagnosticsDisable = "diagnostics.disable";

function parseLuarcJson(text: string, defaultOnError: LuarcJson): LuarcJson {
	try {
		return JSON.parse(text);
	} catch (error: any) {}
	return defaultOnError;
}

function getLuarcJson(workspaceFolder: string): LuarcJson {
	const luarcJsonPath = pathJoin(workspaceFolder, ".luarc.json");
	const luarcJson: LuarcJson = { [keyWorkspaceLibrary]: [], [keyDiagnosticsDisable]: [] };

	if (fs.existsSync(luarcJsonPath)) {
		try {
			const parsed = parseLuarcJson(fs.readFileSync(luarcJsonPath, { encoding: "utf8" }), luarcJson);
			if (Object.hasOwn(parsed, keyWorkspaceLibrary)) {
				if (parsed[keyWorkspaceLibrary].constructor != Array) {
					parsed[keyWorkspaceLibrary] = [];
				}
			} else {
				parsed[keyWorkspaceLibrary] = [];
			}
            
			if (Object.hasOwn(parsed, keyDiagnosticsDisable)) {
				if (parsed[keyDiagnosticsDisable].constructor != Array) {
					parsed[keyDiagnosticsDisable] = [];
				}
			} else {
				parsed[keyDiagnosticsDisable] = [];
			}
			return parsed;
		} catch (error: any) {}
	}

	return luarcJson;
}

function writeLuarcJson(workspaceFolder: string, luarcJson: LuarcJson) {
	const luarcJsonPath = pathJoin(workspaceFolder, ".luarc.json");
	fs.writeFileSync(luarcJsonPath, JSON.stringify(luarcJson, null, 4));
}

function updateLuarcJson(bIsOnActive: boolean) {
	if (extension.workspaceFolders != null) {
		const metaPath = pathNormalize(pathJoin(extension.path, "EmmyLua"));

		for (const workspaceFolder of extension.workspaceFolders) {
			const luarcJson = getLuarcJson(workspaceFolder);
			const libraries = [...luarcJson[keyWorkspaceLibrary]];
			const diagnosticsDisable = [...luarcJson[keyDiagnosticsDisable]];

            luarcJson[keyWorkspaceLibrary] = libraries.filter((v, i) => !v.toLowerCase().includes(extension.id));

            luarcJson[keyDiagnosticsDisable] = diagnosticsDisable.filter((v, i) => v.toLowerCase() != "inject-field");

			if (bIsOnActive) {
				luarcJson[keyWorkspaceLibrary].push(metaPath);
				luarcJson[keyDiagnosticsDisable].push("inject-field");
			}

			writeLuarcJson(workspaceFolder, luarcJson);
		}
	}
}

export function activate(context: vscode.ExtensionContext) {
	extension.id = context.extension.id.toLowerCase();
	extension.path = pathNormalize(context.extension.extensionPath);
	extension.workspaceFolders = vscode.workspace.workspaceFolders != undefined ? vscode.workspace.workspaceFolders.map((v) => v.uri.fsPath) : null;

	updateLuarcJson(true);
}

export function deactivate() {
	updateLuarcJson(false);
}