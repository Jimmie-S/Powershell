
Install-PackageProvider NuGet -MinimumVersion '2.8.5.201' -Force

Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

Install-Module -Name 'posh-git' -Force


# Set your PowerShell execution policy
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force

# Install Chocolatey
Invoke-WebRequest https://chocolatey.org/install.ps1 -UseBasicParsing | Invoke-Expression

# Install Chocolatey packages
choco install git.install -y
choco install conemu -y

# Install PowerShell modules
Install-PackageProvider NuGet -MinimumVersion '2.8.5.201' -Force
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module -Name 'posh-git'

# Creates profile if doesn't exist then edits it

if (!(Test-Path -Path $PROFILE)){ New-Item -Path $PROFILE -ItemType File } ; powershell_ise.exe $PROFILE


Import-Module -Name posh-git
$StartSshAgent = "Start-Service ssh-agent"
$StartSshAgent