
param(
    [string]$Configuration = "Release",
    [string]$Platform = "x64"
)

$logFile = "build_log.txt"
function Log-Message($msg) {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $fullMsg = "[$timestamp] $msg"
    Write-Host $fullMsg
    $fullMsg | Out-File -FilePath $logFile -Append
}

"--- Build Log Start ---" | Out-File -FilePath $logFile

# 1. Locate MSBuild
Log-Message "Locating MSBuild..."
$msbuildPath = "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe"
if (-not (Test-Path $msbuildPath)) {
    Log-Message "ERROR: MSBuild.exe not found at $msbuildPath"
    exit 1
}
Log-Message "Found MSBuild: $msbuildPath"

# 2. Bootstrap vcpkg if needed
$vcpkgRoot = Join-Path (Get-Location) "Win32Explorer\ThirdParty\vcpkg"
$vcpkgExe = Join-Path $vcpkgRoot "vcpkg.exe"

if (-not (Test-Path $vcpkgExe)) {
    Log-Message "vcpkg.exe not found. Bootstrapping..."
    $bootstrapScript = Join-Path $vcpkgRoot "bootstrap-vcpkg.bat"
    if (Test-Path $bootstrapScript) {
        Start-Process -FilePath $bootstrapScript -Wait -NoNewWindow
    } else {
        Log-Message "ERROR: vcpkg directory or bootstrap script missing at $vcpkgRoot"
        exit 1
    }
}

# 3. Build Solution
$solutionFile = "Win32Explorer\Win32Explorer.sln"
Log-Message "Building $solutionFile ($Configuration|$Platform)..."

$msbuildArgs = @(
    $solutionFile,
    "/p:Configuration=$Configuration",
    "/p:Platform=$Platform",
    "/m", # Parallel build
    "/v:minimal"
)

& $msbuildPath $msbuildArgs | Tee-Object -FilePath $logFile -Append

if ($LASTEXITCODE -eq 0) {
    Log-Message "Build SUCCESSFUL."
} else {
    Log-Message "Build FAILED with exit code $LASTEXITCODE."
    exit $LASTEXITCODE
}
