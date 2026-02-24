Repository: https://github.com/Benno111/geobot  
Original upstream: https://github.com/Zilko/geobot

## New Device Setup

From the repo root, run:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\setup-new-device.ps1
```

Optional Android binaries:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\setup-new-device.ps1 -InstallAndroid
```

Optional custom SDK path:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\setup-new-device.ps1 -SdkPath "C:\Users\<you>\Documents\Geode"
```

## Build (multithreaded)

From the repo root, run:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\build.ps1
```

This uses all logical CPU cores by default. You can override the number of jobs:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\build.ps1 -Jobs 8
```

Fast incremental desktop build through Geode + Ninja (skips reconfigure):

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\build.ps1 -UseGeode -Ninja -BuildOnly -Jobs 12
```

Optional Windows GPU preference utility (helps only for tools that actually use GPU):

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\build.ps1 -UseGeode -Ninja -BuildOnly -Jobs 12 -EnableHighPerformanceGpu
```

## Fast Rebuild

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\build.ps1 -FastRebuild -Jobs 12
```

## Build Android

Build both Android targets:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\build-android.ps1
```

Build one target only:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\build-android.ps1 -Target Android32
powershell -ExecutionPolicy Bypass -File .\scripts\build-android.ps1 -Target Android64
```

Optional explicit NDK path:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\build-android.ps1 -Ndk "C:\Android\Sdk\ndk\27.1.12297006"
```

Speed up repeated Android builds:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\build-android.ps1 -Ninja -BuildOnly -Jobs 12
```

Fastest Android incremental loop:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\build-android.ps1 -Fast -Target Both -Jobs 12
```

With optional Windows GPU preference utility:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\build-android.ps1 -Fast -Target Both -Jobs 12 -EnableHighPerformanceGpu
```

## Local Auth Web Server

Start local authenticated server (config is on Desktop):

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\start-auth-web.ps1 -Port 8080
```

Config file path:
- `~/Desktop/geobot-server-config.json`

GUI:
- Open `http://127.0.0.1:8080/` in your browser.
- Use the auth from `geobot-server-config.json`.
- You can switch git branch and trigger mod builds with options.
