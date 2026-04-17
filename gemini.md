# Win32Explorer Project Root

This is the root directory of the Win32Explorer project, a fork of Explorer++.

## Build Scripts

The user strictly requires using the provided PowerShell scripts to build and deploy the application.

- **`build_Win32Explorer.ps1`**: The primary build script for the project. 
  - **Purpose**: Automates the build process.
  - **Actions**:
    1. Locates the correct `MSBuild.exe` installation.
    2. Bootstraps `vcpkg` (the C++ package manager) if it hasn't been set up yet.
    3. Executes MSBuild on `Project_Core\Win32Explorer.sln` using the specified configuration and platform (default: Release/x64).
    4. Automatically copies the successfully compiled `Win32Explorer.exe` from the deep build output directory (`App_Source\x64\Release\Win32Explorer.exe`) into the project root directory.
  - **Usage**: `.\build_Win32Explorer.ps1 -Configuration Release -Platform x64`
- **`rebrand.ps1`**: A script used to rename the project and its internals (from Explorer++ to Win32Explorer).

## General Guidelines
- Always use `build_Win32Explorer.ps1` to build and deploy changes to ensure the correct executable is placed in the root folder and context is not lost.
- Documentation for each subfolder is located in its respective `gemini.md` file.