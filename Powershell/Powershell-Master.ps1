$DateCutOff = (Get-Date).AddDays(-30)
Get-ADUser -Filter * -Properties whenCreated | Where-Object {$_.whenCreated -gt $DateCutOff} | Format-Table Name, whenCreated



Install-Script -Name SCONFIG


Import-Csv "C:\Path\To.csv" | ForEach-Object {
    Get-ADUser -Filter "DisplayName -eq '$($_.DisplayName)'" -Properties SamAccountName |
 Select SamAccountName
 } | Export-CSV C:\Path\To.SamAccountName.csv -NoTypeInformation
 
  $file = Import-Csv "C:\Temp\SamAccountName.csv"
 foreach ($line in $file){
     Add-ADGroupMember -Identity "ADGroup" -Members $line
     }
 
 