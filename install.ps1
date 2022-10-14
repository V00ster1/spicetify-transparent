# Enable TLS 1.2 since it is required for connections to GitHub
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Write-Host "Beginning installation of spicetify-transparent"
Write-Host "https://github.com/sandarutharuneth/spicetify-transparent"

# Give time for user to cancel via CTRL+C
Start-Sleep -s 3

$checkSpice = Get-Command spicetify -ErrorAction Silent
if ($null -eq $checkSpice) {
  Write-Host -ForegroundColor Red "Spicetify not found. Installing that for you..."
  Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/khanhas/spicetify-cli/master/install.ps1" | Invoke-Expression
}

# Check if ~\.spicetify-cli\Themes\transparent directory exists
$spicePath = spicetify -c | Split-Path
$themePath = "$spicePath\Themes\transparent"
if (-not (Test-Path $themePath)) {
  Write-Host "Creating transparent theme folder..."
  New-Item -Path $themePath -ItemType Directory | Out-Null
} else {
  # Remove pre-existing files, only keep the newest files
  Remove-Item "$themePath\*" -Recurse -Force
}

# Download latest master
$zipUri = "https://github.com/sandarutharuneth/spicetify-transparent/archive/refs/heads/master.zip"
$zipSavePath = "$themePath\transparent-main.zip"
Write-Host "Downloading spicetify-transparent latest master..."
Invoke-WebRequest -Uri $zipUri -UseBasicParsing -OutFile $zipSavePath

# Extract theme from .zip file
Write-Host "Extracting..."
Expand-Archive -Path $zipSavePath -DestinationPath $themePath -Force
Get-ChildItem "$themePath\spicetify-transparent-main\*" | ForEach-Object { Move-Item $_ $themePath }
Remove-Item "$themePath\spicetify-transparent-main"

# Delete .zip file
Write-Host "Deleting zip file..."
Remove-Item -Path $zipSavePath

# Change Directory to the Theme Folder
Set-Location $themePath

# Copy the transparent.js to the Extensions folder
Copy-Item transparent.js ..\..\Extensions
Write-Host "+ Installed transparent.js theme"

# Apply the theme with spicetify config calls
spicetify config extensions transparent.js
spicetify config current_theme transparent
spicetify config color_scheme dark
spicetify config inject_css 1 replace_colors 1 overwrite_assets 1
Write-Host "+ Configured transparent theme"

# Patch the xpui.js for sidebar fixes
# credit: https://github.com/JulienMaille/dribbblish-dynamic-theme/blob/main/install.ps1
$configFile = Get-Content "$spicePath\config-xpui.ini"
if (-not ($configFile -match "xpui.js_find_8008")) {
  $rep = @"
[Patch]
xpui.js_find_8008=,(\w+=)32,
xpui.js_repl_8008=,`${1}58,
"@
  # In case missing Patch section
  if (-not ($configFile -match "\[Patch\]")) {
    $configFile += "`n[Patch]`n"
  }
  $configFile = $configFile -replace "\[Patch\]",$rep
  Set-Content "$spicePath\config-xpui.ini" $configFile
}
Write-Host "+ Patched xpui.js for Sidebar fixes"

# backup apply or just apply where necessary
# credit: https://github.com/JulienMaille/dribbblish-dynamic-theme/blob/main/install.ps1
$backupVer = $configFile -match "^version"
$version = ConvertFrom-StringData $backupVer[0]
if ($version.version.Length -gt 0) {
  spicetify apply
} else {
  spicetify backup apply -q
}
Write-Host "+ Applied Theme"
