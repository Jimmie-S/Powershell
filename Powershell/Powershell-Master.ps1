############################## - List all users in a AD Group

Get-ADGroupMember "GroupName" | Select-Object Name

############################## - List all users in a AD Group and all Nested GroupsS

Get-ADGroupMember "GroupName" | Select-Object Name

############################## - 
