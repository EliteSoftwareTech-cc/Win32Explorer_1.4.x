$dirs = Get-ChildItem -Directory -Recurse -Exclude ".git", ".github", ".appveyor", "vcpkg_installed", "External_Dependencies"

function Get-FileDescription($fileName) {
    if ($fileName -match "Dialog\.cpp$|Dialog\.h$") { return "UI dialog implementation/definition for $($fileName.Replace('Dialog.cpp','').Replace('Dialog.h',''))" }
    if ($fileName -match "Model\.cpp$|Model\.h$") { return "Data model for $($fileName.Replace('Model.cpp','').Replace('Model.h',''))" }
    if ($fileName -match "View\.cpp$|View\.h$") { return "UI view implementation/definition for $($fileName.Replace('View.cpp','').Replace('View.h',''))" }
    if ($fileName -match "Storage\.cpp$|Storage\.h$") { return "Settings storage handler for $($fileName.Replace('Storage.cpp','').Replace('Storage.h',''))" }
    if ($fileName -match "Menu\.cpp$|Menu\.h$") { return "Context or drop-down menu for $($fileName.Replace('Menu.cpp','').Replace('Menu.h',''))" }
    if ($fileName -match "Page\.cpp$|Page\.h$") { return "Property page UI for $($fileName.Replace('Page.cpp','').Replace('Page.h',''))" }
    if ($fileName -match "Toolbar\.cpp$|Toolbar\.h$") { return "Toolbar UI component for $($fileName.Replace('Toolbar.cpp','').Replace('Toolbar.h',''))" }
    if ($fileName -match "Config\.h$|Config\.cpp$") { return "Application configuration structures and defaults" }
    if ($fileName -match "App\.cpp$|App\.h$") { return "Core application lifecycle and state management" }
    if ($fileName -match "ShellBrowserImpl") { return "Main shell browsing window and item view logic" }
    if ($fileName -match "MainWnd") { return "Main application window routing and switching" }
    if ($fileName -match "stdafx") { return "Precompiled headers" }
    if ($fileName -match "Win32Explorer\.rc") { return "Primary resource script (UI layouts, strings, etc.)" }
    return "Implementation/definition for $($fileName.Replace('.cpp','').Replace('.h','').Replace('.hpp',''))"
}

foreach ($dir in $dirs) {
    if ($dir.FullName -match "vcpkg") { continue }
    
    $mdPath = Join-Path $dir.FullName "gemini.md"
    $files = Get-ChildItem -Path $dir.FullName -File | Where-Object { $_.Name -notmatch "gemini.md" }
    
    if ($files.Count -eq 0) { continue }
    
    $content = "# $($dir.Name)`n`n## Files:`n"
    foreach ($file in $files) {
        $desc = Get-FileDescription $file.Name
        $content += "- **$($file.Name)**: $desc.`n"
    }
    
    Set-Content -Path $mdPath -Value $content -Encoding UTF8
}
