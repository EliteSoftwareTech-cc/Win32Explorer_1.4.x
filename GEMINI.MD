
# iMPORTANT FILES

- build_log.txt
- 




﻿# Requirements
 - always make  backup s prior to building. backup entire project. provide documentation for every single file in the project to custom gemini.md files in each directory and append informaiton going through as you discover files or create them. so every single component of the project is explained you must state its purpose relationship to other files, what it does how it works and anything we have changed and it must be appended like a log with all these separate gemini.md files. 
- You must log everything you do/change as well and it should always be appended not overwritten.
- Never remove features, only add more.
- Remove all remaining dark mode logic, but keep the checkbox in the settings app grayed out (out of spite).
- Use 24x24 PNG icons for tab and tree view close buttons: "close-button.png" for normal and "pressed-close-button.png" for pressed/hover states.
- must use standard visual styles and components and never draw custom colors use the icons in the color group as golden standard size 24x24 there are additional icons there like the tab close button and tree close button incorporate this logic with the two raised and pressed buttons to be applied to the tabs and newly styled controls using native shell for menubar toolbars and all other areas of the ui. windows should skin our app we dont skin it just make the system style it and only use native windows containers. 
- Visual Studio 2019/2022 (2022 recommended). Install the "Desktop development with C++" workload.
- Windows 10 SDK (most recent version recommended)
- (Optional) To build for ARM64, the following Visual Studio components should be installed:
    - MSVC v143 - VS 2022 C++ ARM64 build tools (Latest)
- (Optional) To build with Clang (using the Debug-Clang/Release-Clang solution configurations), the following Visual Studio components should be installed:
    - C++ Clang tools for Windows
- (Optional) To build the installer, WiX 3.11 and the relevant Visual Studio extension should be installed. Download links for both of those items can be found on the [WiX website](https://wixtoolset.org/docs/wix3/).

# Setup

[vcpkg](https://vcpkg.io/) is used to manage dependencies. Before you can build Win32Explorer, you'll first need to initialize vcpkg:

- Clone this repo with submodules enabled:
```
git clone --recurse-submodules https://github.com/EliteSoftwareTech/win32explorer.git
cd win32explorer
```
- Run the vcpkg bootstrapper:
    - cmd/PowerShell: `.\External_Dependencies\\vcpkg\bootstrap-vcpkg.bat`
    - git bash/posix shell: `./Win32Explorer/ThirdParty/vcpkg/bootstrap-vcpkg.sh`


The relevant packages should then be automatically installed during the first build.

# Compiling

Open `Project_Core\\Win32Explorer.sln`. From within Visual Studio, select `Debug` > `Start Without Debugging` to compile and run the program.

# Translations

Building the program in release mode will also build all of the translations. The resulting DLLs can then be used with Win32Explorer.

# Tests

The `TestWin32Explorer` project contains unit tests for the solution as a whole. The GoogleTest package is installed via vcpkg, so provided vcpkg has been initialized and you've been able to build the solution, you should just need to build the `TestWin32Explorer` project, then run the tests via the Visual Studio Test Explorer.

Note that the `TestHelper` project is older and is in the process of being removed. It doesn't currently compile and shouldn't be used.

﻿# Pull requests

- When submitting a pull request, only include a single high-level change. Don't include multiple unrelated changes in the same pull request.

- ClangFormat is used to format the code. A `.clang-format` file exists in the root of the repository and Visual Studio has [built-in support](https://learn.microsoft.com/en-us/visualstudio/ide/reference/options-text-editor-c-cpp-formatting?view=vs-2022) for ClangFormat, so the code can be formatted from within the IDE. That should be done before submitting a pull request.

- When adding a new .cpp/.h file, add the following license header at the top:

  ```cpp
  // Copyright (C) Win32Explorer Project
  // SPDX-License-Identifier: GPL-3.0-only
  // See LICENSE in the top level directory
  ```

- Don't use Hungarian notation when naming variables. For example, a variable should be named `title` instead of `szTitle`. This should be done even if the change would be inconsistent with the surrounding code.

- Outside of that, new code should follow the style of existing code.

- When fixing a bug or making a non-trivial functional change, `Documentation\User\History.txt` should be updated. That file has a maximum line length of 65 characters, so any new entries that are added should adhere to that.

- When making non-trivial functional changes, aim to update the documentation (stored under `Documentation\User\Sphinx`) as well.

- When feasible, unit tests should be included. Generally speaking, code that interacts with the filesystem or UI is going to be more difficult to test. However, code that's more isolated from the external environment can absolutely be tested. For example, the code that's involved in command line parsing is very testable. Therefore, deciding whether code can be tested requires judgement, but the long-term goal is to test as much of the code as possible. So, tests should be added if at all feasible.

- If tests are appropriate, add them to the `TestWin32Explorer` project. If testing code in a new file that has been added, a new test file should also be added. That test file should match the name of the original file, but should have `Test` appended to the name. For example, `HistoryModelTest.cpp` tests the code contained within `HistoryModel.cpp`. A test file should also be added if an existing file has been changed and that file doesn't have an associated test file yet.

# Documentation

- Documentation changes are greatly appreciated. Currently, the documentation (stored under `Documentation\User\Sphinx` and hosted on [Read the Docs](https://win32explorer.readthedocs.io/en/latest)) is severely out of date. Work needs to be done to update the documentation to reflect the current behavior of Win32Explorer.

- Targeted documentation updates would also be very helpful. For example, if you notice that a particular documentation page is inaccurate, submitting a pull request for just that page is still beneficial.

# Translations

- To update an existing translation, please contact support@elitesoftwaretech.cc.

- To request a new translation, please create a GitHub issue that states the language that you'd like to work on. That's necessary, since adding a new language requires a set of coordinated changes to be made on Crowdin as well in this repository.


# Project Placeholder and Stub Analysis

This document lists features, stubs, and implementations in the Win32Explorer project that are currently incomplete, placeholders, or "pretend" implementations.

## 1. COM Interface Stubs (Major)
A significant portion of the shell integration is currently implemented as stubs that return `E_NOTIMPL`. These satisfy interface requirements but do not provide functionality.

*   **`ShellView.cpp`**: Implements `IShellView` and `IOleWindow`. Almost all methods return `E_NOTIMPL`, including `CreateViewWindow`, `Refresh`, `TranslateAccelerator`, and `SaveViewState`.
*   **`FolderView.cpp`**: Implements `IFolderView`, `IFolderView2`, and `IShellFolderView`. Most methods return `E_NOTIMPL`.
*   **`WebBrowserApp.cpp`**: Implements `IWebBrowserApp`, `IWebBrowser`, and `IDispatch`. Nearly all methods are stubs returning `E_NOTIMPL`.
*   **`DocumentServiceProvider.cpp`**: Implements `IServiceProvider` but returns `E_NOTIMPL` for all service requests.

## 2. UI and Aesthetic Placeholders
*   **Taskbar Thumbnails**: `TaskbarThumbnails.cpp` contains a TODO for showing actual images/icons in the taskbar preview.
*   **Icons**: `DisplayColorsDialog.cpp` lacks a proper icon.
*   **Localization**: `ApplicationEditorDialog.cpp` and `StartupCommandLineProcessor.cpp` contain hardcoded strings marked for localization.
*   **Visual Themes**: `GroupManager.cpp` contains notes that group definitions are outdated and haven't been updated for Vista styles.

## 3. Functional Stubs and "Pretend" Implementations
*   **Blocking Operations**: `DestroyFilesDialog.cpp` and `MergeFilesDialog.cpp` perform operations on the main thread that are marked to be moved to background threads.
*   **Sorting Logic**: `GroupManager.cpp` has a placeholder for sorting by percentage free.
*   **File Tracking**: `ShellBrowserImpl.cpp` uses a "pretend" tracking mechanism based on filenames.
*   **Network Logic**: `GroupManager.cpp` has a stub for checking network adapters.

## 4. Architectural Debt
*   **Collection Iterators**: Throughout the codebase (`TabList.cpp`, `TabRestorer.cpp`, etc.), there are placeholders for more efficient iteration patterns. Current implementations should be replaced with robust Win32-compatible collection handling (e.g., standard pointer/index iteration or `std::vector` based loops).
*   **Resource Loading**: `Win32ResourceLoader.cpp` has a TODO indicating that `ResourceHelper::LoadString` logic is misplaced and needs refactoring into a more centralized Win32 resource management system.

## 5. Plugin System Gaps
*   **Error Logging**: `PluginManager.cpp` lacks proper error logging.
*   **Configurability**: `PluginMenuManager.cpp` has a TODO for making menu positions configurable.
*   **Validation**: `TabsApi.cpp` lacks validation for state values.

# Developer Summary

## [2026-04-10]
- **Analysis**: 
    - Conducted a thorough analysis of the Folder Tree View (`ShellTreeView`) and the Tab Bar system.
    - Performed a comprehensive codebase-wide analysis of all source files to identify and document project-wide coding standards and architectural patterns.
- **Documentation**: 
    - Created `Docs/ComponentAnalysis_TreeAndTabs.md`.
    - Created and expanded `Docs/Architecture_Analysis.md` with detailed findings on project standards (Tabs, Allman, WIL, Boost, modern C++20/23).
- **Tree View**: Removed the horizontal scroll bar from the folder tree and applied the "Explorer" theme for native visuals.
- **Native Styling (Vista Aero Support)**:
    -   Updated `HolderWindow` to use the `ExplorerBar` theme class (`EBP_NORMALGROUPHEAD`) for its caption area.
    -   Removed `TCS_EX_FLATBUTTONS` from `MainTabView` and updated `TabBacking` to use native `TAB` theme parts (`TABP_PANE`).
    -   Restored the gradient background in `DisplayWindow` using native `GradientFill`.
- **Display Colors Dialog**:
    -   Fully implemented `DisplayColorsDialog.cpp/h`, replacing the previously disabled stub.
    -   Resolved multiple build issues: fixed signature mismatches in `OnNotify`, `OnHScroll`, and `OnDrawItem`; fixed unreferenced parameter warnings; and corrected type conversions for `COLOR16`.
- **Build & Fixes**:
    -   Cleaned and synchronized `App_Source/Win32Explorer.vcxproj`, ensuring `DisplayColorsDialog.cpp/h` are correctly included and all new configurations are mapped.
    -   Resolved a linker error by correctly tracking the new source files in the project configuration.
    -   **Version Bump**: Incremented the application version to **26.0.4**.
    -   **FINAL BUILD**: Successfully rebuilt `Win32Explorer.exe` (Release|x64) using the official build script and relocated it to the project root.

## [2026-04-17]
- **Alignment Directive**: Initiated project alignment with GEMINI.MD.
- **New Laws Applied**: 
    - "You must log everything you do/change as well and it should always be appended not overwritten."
    - "Never remove features, only add more."
- **Backup**: Created full project backup `Win32Explorer_26.0.3.0_BACKUP.zip`.
- **Verbatim Feature Request**:
    "add all native explorer views but with thumbnails to the view options list so user can choose between existing formats and any size thumbnail even details which normally cant display them because they would be blurry but I want thumbnails and icons only views for all sizes. also add every missing size and layout varient of all icon views for both icon mode and thumbnail mode. this includes things like small icons text below small icons text to right list medium icons below/right label large icons, tiles, all views below right label and icon / thumbnail views. I want a full comprehensive options and I also never want to remove features only add more. this is also a law update your gemini.md file with this info before starting I also want you to move registry saving logic to be moved to a registry location all users have access to. and make the apply button in settings apply all ui options everying instantly and it should apply to all open windows. allow setting show in groups option but also pick the group / add it if not in list just like the shell. I want to be able to tell it to always group by a specific filter. I also want to be able to sort and group at the same time like you can in windows explorer. please list all my feature requests to a planned features file and explicitly directly quote me do not summarize my prompts use a different icon for the titlebar of the about window as you are using the wrong png from within the ico file. its all glitchy and colors are weird only on the titlebar. try a different reference in the ico file."

