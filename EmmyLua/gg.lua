---@meta

---@class gg
---@field ANDROID_SDK_INT string
---@field ASM_ARM number
---@field ASM_ARM64 number
---@field ASM_THUMB number
---@field BUILD number
---@field CACHE_DIR string
---@field DUMP_SKIP_SYSTEM_LIBS number
---@field EXT_CACHE_DIR string
---@field EXT_FILES_DIR string
---@field EXT_STORAGE string
---@field FILES_DIR string
---@field FREEZE_IN_RANGE number
---@field FREEZE_MAY_DECREASE number
---@field FREEZE_MAY_INCREASE number
---@field FREEZE_NORMAL number
---@field LOAD_APPEND number
---@field LOAD_VALUES number
---@field LOAD_VALUES_FREEZE number
---@field PACKAGE string
---@field POINTER_EXECUTABLE number
---@field POINTER_EXECUTABLE_WRITABLE number
---@field POINTER_NO number
---@field POINTER_READ_ONLY number
---@field POINTER_WRITABLE number
---@field PROT_EXEC number
---@field PROT_NONE number
---@field PROT_READ number
---@field PROT_WRITE number
---@field REGION_ANONYMOUS number
---@field REGION_ASHMEM number
---@field REGION_BAD number
---@field REGION_C_ALLOC number
---@field REGION_C_BSS number
---@field REGION_C_DATA number
---@field REGION_C_HEAP number
---@field REGION_CODE_APP number
---@field REGION_CODE_SYS number
---@field REGION_JAVA number
---@field REGION_JAVA_HEAP number
---@field REGION_OTHER number
---@field REGION_PPSSPP number
---@field REGION_STACK number
---@field REGION_VIDEO number
---@field SAVE_AS_TEXT number
---@field SIGN_EQUAL number
---@field SIGN_FUZZY_EQUAL number
---@field SIGN_FUZZY_GREATER number
---@field SIGN_FUZZY_LESS number
---@field SIGN_FUZZY_NOT_EQUAL number
---@field SIGN_GREATER_OR_EQUAL number
---@field SIGN_LESS_OR_EQUAL number
---@field SIGN_NOT_EQUAL number
---@field TAB_MEMORY_EDITOR number
---@field TAB_SAVED_LIST number
---@field TAB_SEARCH number
---@field TAB_SETTINGS number
---@field TYPE_AUTO number
---@field TYPE_BYTE number
---@field TYPE_DOUBLE number
---@field TYPE_DWORD number
---@field TYPE_FLOAT number
---@field TYPE_QWORD number
---@field TYPE_WORD number
---@field TYPE_XOR number
---@field VERSION string
---@field VERSION_INT number
gg = {}

--- Add items to the saved list.
--- @param items table items A table with a list of items to add. Each element is a table with the following fields: address (long, required), value (string with a value, optional), flags (one of the constants TYPE_*, required), name (string, optional), freeze (boolean, optional, default false), freezeType (one of the constants FREEZE_*, optional, default FREEZE_NORMAL), freezeFrom (string, optional), freezeTo (string, optional). Values must be in English locale.
--- @return true|string --True or string with error.
--- ```
--- -- retrieving a table from another call
--- gg.searchNumber('10', gg.TYPE_DWORD)
--- t = gg.getResults(5) -- load items
--- t[1].value = '15'
--- t[1].freeze = true
--- print('addListItems: ', gg.addListItems(t))
---
--- -- creating a table as a list of items
--- t = {}
--- t[1] = {}
--- t[1].address = 0x18004030 -- some desired address
--- t[1].flags = gg.TYPE_DWORD
--- t[1].value = 12345
--- t[2] = {}
--- t[2].address = 0x18004040 -- another desired address
--- t[2].flags = gg.TYPE_BYTE
--- t[2].value = '7Fh'
--- t[2].freeze = true
--- t[3] = {}
--- t[3].address = 0x18005040 -- another desired address
--- t[3].flags = gg.TYPE_DWORD
--- t[3].value = '777'
--- t[3].freeze = true
--- t[3].freezeType = gg.FREEZE_MAY_INCREASE
--- t[4] = {}
--- t[4].address = 0x18007040 -- another desired address
--- t[4].flags = gg.TYPE_DWORD
--- t[4].value = '7777'
--- t[4].freeze = true
--- t[4].freezeType = gg.FREEZE_IN_RANGE
--- t[4].freezeFrom = '6666'
--- t[4].freezeTo = '8888'
--- print('addListItems: ', gg.addListItems(t))
---
--- -- The first 7 results are frozen with a value of 8.
--- gg.searchNumber('10', gg.TYPE_DWORD)
--- local t = gg.getResults(7)
--- for i, v in ipairs(t) do
---  t[i].value = '8'
---  t[i].freeze = true
--- end
--- gg.addListItems(t)
--- ```
function gg.addListItems(items) end

--- Displays a dialog with several buttons.
---
--- The return result depends on which of the buttons was pressed. The dialog can be canceled with the "Back" button (return code 0).
--- @param text string Text message.
--- @param positive? string Text for positive button. This button return code 1.
--- @param negative? string | nil Text for negative button. This button return code 2.
--- @param neutral? string | nil Text for neutral button. This button return code 3.
--- @return number --if dialog canceled - 0, else: 1 for positive, 2 for negative, 3 for neutral buttons.
--- ```
--- gg.alert('Script ended')
--- -- Show alert with single 'ok' button
--- gg.alert('Script ended', 'Yes')
--- -- Show alert with single 'Yes' button
--- gg.alert('A or B?', 'A', 'B')
--- -- Show alert with two buttons
--- gg.alert('A or C?', 'A', nil, 'C')
--- -- Show alert with two buttons
--- gg.alert('A or B or C?', 'A', 'B', 'C')
--- -- Show alert with three buttons
--- ```
function gg.alert(text, positive, negative, neutral) end

--- Allocated memory page (4 KB) in the target process.
--- @param mode? number Bit mask of flags gg.PROT_*.
--- @param address? number If is not 0, then the kernel takes it as a hint about where to place the page; on Android, the page will be allocated at a nearby address page boundary.
--- @return number|string --Address of the page or string with error.
--- ```
--- print('allocatePage 1: ', string.format('0x%08x', gg.allocatePage()))
--- print('allocatePage 2: ', string.format('0x%08x', gg.allocatePage(gg.PROT_READ | gg.PROT_EXEC)))
--- print('allocatePage 3: ', string.format('0x%08x', gg.allocatePage(gg.PROT_READ | gg.PROT_WRITE)))
--- print('allocatePage 4: ', string.format('0x%08x', gg.allocatePage(gg.PROT_READ)))
--- print('allocatePage 5: ', string.format('0x%08x', gg.allocatePage(gg.PROT_READ | gg.PROT_WRITE, 0x12345)))
--- ```
function gg.allocatePage(mode, address) end

--- Gets the text bytes in the specified encoding.
--- @param text string
--- @param encoding? 'ISO-8859-1'|'US-ASCII'|'UTF-16'|'UTF-16BE'|'UTF-16LE'|'UTF-8' Possible values: 'ISO-8859-1', 'US-ASCII', 'UTF-16', 'UTF-16BE', 'UTF-16LE', 'UTF-8'
--- @return table --A table with a set of bytes in the specified encoding.
---```
--- print('UTF-8', gg.bytes('example'))
--- print('UTF-8', gg.bytes('example', 'UTF-8'))
--- print('UTF-16', gg.bytes('example', 'UTF-16LE'))
---```
function gg.bytes(text, encoding) end

--- Displays the selection dialog from the list.
---
--- The list is made up of the items table. Selected sets the index of the table that will be selected by default. Items must be numberic-array if you want show items in specified order.
--- @param items table<string> Table with items for choice.
--- @param selected? number Is not specified or is specified as nil, then the list will be without the default choice.
--- @param message? string Specifies the optional title of the dialog box.
--- @return nil|number --nil if the dialog has been canceled, or the index of the selected item.
---```
--- print('1: ', gg.choice({'A', 'B', 'C', 'D'}))
--- -- show list of 4 items
--- print('2: ', gg.choice({'A', 'B', 'C', 'D'}, 2))
--- -- show list of 4 items with selected 2 item
--- print('3: ', gg.choice({'A', 'B', 'C', 'D'}, 3, 'Select letter:'))
--- -- show list of 4 items with selected 3 item and message
--- print('4: ', gg.choice({'A', 'B', 'C', 'D'}, nil, 'Select letter:'))
--- -- show list of 4 items without selection and message
---```
function gg.choice(items, selected, message) end

--- Clear the saved list.
--- @return true|string --true or string with error.
---```
--- print('clearList:', gg.clearList())
---```
function gg.clearList() end

--- Clear the list of search results.
function gg.clearResults() end

--- Copy memory.
--- @param from number Address for source of copy.
--- @param to number Address for destination of copy.
--- @param bytes number Amount bytes to copy.
--- @return true|string --true or string with error.
---```
--- print('copyMemory:', gg.copyMemory(0x9000, 0x9010, 3))
--- -- copies 3 bytes 0x9000-0x9002 to 0x9010-0x9012
---```
function gg.copyMemory(from, to, bytes) end

--- Copy text to the clipboard.
---
--- If the second parameter is true or not specified, the text will be converted as a number from the English locale to the selected one.
--- @param text string The text for copy.
--- @param fixLocale boolean Flag to disable fix locale-specific separators.
---```
--- -- selected 'ru' locale, where decimal separator is ',' and thousand separator is ' '.
--- -- in English locale (en_US) decimal separator is '.' and thousand separator is ','.
--- gg.copyText('1,234,567.890') -- Will copy '1 234 567,890'
--- gg.copyText('1,234,567.890', true) -- Will copy '1 234 567,890'
--- gg.copyText('1,234,567.890', false) -- Will copy '1,234,567.890'
---```
function gg.copyText(text, fixLocale) end

--- Disassemble the specified value.
--- @param type number Type. One of the constants gg.ASM_*. Throws an error if a non-existent type is passed.
--- @param address number The address of the value. May be needed for some opcodes.
--- @param opcode number Disassembly instruction. To disassemble Thumb32, the first 16-bit instruction should be in the lower half-word of the opcode, and the second in the upper half-word.
--- @return string --string Disassembled opcode string.
---```
--- print('ARM', gg.disasm(gg.ASM_ARM, 0x12345678, 0xE1A01002))
--- print('Thumb16', gg.disasm(gg.ASM_THUMB, 0x12345678, 0x0011))
--- print('Thumb32', gg.disasm(gg.ASM_THUMB, 0x12345678, 0xF800 | (0x0001 << 16)))
--- print('ARM64', gg.disasm(gg.ASM_ARM64, 0x12345678, 0x2A0103E2))
---```
function gg.disasm(type, address, opcode) end

--- Dump memory to files on disk.
--- @param from number Address for start dump. Will be rounded to largest possible memory page.
--- @param to number Address for end dump. Will be rounded to smallest possible memory page.
--- @param dir string Directory for save dump files.
--- @param flags? number Set of flags gg.DUMP_* or nil.
--- @return true|string --true or string with error.
---```
--- print('dumpMemory:', gg.dumpMemory(0x9000, 0x9010, '/sdcard/dump'))
--- -- dump at least one memory page into the dir '/sdcard/dump'
--- print('dumpMemory:', gg.dumpMemory(0, -1, '/sdcard/dump'))
--- print('dumpMemory:', gg.dumpMemory(0, -1, '/sdcard/dump', nil))
--- print('dumpMemory:', gg.dumpMemory(0, -1, '/sdcard/dump', 0))
--- -- dump all memory into the dir '/sdcard/dump' (all same)
--- print('dumpMemory:', gg.dumpMemory(0, -1, '/sdcard/dump', gg.DUMP_SKIP_SYSTEM_LIBS))
--- -- dump all memory except system libraries into the dir '/sdcard/dump'
---```
function gg.dumpMemory(from, to, dir, flags) end

--- Edit all search results.
---
--- Before call this method you must load results via getResults. Value will be applied only for results with specified type.
--- @param value string String with data for edit. Must be in English locale.
--- @param type number One constant from gg.TYPE_*.
--- @return number|string --Int with count of changes or string with error.
---```
--- gg.searchNumber('10', gg.TYPE_DWORD)
--- gg.getResults(5)
--- gg.editAll('15', gg.TYPE_DWORD)
--- -- with float:
--- gg.searchNumber('10.1', gg.TYPE_FLOAT)
--- gg.getResults(5)
--- gg.editAll('15.2', gg.TYPE_FLOAT)
--- -- with XOR mode
--- gg.searchNumber('10X4', gg.TYPE_DWORD)
--- gg.getResults(5)
--- gg.editAll('15X4', gg.TYPE_DWORD)
--- -- edit few values at once
--- gg.searchNumber('10', gg.TYPE_DWORD)
--- gg.getResults(5)
--- gg.editAll('7;13;43;24;11', gg.TYPE_DWORD)
--- -- edit HEX
--- gg.searchNumber('h 5C E3 0B')
--- gg.getResults(30)
--- gg.editAll('h 4B 90 9B', gg.TYPE_BYTE)
--- -- edit text UTF-8
--- gg.searchNumber(':şuşpançik')
--- gg.getResults(100000)
--- gg.editAll(':şUşPaNçIk', gg.TYPE_BYTE)
--- -- edit text UTF-16LE
--- gg.searchNumber(';şuşandra')
--- gg.getResults(100000)
--- gg.editAll(';şUşAnDrA', gg.TYPE_WORD) -- UTF-16LE use WORD not BYTE!
--- -- edit HEX + UTF-8
--- gg.searchNumber("Q 5C E3 0B 'şuşpançik' 9B 11 7B")
--- gg.getResults(100000)
--- gg.editAll("Q 43 12 34 'şUşPaNçIk' 9F 1A 70", gg.TYPE_BYTE)
--- -- edit HEX + UTF-16LE
--- gg.searchNumber('Q 5C E3 0B "şuşandra" 9B 11 7B')
--- gg.getResults(100000)
--- gg.editAll('Q 41 F7 87 "şUşAnDrA" 9B 18 7B', gg.TYPE_BYTE)
--- -- edit HEX + UTF-8 + UTF-16LE
--- gg.searchNumber('Q 5C E3 0B \'şuşpançik\' 9B "şuşandra" 11 7B')
--- gg.getResults(100000)
--- gg.editAll('Q 41 F7 87 \'şUşPaNçIk\' 04 "şUşAnDrA" 71 3B', gg.TYPE_BYTE)
--- -- edit ARM opcodes
--- gg.searchNumber('~A MOV R1, R2', gg.TYPE_DWORD)
--- gg.getResults(100000)
--- gg.editAll('~A MOV R2, R3', gg.TYPE_DWORD)
---```
function gg.editAll(value, type) end

--- Get active tab in the GameGuardian UI.
--- @return number --int One of the constants gg.TAB_*.
function gg.getActiveTab() end

--- Gets the filename of the currently running script.
--- @return string --The string with the filename of the currently running script.
--- E.G.: '/sdcard/Notes/gg.example.lua'
function gg.getFile() end

--- Gets the current line number of the script being executed.
--- @return number --The current line number of the script being executed.
--- E.G.: 24
function gg.getLine() end

--- Return the contents of the saved list as a table.
--- @return table --Table with results or string with error. Each element is a table with the following fields: address (long), value (number), flags (one of the constants TYPE_*), name (string), freeze (boolean), freezeType (one of the constants FREEZE_*), freezeFrom (string), freezeTo (string).
---```
--- local r = gg.getListItems()
--- print('Items: ', r)
--- print('First item: ', r[1])
--- print('First item address: ', r[1].address)
--- print('First item value: ', r[1].value)
--- print('First item type: ', r[1].flags)
--- print('First item name: ', r[1].name)
--- print('First item freeze: ', r[1].freeze)
--- print('First item freeze type: ', r[1].freezeType)
--- print('First item freeze from: ', r[1].freezeFrom)
--- print('First item freeze to: ', r[1].freezeTo)
---```
function gg.getListItems() end

--- Gets the string with the currently selected locale in the GameGuardian.
--- @return string --The string with the currently selected locale in the GameGuardian.
--- E.g.: en_US, zh_CN, ru, pt_BR, ar, uk
function gg.getLocale() end

--- Return memory regions as bit mask of flags gg.REGION_*.
--- @return number --Bit mask of flags gg.REGION_*.
function gg.getRanges() end

--- Get the list of memory regions of the selected process.
--- @param filter? string The filter string. If specified, only those results that fall under the filter will be returned. Optional. The filter supports wildcards: ^ - the start of the data, $ - the end of the data, * - any number of any characters, ? - the one any character.
--- @return {state:string, start:number, end:number, type:string, name:string, internalName:string}[] --A list table with memory regions. Each element is a table with fields: state, start, end, type, name, internalName.
---```
--- print(gg.getRangesList())
--- local t = gg.getRangesList();
--- print(t[1].start)
--- print(t[1]['end']) -- cannot use dot-notation here because 'end' is a keyword in Lua, so you need to use square-bracket notation.
--- print(gg.getRangesList('libc.so'))
--- print(gg.getRangesList('lib*.so'))
--- print(gg.getRangesList('^/data/'))
--- print(gg.getRangesList('.so$'))
---```
function gg.getRangesList(filter) end

--- Load results into results list and return its as a table.
--- @param maxCount number Max count of loaded results.
--- @param skip? number The count of skipped results from the beginning. By default - 0.
--- @param addressMin? number The minimum value of the address. Number or nil.
--- @param addressMax? number The maximum value of the address. Number or nil.
--- @param valueMin? number The minimum value of the value. Number as string or nil.
--- @param valueMax? number The maximum value of the value. Number as string or nil.
--- @param type? number Set of flags gg.TYPE_* or nil.
--- @param fractional? string Filter by fractional values. If the first character is "!", then the filter will exclude all values whose fractional part matches the specified one.
--- @param pointer? number Set of flags gg.POINTER_* or nil.
--- @return table|string --Table with results or string with error. Each element is a table with three keys: address (long), value (number), flags (one of the constants gg.TYPE_*).
---```
---gg.clearResults()
---gg.startFuzzy(gg.TYPE_AUTO)
---local r = gg.getResults(5)
---print('First 5 results: ', r)
---print('First result: ', r[1])
---print('First result address: ', r[1].address)
---print('First result value: ', r[1].value)
---print('First result type: ', r[1].flags)
---r = gg.getResults(3, 2)
---print('Skip 2 items and get next 3: ', r)
---r = gg.getResults(3, nil, 0x80000000, 0xF0000000)
---print('Address between 0x80000000 and 0xF0000000: ', r)
---r = gg.getResults(3, nil, nil, nil, 23, 45)
---print('Value between 23 and 45: ', r)
---r = gg.getResults(3, nil, nil, nil, nil, nil, gg.TYPE_DWORD | gg.TYPE_FLOAT)
---print('Dword or Float: ', r)
---r = gg.getResults(3, nil, nil, nil, nil, nil, nil, '0.5')
---print('Only with fractional part equal 0.5: ', r)
---r = gg.getResults(3, nil, nil, nil, nil, nil, nil, '!0.0')
---print('Only with fractional part not equal 0.0: ', r)
---r = gg.getResults(3, nil, nil, nil, nil, nil, nil, nil, gg.POINTER_READ_ONLY)
---print('Only pointers to read-only memory: ', r)
---```
function gg.getResults(maxCount, skip, addressMin, addressMax, valueMin, valueMax, type, fractional, pointer) end

--- Get the number of found results.
--- @return number --The number of found results.
---```
---gg.searchNumber('10', gg.TYPE_DWORD)
---print('Found: ', gg.getResultsCount())
---```
function gg.getResultsCount() end

--- Returns the selected adresses in the memory editor.
--- @return table|string --Table with adresses (long) or string with error.
---```
---print('Selected: ', gg.getSelectedElements())
---```
function gg.getSelectedElements() end

--- Returns the selected items in the saved lists.
--- @return table|string --Table with results or string with error. Each element is a table with the following fields: address (long), value (number), flags (one of the constants gg.TYPE_*), name (string), freeze (boolean), freezeType (one of the constants gg.FREEZE_*), freezeFrom (string), freezeTo (string).
---```
---print('Selected: ', gg.getSelectedListItems())
---```
function gg.getSelectedListItems() end

--- Returns the selected items in the search results.
--- @return table|string --Table with results or string with error. Each element is a table with three keys: address (long), value (number), flags (one of the constants gg.TYPE_*).
---```
---gg.searchNumber('10', gg.TYPE_DWORD)
---gg.getResults(5)
---print('Selected: ', gg.getSelectedResults())
---```
function gg.getSelectedResults() end

--- Get the current speed from the speedhack.
--- @return number --The current speed from the speedhack.
function gg.getSpeed() end

--- @class infoTarget
--- @field targetSdkVersion number The minimum SDK version this application targets.
--- @field sharedUserId string The shared user ID name of this package, as specified by the <manifest> tag's sharedUserId attribute.
--- @field sharedUserLabel number The shared user ID label of this package, as specified by the <manifest> tag's sharedUserLabel attribute.
--- @field firstInstallTime number The time at which the app was first installed.
--- @field packageName string The name of this package.
--- @field className string Class implementing the Application object.
--- @field RSS number The amount of RSS memory for the process, in KB.
--- @field theme number A style resource identifier (in the package's resources) of the default visual theme of the application.
--- @field x64 boolean True if the 64-bit process.
--- @field descriptionRes number A style resource identifier (in the package's resources) of the description of an application. From the "description" attribute or, if not set, 0.
--- @field activities {label:string, name:string}[] (name, label)
--- @field cmdLine string The contents of /proc/pid/cmdline.
--- @field versionName string The version name of this package, as specified by the <manifest> tag's versionName attribute.
--- @field name string
--- @field dataDir string Full path to the default directory assigned to the package for its persistent data.
--- @field enabledSetting number
--- @field flags number Flags associated with the application.
--- @field labelRes number
--- @field sourceDir string Full path to the base APK for this application.
--- @field installer string
--- @field logo number
--- @field publicSourceDir string Full path to the publicly available parts of sourceDir, including resources and manifest.
--- @field versionCode number This field was deprecated in API level 28. Use getLongVersionCode() instead, which includes both this and the additional versionCodeMajor attribute. The version number of this package, as specified by the <manifest> tag's versionCode attribute.
--- @field icon number
--- @field nativeLibraryDir string Full path to the directory where native JNI libraries are stored.
--- @field taskAffinity string Default task affinity of all activities in this application.
--- @field lastUpdateTime number The time at which the app was last updated.
--- @field processName string The name of the process this application should run in.
--- @field label string
--- @field uid number The kernel user-ID that has been assigned to this application; currently this is not a unique ID (multiple applications can have the same uid).
--- @field pid number PID of the process.
--- @field backupAgentName string Class implementing the Application's backup functionality. From the "backupAgent" attribute. This is an optional attribute and will be null if the application does not specify it in its manifest.
--- @field manageSpaceActivityName string Class implementing the Application's manage space functionality. From the "manageSpaceActivity" attribute. This is an optional attribute and will be null if applications don't specify it in their manifest.
--- @field permission string Optional name of a permission required to be able to access this application's components. From the "permission" attribute.

--- Get a table with information about the selected process if possible.
---
--- The set of fields can be different. Print the resulting table to see the available fields.
---
--- Possible fields: firstInstallTime, lastUpdateTime, packageName, sharedUserId, sharedUserLabel, versionCode, versionName, activities (name, label), installer, enabledSetting, backupAgentName, className, dataDir, descriptionRes, flags, icon, labelRes, logo, manageSpaceActivityName, name, nativeLibraryDir, permission, processName, publicSourceDir, sourceDir, targetSdkVersion, taskAffinity, theme, uid, label, cmdLine, pid, x64, RSS.
---
--- cmdLine - The contents of /proc/pid/cmdline. pid - PID of the process. x64 - True if the 64-bit process. RSS - The amount of RSS memory for the process, in KB.
---
--- Read about [PackageInfo](https://developer.android.com/reference/android/content/pm/PackageInfo) and [ApplicationInfo](https://developer.android.com/reference/android/content/pm/ApplicationInfo) in Android for means each field.
--- @return infoTarget|nil --A table with information about the selected process or nil.
---```
----- check for game version
---local v = gg.getTargetInfo()
---if v.versionCode ~= 291 then
--- print('This script only works with game version 291. You have game version ', v.versionCode, ' Please install version 291 and try again.')
--- os.exit()
---end
---```
function gg.getTargetInfo() end

--- Get the package name of the selected process, if possible.
--- @return string|nil --The package name of the selected process as string or nil.
--- E.g.: 'com.blayzegames.iosfps'
function gg.getTargetPackage() end

--- Gets the values for the list of items.
--- @param values {address:number,flags:number}[] The table as a list of tables with address and flags fields (one of the constants gg.TYPE_*).
--- @return {address:number,value:number,flags:number}[]|string --A new table with results or string with error. Each element is a table with three keys: address (long), value (number), flags (one of the constants gg.TYPE_*).
---```
---gg.searchNumber('10', gg.TYPE_DWORD)
---local r = gg.getResults(5) -- load items
---r = gg.getValues(r) -- refresh items values
---print('First 5 results: ', r)
---print('First result: ', r[1])
---print('First result address: ', r[1].address)
---print('First result value: ', r[1].value)
---print('First result type: ', r[1].flags)
---local t = {}
---t[1] = {}
---t[1].address = 0x18004030 -- some desired address
---t[1].flags = gg.TYPE_DWORD
---t[2] = {}
---t[2].address = 0x18004040 -- another desired address
---t[2].flags = gg.TYPE_BYTE
---t = gg.getValues(t)
---print(t)
---```
function gg.getValues(values) end

--- Get the memory regions for the passed value table.
--- @param values table<number> The table can be either an address list or a list of tables with the address field.
--- @return table<string>|string --A table where each key, from the original table, will be associated with a short region code (Ch, for example). Or string with error.
---```
---print('1: ', gg.getValuesRange({0x9000, 0x9010, 0x9020, 0x9030}))
----- table as a list of addresses
---gg.searchNumber('10', gg.TYPE_DWORD)
---local r = gg.getResults(5)
---print('2: ', r, gg.getValuesRange(r))
----- table as a list of tables with the address field
---```
function gg.getValuesRange(values) end

--- Go to the address in the memory editor.
--- @param address number Desired address.
function gg.gotoAddress(address) end

--- Hides the UI button.
function gg.hideUiButton() end

--- Gets the click status of the ui button.
---
--- The call resets the click status.
--- @return boolean|nil --true if the button has been clicked since the last check. false - if there was no click. nil - if the button is hidden.
---```
---gg.showUiButton()
---while true do
--- if gg.isClickedUiButton() then
--- -- do some action for click, menu for example
--- local ret = gg.choice({'Item 1', 'Item 2', 'Item 3'}) or os.exit()
--- gg.alert('You selected:', ret)
--- end
--- gg.sleep(100)
---end
---```
function gg.isClickedUiButton() end

--- Check whether the specified application is installed on the system by the package name.
--- @param pkgName string String with package name.
--- @return boolean --true if package installed or false otherwise.
---```
---print('Game installed:', gg.isPackageInstalled('com.blayzegames.iosfps'))
---```
function gg.isPackageInstalled(pkgName) end

--- Get pause state of the selected process.
--- @return boolean --true if the process paused or false otherwise.
function gg.isProcessPaused() end

--- Check if the GameGuardian UI is open.
--- @return boolean --true if the GameGuardian UI open or false otherwise.
function gg.isVisible() end

--- Load the saved list from the file.
--- @param file string File for load.
--- @param flags? number Set of flags gg.LOAD_*.
--- @return true|string --true or string with error.
---```
---print('loadList:', gg.loadList('/sdcard/Notes/gg.victim.txt'))
---print('loadList:', gg.loadList('/sdcard/Notes/gg.victim.txt', 0))
---print('loadList:', gg.loadList('/sdcard/Notes/gg.victim.txt', gg.LOAD_APPEND))
---print('loadList:', gg.loadList('/sdcard/Notes/gg.victim.txt', gg.LOAD_VALUES_FREEZE))
---print('loadList:', gg.loadList('/sdcard/Notes/gg.victim.txt', gg.LOAD_APPEND | gg.LOAD_VALUES))
---```
function gg.loadList(file, flags) end

--- Loads the search results from the table.
---
--- Existing search results will be cleared.
--- @param results {address:number,flags:number}[] The table as a list of tables with address and flags fields (one of the constants gg.TYPE_*).
--- @return true|string --true or string with error.
---```
---gg.searchNumber('10', gg.TYPE_DWORD)
---local r = gg.getResults(5)
---print('load first 5 results: ', gg.loadResults(r))
---local t = {}
---t[1] = {}
---t[1].address = 0x18004030 -- some desired address
---t[1].flags = gg.TYPE_DWORD
---t[2] = {}
---t[2].address = 0x18004040 -- another desired address
---t[2].flags = gg.TYPE_BYTE
---print('load from table: ', gg.loadResults(t))
---```
function gg.loadResults(results) end

--- Performs a GET or POST request over HTTP or HTTPS.
--- @param url string A string with a URL.
--- @param headers? table A table with request headers. The key is the name. The value is a table or a string. If this is a table, then the keys are ignored, and the values ​​are used.
--- @param data? string A string with data for the POST request. If you specify nil, then there will be a GET request.
--- @return table|string --The table on success, the string on error.
---
--- The function executes the query and returns a table with the result on success. On error, the string with the error text will be returned. In logcat there will be more information.
---
--- The result table can contain the following fields:
--- - url - request url, for example ['http://httpbin.org/headers'](https://httpbin.org/headers)
--- - requestMethod - HTTP method, for example 'GET'
--- - code - HTTP response code, for example 200
--- - message - an HTTP message, for example 'Method Not Allowed'
--- - headers - a table with all the response headers. Each value is also a table, with numeric keys. Usually there is only one value, but if the header has met several times, such as 'Set-Cookie', then there may be several values.
--- - contentEncoding, contentLength, contentType, date, expiration, lastModified, usingProxy, cipherSuite - fields based on the methods of the class HttpURLConnection. If the method returns null, then this field will not be in the table.
--- - error - true or false. true if the server returned an invalid code.
--- - content - string of data from the server. Can be empty.
--- If the data string is not nil, the POST request will be executed, otherwise the GET.
---
--- By default, POST requests are set to "Content-Type" = "application/x-www-form-urlencoded". You can specify this header yourself to specify the desired type. Similarly, the header "Content-Length" is set. Other headers can be set by the system and depend on the implementation of the Android.
---
--- HTTPS requests do not perform certificate validation.
---```
---print('GET 1: ', gg.makeRequest('http://httpbin.org/headers').content) -- simple GET request
---print('GET 2: ', gg.makeRequest('http://httpbin.org/headers', {['User-Agent']='My BOT'}).content) -- GET request with headers
---print('GET 3: ', gg.makeRequest('http://httpbin.org/headers', {['User-Agent']={'My BOT', 'Tester'}}).content) -- GET request with headers
---print('GET 4: ', gg.makeRequest('https://httpbin.org/get?param1=value2&param3=value4', {['User-Agent']='My BOT'}).content) -- HTTPS GET request with headers
---print('POST 1: ', gg.makeRequest('http://httpbin.org/post', nil, 'post1=val2&post3=val4').content) -- simple POST request
---print('POST 2: ', gg.makeRequest('http://httpbin.org/post', {['User-Agent']='My BOT'}, 'post1=val2&post3=val4').content) -- POST request with headers
---print('POST 3: ', gg.makeRequest('http://httpbin.org/post', {['User-Agent']={'My BOT', 'Tester'}}, 'post1=val2&post3=val4').content) -- POST request with headers
---print('POST 4: ', gg.makeRequest('https://httpbin.org/post?param1=value2&param3=value4', {['User-Agent']='My BOT'}, 'post1=val2&post3=val4').content) -- HTTPS POST request with headers
---print('FULL: ', gg.makeRequest('https://httpbin.org/headers')) -- print full info about the request
---```
function gg.makeRequest(url, headers, data) end

--- Displays the multiple choice dialog.
---
--- Items must be numberic-array if you want show items in specified order.
--- @param items table<string> Table with items for choice.
--- @param selection? table The table specifies the selection status for each item from items by same key. If key not found then the element will be unchecked.
--- @param message? string Specifies the optional title of the dialog box.
--- @return nil|{[number]:true} --nil if the dialog has been canceled, or a table with the selected keys and values true (analogue of the selected param).
---```
---print('1: ', gg.multiChoice({'A', 'B', 'C', 'D'}))
----- show list of 4 items without checked items
---print('2: ', gg.multiChoice({'A', 'B', 'C', 'D'}, {[2]=true, [4]=true}))
----- show list of 4 items with checked 2 and 4 items
---print('3: ', gg.multiChoice({'A', 'B', 'C', 'D'}, {[3]=true}, 'Select letter:'))
----- show list of 4 items with checked 3 item and message
---print('4: ', gg.multiChoice({'A', 'B', 'C', 'D'}, {}, 'Select letter:'))
----- show list of 4 items without checked items and message
----- Performing multiple actions
---local t = gg.multiChoice({'A', 'B', 'C', 'D'})
---if t == nil then
--- gg.alert('Canceled')
---else
--- if t[1] then
--- gg.alert('do A')
--- end
--- if t[2] then
--- gg.alert('do B')
--- end
--- if t[3] then
--- gg.alert('do C')
--- end
--- if t[4] then
--- gg.alert('do D')
--- end
---end
---```
function gg.multiChoice(items, selection, message) end

--- Replaces the localized decimal separator and thousands separator with separators used in Lua (such as in English).
--- @param num string Number or string to replace.
--- @return stringlib --Fixed number as string.
---```
---print(gg.numberFromLocale('1.234,567')) -- print '1234.567' for German locale
---```
function gg.numberFromLocale(num) end

--- Replaces the decimal separator and the thousands separator with a localized version.
--- @param num string Number or string to replace.
--- @return string --Fixed number as string.
---```
---print(gg.numberToLocale('1,234.567')) -- print '1234,567' for German locale
---```
function gg.numberToLocale(num) end

--- Force kill the selected process.
---
--- If you call this call too often, your script may be interrupted.
--- @return boolean --true on success or false otherwise.
function gg.processKill() end

--- Pauses the selected process.
--- @return boolean --true on success or false otherwise.
function gg.processPause() end

--- Resumes the selected process if it paused.
--- @return boolean --true on success or false otherwise.
function gg.processResume() end

--- Toggle the pause state of the selected process.
---
--- If process paused then it will be resumed else it will be paused.
--- @return boolean --true on success or false otherwise.
function gg.processToggle() end

--- Displays the dialog for data entry.
---
--- For respect order of fields prompts must be numeric-array.
--- @param prompts table<string> The table specifies the keys and description for each input field.
--- @param defaults? table The table specifies the default values for each key from prompts.
--- @param types? table The table specifies the types for each key from prompts. Valid types: 'number', 'text', 'path', 'file', 'new_file', 'setting', 'speed', 'checkbox'. From the type depends output of additional elements near the input field (for example, buttons for selecting a path or file, internal or external keyboard and so on).
--- @return nil|nil|{[number]:any} --nil if the dialog has been canceled, or the table with keys from prompts and values from input fields.
--- Also for the types 'number', 'setting', 'speed', the separators are converted to a localized version and vice versa during output.
---
--- For example, the string '6,789.12345' will be in the form displayed as '6789,12345' for the German locale (',' - decimal separator, '.' - thousands separator). If the user enters '4.567,89', then the script will receive '4567.89'.
---
--- To display the seek bar, you must specify the type 'number', the minimum and maximum value at the end of the prompt text, separated by a semicolon and surrounded by square brackets. The minimum value must be less than the maximum. If the default value is not in the range, the closest match will be used. Only integers can be used. The step size is always 1.
---
--- See examples.
---
--- If the config for seek bar is not recognized, the usual input of a number as text will be used.
---```
--- print('prompt 1: ', gg.prompt(
---  {'ask any', 'ask num', 'ask text', 'ask path', 'ask file', 'ask set', 'ask speed', 'checked', 'not checked'},
---  {[1]='any val', [7]=123, [6]=-0.34, [8]=true},
---  {[2]='number', [3]='text', [4]='path', [5]='file', [6]='setting', [7]='speed', [8]='checkbox', [9]='checkbox'}
--- ))
--- print('prompt 2: ', gg.prompt(
---  {'ask any', 'ask num', 'ask text', 'ask path', 'ask file', 'ask set', 'ask speed', 'check'},
---  {[1]='any val', [7]=123, [6]=-0.34}
--- ))
--- print('prompt 3: ', gg.prompt(
---  {'ask any', 'ask num', 'ask text', 'ask path', 'ask file', 'ask set', 'ask speed', 'check'}
--- ))
--- print('prompt 4: ', gg.prompt(
---  {'seek bar 1 [32; 64]', 'seek bar 2 [-80; -60]'}, nil,
---  {'number', 'number'}
--- ))
--- print('prompt 5: ', gg.prompt(
---  {'seek bar 1 [32; 64]', 'seek bar 2 [-80; -60]'},
---  {42, -76},
---  {'number', 'number'}
--- ))
--- -- Performing multiple actions
--- local t = gg.prompt({'A', 'B', 'C', 'D'}, nil, {'checkbox', 'checkbox', 'checkbox', 'checkbox'})
--- if t == nil then
---  gg.alert('Canceled')
--- else
---  if t[1] then
---  gg.alert('do A')
---  end
---  if t[2] then
---  gg.alert('do B')
---  end
---  if t[3] then
---  gg.alert('do C')
---  end
---  if t[4] then
---  gg.alert('do D')
---  end
--- end
---```
function gg.prompt(prompts, defaults, types) end

--- --- Perform an address refine search with the specified parameters.
---
--- If no results in results list then do nothing.
--- @param text string Search string. The format same as the format for the search from the GameGuardian UI. But it must be in English locale.
--- @param mask? number Mask. Default is -1 (0xFFFFFFFFFFFFFFFF).
--- @param type? number Type. One of the constants gg.TYPE_*.
--- @param sign? number Sign. gg.SIGN_EQUAL or gg.SIGN_NOT_EQUAL.
--- @param memoryFrom? number Start memory address for the search.
--- @param memoryTo? number End memory address for the search.
--- @param limit? number Stopping the search after finding the specified number of results. 0 means to search all results.
--- @return true|string --true or string with error.
---```
---gg.refineAddress('A20', 0xFFFFFFFF)
---gg.refineAddress('B20', 0xFF0, gg.TYPE_DWORD, gg.SIGN_NOT_EQUAL)
---gg.refineAddress('0B?0', 0xFFF, gg.TYPE_FLOAT)
---gg.refineAddress('??F??', 0xBA0, gg.TYPE_BYTE, gg.SIGN_NOT_EQUAL, 0x9000, 0xA09000)
----- do nothing
---gg.clearResults()
---gg.refineAddress('A20', 0xFFFFFFFF)
----- refine search
---gg.refineAddress('A20', 0xFFFFFFFF)
---```
function gg.refineAddress(text, mask, type, sign, memoryFrom, memoryTo, limit) end

--- Perform a refine search for a number, with the specified parameters.
---
--- If no results in results list then do nothing.
--- @param text string String for search. The format same as the format for the search from the GameGuardian UI. But it must be in English locale.
--- @param type? number Type. One of the constants gg.TYPE_*.
--- @param encrypted? boolean Flag for run search encrypted values.
--- @param sign? number Sign. One of the constants gg.SIGN_*.
--- @param memoryFrom? number Start memory address for the search.
--- @param memoryTo? number End memory address for the search.
--- @param limit? number Stopping the search after finding the specified number of results. 0 means to search all results.
--- @return true|string --true or string with error.
---```
----- number refine
---gg.refineNumber('10', gg.TYPE_DWORD)
----- encrypted refine
---gg.refineNumber('-10', gg.TYPE_DWORD, true)
----- range refine
---gg.refineNumber('10~20', gg.TYPE_DWORD, false, gg.SIGN_NOT_EQUAL)
----- group refine with ranges
---gg.refineNumber('6~7;7;1~2;0;0;0;0;6~8::29', gg.TYPE_DWORD)
----- refine for HEX '5C E3 0B 4B 90 9B 11 7B'
---gg.refineNumber('5Ch;E3h;0Bh;4Bh;90h;9Bh;11h;7Bh::8', gg.TYPE_BYTE)
----- refine for HEX '5C ?? 0B 4B ?? 9B 11 7B' where '??' can be any byte
---gg.refineNumber('5Ch;0~~0;0Bh;4Bh;0~~0;9Bh;11h;7Bh::8', gg.TYPE_BYTE)
----- do nothing
---gg.clearResults()
---gg.refineNumber('10', gg.TYPE_DWORD)
----- refine search
---gg.refineNumber('10', gg.TYPE_DWORD)
----- see searchNumber for other search examples
---```
function gg.refineNumber(text, type, encrypted, sign, memoryFrom, memoryTo, limit) end

--- Remove items from the saved list.
--- @param items {address:number}[] The table as a list of tables with address. Or the table as a list of adresses.
--- @return true|string --True or string with error.
---```
-- retrieving a table from another call
---t = gg.getListItems()
---print('removeListItems: ', gg.removeListItems(t))
----- creating a table as a list of items
---t = {}
---t[1] = {}
---t[1].address = 0x18004030 -- some desired address
---t[2] = {}
---t[2].address = 0x18004040 -- another desired address
---print('removeListItems: ', gg.removeListItems(t))
----- creating a table as a list of adresses
---t = {}
---t[1] = 0x18004030 -- some desired address
---t[2] = 0x18004040 -- another desired address
---print('removeListItems: ', gg.removeListItems(t))
---```
function gg.removeListItems(items) end

--- Remove results from the list of results found.
--- @param results table The table as a list of tables with address and flags fields (one of the constants gg.TYPE_*).
--- @return true|string --True or string with error.
---```
---gg.searchNumber('10', gg.TYPE_DWORD)
---local r = gg.getResults(5)
---print('Remove first 5 results: ', gg.removeResults(r))
---```
function gg.removeResults(results) end

--- Checks the version of GameGuardian.
---
--- If the version or build number is lower than required, the script will be ended with the message to update GameGuardian.
--- @param version? string Minimal version of GameGuardian to run the script.
--- @param build? number Minimal build number to run the script. Optional.
---```
---gg.require('8.31.1')
---gg.require('8.31.1', 5645)
---gg.require(nil, 5645)
---```
function gg.require(version, build) end

---  Save the saved list to the file.
--- @param file string File to save.
--- @param flags? number Set of flags gg.SAVE_*.
--- @return true|string --True or string with error.
---```
---print('saveList:', gg.saveList('/sdcard/Notes/gg.victim.txt'))
---print('saveList:', gg.saveList('/sdcard/Notes/gg.victim.txt', 0))
---print('saveList:', gg.saveList('/sdcard/Notes/gg.victim.txt', gg.SAVE_AS_TEXT))
---```
function gg.saveList(file, flags) end

--- Saves the variable to a file.
---
--- The result of the execution will be a .lua file, which can then be loaded via
---```
---local var = assert(loadfile(filename))()
---```
--- @param variable any Variable to save.
--- @param filename string Full path to save the file.
--- @return true|string --True or string with error.
---```
---local t = {}
---t['test1'] = {1, 2, 3, 4}
---t['test2'] = 42
---t['test3'] = 86.3
---t['test4'] = 'weapon'
---t[4] = t['test1']
---gg.saveVariable(t, '/sdcard/test.lua') -- saved
---local var = assert(loadfile('/sdcard/test.lua'))() -- loaded
----- Saving input between script restarts
---local configFile = gg.getFile()..'.cfg'
---local data = loadfile(configFile)
---if data ~= nil then data = data() end
---local input = gg.prompt({'Please input something'}, data)
---if input == nil then os.exit() end
---gg.saveVariable(input, configFile)
---```
function gg.saveVariable(variable, filename) end

--- Perform an address search with the specified parameters.
---
--- If no results in results list then perform new search, else refine search. So if you need to perform a search, without refine, you must first call clearResults.
--- @param text string Search string. The format same as the format for the search from the GameGuardian UI. But it must be in English locale.
--- @param mask? number Mask. Default is -1 (0xFFFFFFFFFFFFFFFF).
--- @param type? number Type. One of the constants gg.TYPE_*.
--- @param sign? number Sign. gg.SIGN_EQUAL or gg.SIGN_NOT_EQUAL.
--- @param memoryFrom? number Start memory address for the search.
--- @param memoryTo? number End memory address for the search.
--- @param limit? number Stopping the search after finding the specified number of results. 0 means to search all results.
--- @return true|string --True or string with error.
---```
---gg.searchAddress('A20', 0xFFFFFFFF)
---gg.searchAddress('B20', 0xFF0, gg.TYPE_DWORD, gg.SIGN_NOT_EQUAL)
---gg.searchAddress('0B?0', 0xFFF, gg.TYPE_FLOAT)
---gg.searchAddress('??F??', 0xBA0, gg.TYPE_BYTE, gg.SIGN_NOT_EQUAL, 0x9000, 0xA09000)
----- start new search
---gg.clearResults()
---gg.searchAddress('A20', 0xFFFFFFFF)
----- refine search
---gg.searchAddress('A20', 0xFFFFFFFF)
---```
function gg.searchAddress(text, mask, type, sign, memoryFrom, memoryTo, limit) end

--- Refine fuzzy search, with the specified parameters.
--- @param difference? string Difference between old and new values. By default is '0'. Must be in English locale.
--- @param sign? number Sign. One of the constants gg.SIGN_FUZZY_*.
--- @param type? number Type. One of the constants gg.TYPE_*.
--- @param memoryFrom? number Start memory address for the search.
--- @param memoryTo? number End memory address for the search.
--- @param limit? number Stopping the search after finding the specified number of results. 0 means to search all results.
--- @return true|string --True or string with error.
---```
---gg.searchFuzzy()
----- value not changed
---gg.searchFuzzy('0', gg.SIGN_FUZZY_NOT_EQUAL)
----- value changed
---gg.searchFuzzy('0', gg.SIGN_FUZZY_GREATER)
----- value increased
---gg.searchFuzzy('0', gg.SIGN_FUZZY_LESS)
----- value decreased
---gg.searchFuzzy('15')
----- value increased by 15
---gg.searchFuzzy('-115')
----- value decreased by 115
---```
function gg.searchFuzzy(difference, sign, type, memoryFrom, memoryTo, limit) end

--- Perform a search for a number, with the specified parameters.
---
--- If no results in results list then perform new search, else refine search. So if you need to perform a search, without refine, you must first call clearResults.
--- @param text string String for search. The format same as the format for the search from the GameGuardian UI. But it must be in English locale.
--- @param type? number Type. One of the constants gg.TYPE_*.
--- @param encrypted? boolean Flag for run search encrypted values.
--- @param sign? number Sign. One of the constants gg.SIGN_*.
--- @param memoryFrom? number Start memory address for the search.
--- @param memoryTo? number End memory address for the search.
--- @param limit? number Stopping the search after finding the specified number of results. 0 means to search all results.
--- @return true|string --true or string with error.
---```
-- number search
---gg.searchNumber('10', gg.TYPE_DWORD)
----- encrypted search
---gg.searchNumber('-10', gg.TYPE_DWORD, true)
----- range search
---gg.searchNumber('10~20', gg.TYPE_DWORD, false, gg.SIGN_NOT_EQUAL)
----- group search with ranges
---gg.searchNumber('6~7;7;1~2;0;0;0;0;6~8::29', gg.TYPE_DWORD)
----- search for HEX '5C E3 0B 4B 90 9B 11 7B'
---gg.searchNumber('5Ch;E3h;0Bh;4Bh;90h;9Bh;11h;7Bh::8', gg.TYPE_BYTE)
----- search for HEX '5C E3 0B 4B 90 9B 11 7B'
---gg.searchNumber('h 5C E3 0B 4B 90 9B 11 7B')
----- search for HEX '5C ?? 0B 4B ?? 9B 11 7B' where '??' can be any byte
---gg.searchNumber('5Ch;0~~0;0Bh;4Bh;0~~0;9Bh;11h;7Bh::8', gg.TYPE_BYTE)
----- search for text UTF-8 'şuşpançik' - type forced to gg.TYPE_BYTE
---gg.searchNumber(':şuşpançik')
----- search for text UTF-16LE 'şuşandra' - type forced to gg.TYPE_WORD
---gg.searchNumber(';şuşandra')
----- search for HEX '5C E3 0B' + UTF-8 'şuşpançik' + HEX '9B 11 7B' - type forced to gg.TYPE_BYTE
---gg.searchNumber('Q 5C E3 0B \'şuşpançik\' 9B 11 7B')
---gg.searchNumber("Q 5C E3 0B 'şuşpançik' 9B 11 7B") -- same as above
----- search for HEX '5C E3 0B' + UTF-16LE 'şuşandra' + HEX '9B 11 7B' - type forced to gg.TYPE_BYTE
---gg.searchNumber('Q 5C E3 0B "şuşandra" 9B 11 7B')
----- search for HEX '5C E3 0B' + UTF-8 'şuşpançik' + HEX '9B' + UTF-16LE 'şuşandra' + '11 7B' - type forced to gg.TYPE_BYTE
---gg.searchNumber('Q 5C E3 0B \'şuşpançik\' 9B "şuşandra" 11 7B')
---gg.searchNumber("Q 5C E3 0B 'şuşpançik' 9B \"şuşandra\" 11 7B") -- same as above
----- search for ARM opcode
---gg.searchNumber('~A MOV R1, R2', gg.TYPE_DWORD)
----- start new search
---gg.clearResults()
---gg.searchNumber('10', gg.TYPE_DWORD)
----- refine search if present some results in the result list
---gg.searchNumber('10', gg.TYPE_DWORD)
---```
function gg.searchNumber(text, type, encrypted, sign, memoryFrom, memoryTo, limit) end

--- Searches for values that may be pointers to elements of the current search result.
--- @param maxOffset number Maximum offset for pointers. Valid values: 0 - 65535.
--- @param memoryFrom? number Start memory address for the search.
--- @param memoryTo? number End memory address for the search.
--- @param limit? number Stopping the search after finding the specified number of results. 0 means to search all results.
--- @return true|string --true or string with error.
---```
---gg.searchNumber('10', gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 5) -- search some values
---gg.searchPointer(512) -- search for possible pointers to values finded before
---gg.searchNumber('10', gg.TYPE_DWORD) -- search some values
---gg.loadResults(gg.getResults(5))
---gg.searchPointer(512) -- search for possible pointers to values loaded before
---local t = {}
---t[1] = {}
---t[1].address = 0x18004030 -- some desired address
---t[1].flags = gg.TYPE_DWORD
---t[2] = {}
---t[2].address = 0x18004040 -- another desired address
---t[2].flags = gg.TYPE_BYTE
---gg.loadResults(t)
---gg.searchPointer(512) -- search for possible pointers to values loaded before
---```
function gg.searchPointer(maxOffset, memoryFrom, memoryTo, limit) end

--- Set memory regions to desired bit mask of flags gg.REGION_*.
--- @param ranges number Bit mask of flags gg.REGION_*.
---```
---gg.setRanges(gg.REGION_C_HEAP)
---gg.setRanges(bit32.bor(gg.REGION_C_HEAP, gg.REGION_C_ALLOC, gg.REGION_ANONYMOUS))
---gg.setRanges(gg.REGION_C_HEAP | gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS)
---```
function gg.setRanges(ranges) end

--- Set the speed of the speedhack.
---
--- If speedhack was not loaded, then it will be loaded. The call is blocking. The script will wait for speedhack full load.
--- @param speed number Desired speed. Must be in range [1.0E-9; 1.0E9].
--- @return true|string --true or string with error.
function gg.setSpeed(speed) end

--- Set the values for the list of items.
--- @param values {address: number, value: string|number, flags:number}[] The table as a list of tables with three keys: address (long), value (string with a value), flags (one of the constants TYPE_*). Values must be in English locale.
--- @return true|string --true or string with error.
---```
---gg.searchNumber('10', gg.TYPE_DWORD)
---local r = gg.getResults(5) -- load items
---r[1].value = '15'
---print('Edited: ', gg.setValues(r))
---local t = {}
---t[1] = {}
---t[1].address = 0x18004030 -- some desired address
---t[1].flags = gg.TYPE_DWORD
---t[1].value = 12345
---t[2] = {}
---t[2].address = 0x18004040 -- another desired address
---t[2].flags = gg.TYPE_BYTE
---t[2].value = '7Fh'
---print('Set', t, gg.setValues(t))
----- edit ARM opcode
---gg.searchNumber('~A MOV R1, R2', gg.TYPE_DWORD)
---local r = gg.getResults(5) -- load items
---r[1].value = '~A MOV R2, R3'
---print('Edited: ', gg.setValues(r))
---```
function gg.setValues(values) end

--- Open or close the GameGuardian UI.
---
--- If you call this call too often, your script may be interrupted.
--- @param visible boolean true for open GameGuardian UI or false for hide. *
---```
---function doAction()
---    -- do some action for click, menu for example
---    local ret = gg.choice({ 'Item 1', 'Item 2', 'Item 3' }) or os.exit(gg.setVisible(true))
---    gg.alert('You selected: Item ' .. ret, 'OK')
---end
---
---gg.setVisible(false)
---while true do
---    if gg.isVisible() then
---        gg.setVisible(false)
---        doAction()
---    end
---    gg.sleep(100)
---end
---```
function gg.setVisible(visible) end

--- Shows the UI button.
---
--- The UI button has an icon with the letters "Sx" and is visible only when you open the GameGuardian interface. The button is floating, displayed on top of the main GameGuardian interface.
function gg.showUiButton() end

--- Do not restore the state of the GameGuardian, after the script is completed.
---
--- For example, by default, a set of memory regions restored after end script execution. This call allow prevent this.
---```
---gg.setRanges(bit32.bxor(gg.REGION_C_HEAP, gg.REGION_C_ALLOC, gg.REGION_ANONYMOUS))
----- do some things like search values
----- gg.skipRestoreState() -- if you uncomment this line -
----- memory ranges after end script stay same as we set in first line.
----- If not - it will be restored to state which be before script run.
---```
function gg.skipRestoreState() end

--- Causes the currently executing script to sleep (temporarily cease execution) for the specified number of milliseconds, subject to the precision and accuracy of system timers and schedulers.
--- @param milliseconds number The length of time to sleep in milliseconds.
---```
----- 200 ms
---gg.sleep(200)
----- 300 ms
---local v = 300
---gg.sleep(v)
---```
function gg.sleep(milliseconds) end

--- Start a fuzzy search, with the specified parameters.
--- @param type? number Type. One of the constants gg.TYPE_*.
--- @param memoryFrom? number Start memory address for the search.
--- @param memoryTo? number End memory address for the search.
--- @param limit? number Stopping the search after finding the specified number of results. 0 means to search all results.
--- @return true|string --true or string with error.
---```
---gg.startFuzzy()
---gg.startFuzzy(gg.TYPE_DWORD)
---gg.startFuzzy(gg.TYPE_FLOAT)
---gg.startFuzzy(gg.TYPE_BYTE, 0x9000, 0xA09000)
---```
function gg.startFuzzy(type, memoryFrom, memoryTo, limit) end

--- Performs a time jump.
--- @param time string String with time. The format is similar to the time format in the time jump dialog. But it must be in English locale.
--- @return true|string --true or string with error.
---```
--- print('jump 1:', gg.timeJump('42345678'))
--- -- jump for 1 year 125 days 2 hours 41 minutes 18 seconds
--- print('jump 2:', gg.timeJump('1:125:2:41:18'))
--- -- same as above
--- print('jump 3:', gg.timeJump('5:13'))
--- -- jump for 5 minutes 13 seconds
--- print('jump 4:', gg.timeJump('7:3:1'))
--- -- jump for 7 hours 3 minutes 1 seconds
--- print('jump 5:', gg.timeJump('3600'))
--- -- jump for 1 hour
--- print('jump 6:', gg.timeJump('2:15:54:32'))
--- -- jump for 2 days 15 hours 54 minutes 32 seconds
--- print('jump 7:', gg.timeJump('3600.15'))
--- -- jump for 1 hour 0.15 seconds
--- print('jump 8:', gg.timeJump('7:3:1.519'))
--- -- jump for 7 hours 3 minutes 1.519 seconds
---```
function gg.timeJump(time) end

--- Show the toast.
---
--- If the second parameter is true, show the toast for a short period of time.
---
--- A toast is a view containing a quick little message for the user.
---
--- When the view is shown to the user, appears as a floating view over the application. It will never receive focus. The user will probably be in the middle of typing something else. The idea is to be as unobtrusive as possible, while still showing the user the information you want them to see. Two examples are the volume control, and the brief message saying that your settings have been saved.
---@param text string The text for toast.
---@param fast? boolean Flag for show the toast for a short period of time.
---```
---gg.toast('This is toast')
----- Show text notification for a long period of time
---gg.toast('This is toast', true)
----- Show text notification for a short period of time
---```
function gg.toast(text, fast) end

--- Work with Unrandomizer.
---
--- If Unrandomizer was not loaded, then it will be loaded. The call is blocking. The script will wait for Unrandomizer full load. You can set any parameter in nil so that it is not used.
---@param qword? number Qword parameter. Set to nil to disable.
---@param qincr? number Qword increment. Set to nil to disable.
---@param double_? number Double parameter. Set to nil to disable.
---@param dincr? number Double increment. Set to nil to disable.
--- @return true|string --true or string with error.
---```
---print('unrandomizer:', gg.unrandomizer(0)) -- set only qword = 0
---print('unrandomizer:', gg.unrandomizer(0, 1)) -- set only qword = 0 with increment = 1
---print('unrandomizer:', gg.unrandomizer(nil, nil, 0.3)) -- set only double without increment
---print('unrandomizer:', gg.unrandomizer(nil, nil, 0.3, 0.01)) -- set only double with increment
---print('unrandomizer:', gg.unrandomizer(2, 3, 0.45, 0.67)) -- set both
---print('unrandomizer:', gg.unrandomizer()) -- off
---```
function gg.unrandomizer(qword, qincr, double_, dincr) end
