Get-InstalledModule################################ - List All Installed Modules

Get-InstalledModule

################################ - Find Specific Installed Module 
# Works with for example "VMware*

$ModuleName = "VMware*"
Get-InstalledModule -name $ModuleName

################################ - Find latest version of module

$ModuleName = "PowerShellGet"
Find-Module -Name $ModuleName

