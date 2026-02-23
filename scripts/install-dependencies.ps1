param(
    [string]$SdkPath = $env:GEODE_SDK,
    [switch]$InstallAndroid,
    [switch]$PersistEnv
)

$ErrorActionPreference = 'Stop'

$projectRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$modJsonPath = Join-Path $projectRoot 'mod.json'

if (-not (Test-Path $modJsonPath)) {
    throw "mod.json not found at $modJsonPath"
}

$modJson = Get-Content -Raw -Path $modJsonPath | ConvertFrom-Json
$geodeVersion = [string]$modJson.geode

if ([string]::IsNullOrWhiteSpace($geodeVersion)) {
    throw 'mod.json does not define a valid geode version.'
}

if ([string]::IsNullOrWhiteSpace($SdkPath)) {
    $defaultSdkPath = Join-Path $HOME 'Documents\Geode'
    if (Test-Path $defaultSdkPath) {
        $SdkPath = $defaultSdkPath
    }
}

if ([string]::IsNullOrWhiteSpace($SdkPath) -or -not (Test-Path $SdkPath)) {
    throw 'Geode SDK path is not set. Pass -SdkPath or set GEODE_SDK first.'
}

$geodeCmd = Get-Command geode -ErrorAction SilentlyContinue
if ($geodeCmd) {
    $geodeExe = $geodeCmd.Source
}
else {
    $scoopShim = Join-Path $HOME 'scoop\shims\geode.exe'
    if (Test-Path $scoopShim) {
        $geodeExe = $scoopShim
    }
    else {
        throw 'Geode CLI not found. Install geode CLI and ensure geode.exe is on PATH.'
    }
}

Write-Host "Using Geode CLI: $geodeExe"
Write-Host "Using Geode SDK: $SdkPath"
Write-Host "Installing binaries for Geode: $geodeVersion"

& $geodeExe sdk set-path $SdkPath
if ($LASTEXITCODE -ne 0) {
    throw 'Failed to set Geode SDK path in Geode CLI.'
}

if ($PersistEnv) {
    setx GEODE_SDK $SdkPath | Out-Null
    Write-Host 'Persisted GEODE_SDK for future terminals.'
}

& $geodeExe sdk install-binaries -p win -v $geodeVersion
if ($LASTEXITCODE -ne 0) {
    throw 'Failed to install Windows Geode prebuilt binaries.'
}

if ($InstallAndroid) {
    & $geodeExe sdk install-binaries -p android -v $geodeVersion
    if ($LASTEXITCODE -ne 0) {
        throw 'Failed to install Android Geode prebuilt binaries.'
    }
}

$binPath = Join-Path $SdkPath 'bin'
$binFiles = @()
if (Test-Path $binPath) {
    $binFiles = Get-ChildItem -Path $binPath -Recurse -File
}

if ($binFiles.Count -eq 0) {
    Write-Warning "No files found in $binPath after installation. Check Geode CLI output above."
}
else {
    Write-Host "Done. Found $($binFiles.Count) file(s) under $binPath."
}
