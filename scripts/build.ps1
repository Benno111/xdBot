param(
    [string]$BuildDir = "build",
    [string]$Config = "RelWithDebInfo",
    [int]$Jobs = [Math]::Max(1024, [Environment]::ProcessorCount * 1024),
    [switch]$Clean
)

$ErrorActionPreference = "Stop"

if ($Clean -and (Test-Path $BuildDir)) {
    Remove-Item -Recurse -Force $BuildDir
}

if (-not (Test-Path $BuildDir)) {
    New-Item -ItemType Directory -Path $BuildDir | Out-Null
}

Write-Host "Configuring CMake in '$BuildDir' with config '$Config'..."
cmake -S . -B $BuildDir -DCMAKE_BUILD_TYPE=$Config
if ($LASTEXITCODE -ne 0) {
    throw "CMake configure failed."
}

Write-Host "Building with $Jobs parallel job(s)..."
cmake --build $BuildDir --config $Config --parallel $Jobs
if ($LASTEXITCODE -ne 0) {
    throw "CMake build failed."
}

Write-Host "Build completed."
