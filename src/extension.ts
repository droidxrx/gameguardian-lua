import { join as pathJoin, normalize as pathNormalize } from "path";
import fs from "fs"
import * as vscode from "vscode";

interface Extension {
    id: string;
    path: string;
    workspaceFolders: string[] | null;
}

interface LuarcJson {
    "workspace.library": string[]
}

const extension: Extension = {
    id: "",
    path: "",
    workspaceFolders : null
}

const keyWorkspaceLibrary = "workspace.library"

function parseLuarcJson(text: string, defaultOnError: LuarcJson): LuarcJson {
    try {
        return JSON.parse(text)
    } catch (error: any) {
    }
    return defaultOnError
}

function getLuarcJson(workspaceFolder: string): LuarcJson {
    const luarcJsonPath = pathJoin(workspaceFolder, '.luarc.json')
    const luarcJson: LuarcJson = { [keyWorkspaceLibrary]: [] }

    if (fs.existsSync(luarcJsonPath)) {
        try {
            const parsed = parseLuarcJson(fs.readFileSync(luarcJsonPath, { encoding: "utf8" }), luarcJson)
            if (Object.hasOwn(parsed, keyWorkspaceLibrary) && parsed[keyWorkspaceLibrary].constructor != Array) {
                parsed[keyWorkspaceLibrary] = []
            }
            return parsed
        } catch (error: any) {
        }
    }

    return luarcJson
}

function writeLuarcJson(workspaceFolder: string, luarcJson: LuarcJson) {
    const luarcJsonPath = pathJoin(workspaceFolder, '.luarc.json')
    fs.writeFileSync(luarcJsonPath, JSON.stringify(luarcJson, null, 4))
}

function updateLuarcJson(bIsOnActive: boolean) {
    if (extension.workspaceFolders != null) {
        const metaPath = pathNormalize(pathJoin(extension.path, "EmmyLua"))

        for (const workspaceFolder of extension.workspaceFolders) {
            const luarcJson = getLuarcJson(workspaceFolder)
            const libraries = [...luarcJson[keyWorkspaceLibrary]]

            for (const library of libraries) {
                if (pathNormalize(library) === metaPath) {
                    luarcJson[keyWorkspaceLibrary] = luarcJson[keyWorkspaceLibrary].filter((v,i) => v != library)
                }
            }

            if (bIsOnActive) {
                luarcJson[keyWorkspaceLibrary].push(metaPath)
            }

            writeLuarcJson(workspaceFolder, luarcJson)
        }
    }
}

export function activate(context: vscode.ExtensionContext) {
    extension.id = context.extension.id
    extension.path = pathNormalize(context.extension.extensionPath)
    extension.workspaceFolders = (vscode.workspace.workspaceFolders != undefined) ? vscode.workspace.workspaceFolders.map(v => v.uri.fsPath) : null

    updateLuarcJson(true)
}

export function deactivate() {
    updateLuarcJson(false)
}