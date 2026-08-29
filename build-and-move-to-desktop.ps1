# Local build helper - builds and moves to Desktop
$ErrorActionPreference="Stop"
$env:Path="C:\Users\paul\AppData\Roaming\npm;$env:USERPROFILE\.cargo\bin;$env:Path"

Write-Host "pnpm=$(pnpm --version) cargo=$(cargo --version) node=$(node --version)"
$desktop=[Environment]::GetFolderPath('Desktop')
Write-Host "Desktop=$desktop"
Write-Host "Building AIStudio... (first build 10+ min)"
npx pake-cli "https://aistudio.google.com/apps?source=user&tag=created-by-you" --name AIStudio --identifier com.pake.aistudio --safe-domain accounts.google.com,google.com --new-window --json
if ($LASTEXITCODE -ne 0) { Write-Error "Build failed exit $LASTEXITCODE - if link.exe missing, run setup.exe modify as Admin (see README) or use GitHub Actions"; exit $LASTEXITCODE }

Write-Host "Moving outputs to Desktop..."
Get-ChildItem -Path . -Filter "AIStudio*" -File | ForEach-Object { Write-Host "Found $($_.FullName)"; Move-Item -LiteralPath $_.FullName -Destination $desktop -Force; Write-Host "Moved to $desktop\$($_.Name)" }
# also check src-tauri bundle location
Get-ChildItem -Path "src-tauri\target" -Recurse -Include "AIStudio*.msi","AIStudio*.exe" -ErrorAction SilentlyContinue | ForEach-Object { Copy-Item -LiteralPath $_.FullName -Destination $desktop -Force; Write-Host "Copied $($_.FullName) to $desktop" }

Write-Host "Desktop contents:"
Get-ChildItem -LiteralPath $desktop -Filter "AIStudio*" | Format-Table Name,Length,LastWriteTime
