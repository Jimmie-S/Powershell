Connect-VIServer -server resvcenter1.resurs.loc

$VlanName = "Name"
$VlanID = "ID"

#Kat1-2

Get-VirtualSwitch -VMHost resesx13.resurs.loc -Name vSwitch0 | New-VirtualPortGroup -Name $VlanName -VLANID $VlanID
Get-VirtualSwitch -VMHost resesx14.resurs.loc -Name vSwitch0 | New-VirtualPortGroup -Name $VlanName -VLANID $VlanID
Get-VirtualSwitch -VMHost resesx15.resurs.loc -Name vSwitch0 | New-VirtualPortGroup -Name $VlanName -VLANID $VlanID
Get-VirtualSwitch -VMHost resesx20.resurs.loc -Name vSwitch0 | New-VirtualPortGroup -Name $VlanName -VLANID $VlanID
Get-VirtualSwitch -VMHost resesx21.resurs.loc -Name vSwitch0 | New-VirtualPortGroup -Name $VlanName -VLANID $VlanID
Get-VirtualSwitch -VMHost resesx22.resurs.loc -Name vSwitch0 | New-VirtualPortGroup -Name $VlanName -VLANID $VlanID
Get-VirtualSwitch -VMHost resesx34.resurs.loc -Name vSwitch0 | New-VirtualPortGroup -Name $VlanName -VLANID $VlanID
Get-VirtualSwitch -VMHost resesx37.resurs.loc -Name vSwitch0 | New-VirtualPortGroup -Name $VlanName -VLANID $VlanID

#KAT3-6

Get-VirtualSwitch -VMHost resesx32.resurs.loc -Name vSwitch0 | New-VirtualPortGroup -Name $VlanName -VLANID $VlanID
Get-VirtualSwitch -VMHost resesx33.resurs.loc -Name vSwitch0 | New-VirtualPortGroup -Name $VlanName -VLANID $VlanID
Get-VirtualSwitch -VMHost resesx35.resurs.loc -Name vSwitch0 | New-VirtualPortGroup -Name $VlanName -VLANID $VlanID
Get-VirtualSwitch -VMHost resesx36.resurs.loc -Name vSwitch0 | New-VirtualPortGroup -Name $VlanName -VLANID $VlanID
Get-VirtualSwitch -VMHost resesx28.resurs.loc -Name vSwitch0 | New-VirtualPortGroup -Name $VlanName -VLANID $VlanID
Get-VirtualSwitch -VMHost resesx29.resurs.loc -Name vSwitch0 | New-VirtualPortGroup -Name $VlanName -VLANID $VlanID
Get-VirtualSwitch -VMHost resesx30.resurs.loc -Name vSwitch0 | New-VirtualPortGroup -Name $VlanName -VLANID $VlanID
Get-VirtualSwitch -VMHost resesx31.resurs.loc -Name vSwitch0 | New-VirtualPortGroup -Name $VlanName -VLANID $VlanID