# AIStudio Pake - GitHub Actions Build

Wraps https://aistudio.google.com/apps?source=user&tag=created-by-you as desktop app.

## Quick start (cloud build, no Rust needed locally)

1. Create GitHub repo (public free, private uses minutes) and push this folder:
   ```powershell
   cd C:\Users\paul\Desktop\AIStudio-Pake
   git init
   git add .
   git commit -m "init"
   gh repo create AIStudio-Pake --public --source=. --push
   # or manually: git remote add origin https://github.com/<you>/AIStudio-Pake.git && git push -u origin main
   ```
2. GitHub -> Actions tab -> `Build AIStudio` -> `Run workflow` -> `Run workflow`
3. Wait ~10-15min first run (cache), ~5min after.
4. Click run -> Artifacts -> `AIStudio-Windows` -> download ZIP -> extract `.msi`/`.exe`
5. Save to Desktop and install.

Proxy not needed.

## Local build (optional, requires elevated BuildTools)

See pake skill: needs `link.exe` (MSVC). Run once as Admin:
```powershell
& "C:\Program Files (x86)\Microsoft Visual Studio\Installer\setup.exe" modify --installPath "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools" --add Microsoft.VisualStudio.Workload.VCTools --includeRecommended --passive --norestart
```

Then:
```powershell
$env:Path="C:\Users\paul\AppData\Roaming\npm;$env:USERPROFILE\.cargo\bin;$env:Path"
npx pake-cli "https://aistudio.google.com/apps?source=user&tag=created-by-you" --name AIStudio --identifier com.pake.aistudio --safe-domain accounts.google.com,google.com --new-window --json
Move-Item -Path .\AIStudio*.msi,.\AIStudio*.exe -Destination ([Environment]::GetFolderPath('Desktop')) -Force -ErrorAction SilentlyContinue; Get-ChildItem ([Environment]::GetFolderPath('Desktop')) -Filter AIStudio*
```
