################################
################################
########## Script by ###########
####### Jimmie Svensson ########
#### Jimmie@Virtualizr.tech ####
################################
################################

################################ - Connect PowerCLI

<<<<<<< HEAD
$vCenter = fqdn.domain.local
=======
$vCenter = fqdn.domain.local
>>>>>>> 60fdd1adacf9f58b154de6622569c4892a710578
Connect-VIServer -server $vCenter
# Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false

############################## -  Variables

$DateStr = Get-Date -Format "MMdd"


############################## - Check Variables

Write-Output $DateStr
Write-Output $vcenter

############################## - GET UUID and VM-Ref

$ServerNameStr = "ServerName"
Write-Output $ServerNameStr
Get-VM $ServerNameStr | ForEach-Object { (Get-View $_.Id).config.uuid }
Get-VM $ServerNameStr | Format-Table id

############################## - Get Cluster and list all VMs and connected Portgroups

$Cluster = "Clustername"
Write-Output $Cluster
Get-Cluster $Cluster | Get-VM | Get-NetworkAdapter | Select-Object @{N = "VM"; E = { $_.Parent.Name } }, @{N = "NIC"; E = { $_.Name } }, @{N = "Network"; E = { $_.NetworkName } } | Export-Csv D:\Temp\JISV\Kat3-6.csv

############################## - Get all ESX hosts and times in vCenter 

Get-VMHost | Sort-Object Name | Select-Object Name, @{N = ”Cluster”; E = { $_ | Get-Cluster } }, @{N = ”Datacenter”; E = { $_ | Get-Datacenter } }, @{N = “NTPServiceRunning“; E = { ($_ | Get-VmHostService | Where-Object { $_.key -eq “ntpd“ }).Running } }, @{N = “StartupPolicy“; E = { ($_ | Get-VmHostService | Where-Object { $_.key -eq “ntpd“ }).Policy } }, @{N = “NTPServers“; E = { $_ | Get-VMHostNtpServer } }, @{N = "Date&Time"; E = { (get-view $_.ExtensionData.configManager.DateTimeSystem).QueryDateTime() } } | format-table -autosize

############################## - Add Portgroup to vSwitch on host

$VMhost = "fqdn-to-host"
$NewVLANName = "NewVlanName"
$NewVLANID = "VLANID"
Get-VirtualSwitch -VMHost $VMhost -Name vSwitch0 | New-VirtualPortGroup -Name $NewVLANName -VLANID $NewVLANID

############################## - List all Portgroups on a specific VMware host

$VMhost = "fqdn-to-host"
$vSwitchName = "vswitchname"
Get-VMHost -name $VMhost | Sort-Object Name | Get-VirtualSwitch -name "$($vSwitchName)" | Get-VirtualPortGroup

############################## - 

Get-VIPermission | Where {$_.Name –like “Admin”} | Select Role, Principal, Entity, UID | Export-CSV “C:\Temp\Rights.csv”