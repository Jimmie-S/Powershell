
############################## -  Load Powershell SnapIn

Add-PSSnapin Microsoft.Exchange.Management.PowerShell.SnapIn


$alias = "Alias"
New-Mailbox -Name $alias -Alias $alias -OrganizationalUnit "OU=Shared,OU=Funktionskonton,DC=resurs,DC=loc" -Database "MBXB002" -UserPrincipalName "$alias@resurs.se" -Shared
