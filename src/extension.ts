import { join as pathJoin } from "path";
import * as vscode from "vscode";

function setExternalLibrary(folder: string, enable: boolean) {
	const extensionId = "droidxrx.gameguardian-lua";
	const extensionPath = vscode.extensions.getExtension(extensionId)?.extensionPath; // prettier-ignore
	const config = vscode.workspace.getConfiguration("Lua");
	const library: string[] | undefined = config.get("workspace.library");
	if (library && extensionPath) {
		const folderPath = pathJoin(extensionPath, folder);
		for (let i = library.length - 1; i >= 0; i--) {
			const el = library[i];
			const isSelfExtension = el.indexOf(extensionId) > -1;
			const isCurrentVersion = el.indexOf(extensionPath) > -1;
			if (isSelfExtension && !isCurrentVersion) {
				library.splice(i, 1);
			}
		}
		const index = library.indexOf(folderPath);
		if (enable) {
			if (index == -1) {
				library.push(folderPath);
			}
		} else {
			if (index > -1) {
				library.splice(index, 1);
			}
		}
		config.update("workspace.library", library, true);
	}
}

export function activate(context: vscode.ExtensionContext) {
	setExternalLibrary("EmmyLua", true);
}
