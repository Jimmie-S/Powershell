################################
################################
########## Script by ###########
####### Jimmie Svensson ########
#### Jimmie@Virtualizr.tech ####
################################
################################

################################ - Connect PowerCLI

$vCenter = fqdn.domain.local
Connect-VIServer -server $vCenter
# Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false
# Set-PowerCLIConfiguration -Scope User -ParticipateInCEIP $false

############################## -  Variables

$DateStr = Get-Date -Format "MMdd"

############################## - Check Variables

Write-Output $DateStr
Write-Output $vcenter

