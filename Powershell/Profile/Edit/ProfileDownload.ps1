#URL to profile script
$URI = "https://git.itgarden.se/projects/OR/repos/openrepo/raw/Powershell/Powershell%20Profiles/Microsoft.PowerShell_profile.ps1"

#Create/Overwrite current profile
New-Item -Path $PROFILE -ItemType file -Force

#Download Powershell Profile
Invoke-WebRequest $URI | Select-Object -ExpandProperty Content | Out-file -FilePath "$PROFILE" -Force


Install-Script -Name SCONFIG
