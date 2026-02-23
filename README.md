forked of https://github.com/Zilko/xdBot to continue its development on newer gd versions

## Dependency installer

From the repo root, run:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-dependencies.ps1 -PersistEnv
```

Optional Android binaries:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-dependencies.ps1 -PersistEnv -InstallAndroid
```

Optional custom SDK path:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-dependencies.ps1 -SdkPath "C:\Users\<you>\Documents\Geode"
```
