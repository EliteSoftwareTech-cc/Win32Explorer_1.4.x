# App_Source Directory Log

## [2026-04-17]
- Initialized `App_Source/gemini.md` for directory-level logging.
- **Project Alignment Directive**:
    "add all native explorer views but with thumbnails to the view options list so user can choose between existing formats and any size thumbnail even details which normally cant display them because they would be blurry but I want thumbnails and icons only views for all sizes. also add every missing size and layout varient of all icon views for both icon mode and thumbnail mode. this includes things like small icons text below small icons text to right list medium icons below/right label large icons, tiles, all views below right label and icon / thumbnail views. I want a full comprehensive options and I also never want to remove features only add more. this is also a law update your gemini.md file with this info before starting I also want you to move registry saving logic to be moved to a registry location all users have access to. and make the apply button in settings apply all ui options everying instantly and it should apply to all open windows. allow setting show in groups option but also pick the group / add it if not in list just like the shell. I want to be able to tell it to always group by a specific filter. I also want to be able to sort and group at the same time like you can in windows explorer. please list all my feature requests to a planned features file and explicitly directly quote me do not summarize my prompts use a different icon for the titlebar of the about window as you are using the wrong png from within the ico file. its all glitchy and colors are weird only on the titlebar. try a different reference in the ico file."

## [2026-04-17]
- Modified App_Source/AboutDialog.cpp to fix titlebar icon color glitch.
- Replaced LR_VGACOLOR with LR_DEFAULTCOLOR and used SM_CXSMICON/SM_CYSMICON for ICON_SMALL.

## File Documentation
- **AboutDialog.cpp**: Manages the 'About' dialog. References 'IDI_MAIN' for icons. Relationship: Uses 'ResourceLoader' and 'VersionHelper'. Change: Updated to fix color glitch on titlebar icon.
- **AppStorage.h**: Interface for application storage (Load/Save configuration, windows, bookmarks, etc.). Relationship: Base for 'RegistryAppStorage' and 'XmlAppStorage'.
- **RegistryAppStorage.h/cpp**: Implementation of 'AppStorage' using the Windows Registry. Relationship: Interacts with specific registry storage classes like 'ConfigRegistryStorage'.
- **RegistryAppStorageFactory.h/cpp**: Factory for creating 'RegistryAppStorage' instances. Relationship: Decouples storage creation from usage. Uses 'HKEY_CURRENT_USER' (to be changed to 'HKEY_LOCAL_MACHINE').
- **ConfigRegistryStorage.h/cpp**: Specialized logic for loading/saving the 'Config' struct to/from the registry. Relationship: Used by 'RegistryAppStorage'.

- **WindowOptionsPage.h/cpp**: Detailed Documentation.
  - **Purpose**: This component manages the 'Window' options page within the application's main settings dialog.
  - **Relationship**: Inherits from 'OptionsPage'. Interacts with the global 'Config' object to load and persist UI settings. Uses 'ResizableDialogHelper' to handle dynamic layout adjustments during dialog resizing.
  - **How it works**: 
    - InitializeControls(): Reads current settings from the 'Config' struct and initializes checkboxes (e.g., Multiple Instances, Large Icons, Tab Bar position, Title Path, Gridlines, Full Row Select).
    - OnCommand(): Listens for control interactions and triggers the 'm_settingChangedCallback' to enable the 'Apply' button in the parent dialog.
    - SaveSettings(): Reads the state of all UI controls and updates the corresponding fields in the 'Config' object.
  - **Components Handled**: 
    - General Window behavior (Multiple instances, Large icons).
    - Tab Bar visibility and positioning (Bottom, Extended control).
    - Title Bar content (Full path, Username, Privilege level).
    - Main Pane/List View behavior (Gridlines, Checkbox selection, Full row select).
    - Navigation Pane/Tree View behavior (Sync, Auto-expand, Delay).
    - Display Window (File previews).

- **RegistryAppStorageFactory.cpp**: Change: Moved base registry key from 'HKEY_CURRENT_USER' to 'HKEY_LOCAL_MACHINE' to satisfy 'all users' access requirement.

- **StartupCommandLineProcessor.cpp**: Change: Updated 'OnClearRegistrySettings' to use 'HKEY_LOCAL_MACHINE' for consistency with storage move.

- **Config.h**: Added 'configChangedSignal' and 'NotifyChanged()' to support instant settings application across all windows.
- **OptionsDialog.cpp**: Updated 'OnApply()' to trigger 'm_config->NotifyChanged()'.
- **Win32Explorer.h/cpp**: Implemented 'OnConfigChanged()' and connected it to 'configChangedSignal' to refresh UI instantly.

- **ShellTreeView.h/cpp**: Detailed Documentation.
  - **Purpose**: Wraps and manages the shell-integrated treeview control used for filesystem navigation.
  - **Relationship**: Child of 'HolderWindow'. Integrates with 'ShellBrowser' and 'NavigationEvents' to synchronize selection with tab navigation.
  - **Native Styling**: Updated to use the 'Explorer' theme via 'SetWindowTheme' and removed 'TVS_HASLINES' for modern appearance. Horizontal scroll bar is disabled.
  - **How it works**: 
    - AddRootItems(): Populates the tree with Quick Access and Shell Namespace roots.
    - ExpandDirectory(): Enumerates subfolders on demand using 'IShellFolder2'.
    - OnSelectionChanged(): Triggers shell navigation when a node is selected.
    - QueueIconTask(): Asynchronously fetches shell icons using a thread pool to prevent UI hangs.

- **HolderWindow.h/cpp**: Detailed Documentation.
  - **Purpose**: Acts as a generic container window for child controls like the navigation treeview. Handles a caption area and a close button.
  - **Relationship**: Parent of 'ShellTreeView'. Uses 'ToolbarHelper' to create its close button.
  - **Native Styling**: Updated to use the 'ExplorerBar' theme class ('EBP_NORMALGROUPHEAD') for its caption area to match native Windows styling.
  - **How it works**: 
    - WndProc(): Handles mouse events for resizing and painting.
    - PerformPaint(): Draws the caption background using 'uxtheme' and renders the title text.
    - UpdateLayout(): Manages the position of the close button and the content child window during resizing.

- **TabBacking.h/cpp**: Detailed Documentation.
  - **Purpose**: Provides a background container for the tab bar, including a close button for the active tab.
  - **Relationship**: Child of 'TabContainer' or similar. Integrates with 'TabEvents' to update the close button state based on tab lock status.
  - **Native Styling**: Updated to use the native 'TAB' theme part 'TABP_PANE' for its background to ensure visual consistency with the system's tab controls.
  - **How it works**: 
    - UpdateToolbar(): Enables or disables the close button based on whether the selected tab is locked.
    - UpdateLayout(): Positions the close button toolbar at the right edge of the backing area.
    - WndProc(): Handles painting and command routing from the toolbar.

- **Icon.h**: Change: Added 'PressedCloseButton' to Icon enum.
- **NoTranslationResource.h**: Change: Added 'IDB_PRESSED_CLOSE_BUTTON' resource IDs for 16, 24, 32, 48 sizes.
- **Win32Explorer_NoTranslation.rc**: Change: Added PNG resource entries for 'IDB_PRESSED_CLOSE_BUTTON', using 'pressed-close-button.png' for the 24x24 size.
- **IconMappings.h**: Change: Mapped 'Icon::PressedCloseButton' to the new resource IDs.
- **ToolbarHelper.h/cpp**: Detailed Documentation.
  - **Purpose**: Provides helper functions for creating common UI toolbars, specifically for close buttons.
  - **Change**: Updated 'CreateCloseButtonToolbar' to return a vector of image lists. It now loads both normal and pressed/hover icons at 24x24 and sets 'TB_SETHOTIMAGELIST'/'TB_SETPRESSEDIMAGELIST' on the toolbar.
- **HolderWindow.h/cpp**: Change: Updated to store and manage multiple image lists for the close button.
- **TabBacking.h/cpp**: Change: Updated to store and manage multiple image lists for the close button.

- **Theme.h/cpp**: Change: Removed 'Dark' theme from BETTER_ENUM.
- **resource.h**: Change: Added 'IDC_OPTIONS_ENABLE_DARK_MODE' ID.
- **Win32Explorer.rc**: Change: Added 'Enable dark mode' AUTOCHECKBOX to 'IDD_OPTIONS_APPEARANCE' and moved the restart notice down to make room. It is intentionally disabled.
- **AppearanceOptionsPage.cpp**: Change: Grays out the 'Enable dark mode' checkbox in 'InitializeControls'.
