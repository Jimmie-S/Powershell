#URL to profile script
$URI = "https://github.com/Jimmie-S/Powershell/blob/main/Powershell/Profile/Prepare-For-Powershell-Profile.ps1"

#Create/Overwrite current profile
New-Item -Path $PROFILE -ItemType file -Force

#Download Powershell Profile
Invoke-WebRequest $URI | Select-Object -ExpandProperty Content | Out-file -FilePath "$PROFILE" -Force


Install-Script -Name SCONFIG
