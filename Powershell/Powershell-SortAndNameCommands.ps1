$DateCutOff = (Get-Date).AddDays(-30)
Get-ADUser -Filter * -Properties whenCreated | Where-Object {$_.whenCreated -gt $DateCutOff} | Format-Table Name, whenCreated



Install-Script -Name SCONFIG


Import-Csv "C:\Path\To.csv" | ForEach-Object {
    Get-ADUser -Filter "DisplayName -eq '$($_.DisplayName)'" -Properties SamAccountName |
 Select-Object SamAccountName
 } | Export-CSV C:\Path\To.SamAccountName.csv -NoTypeInformation
 
  $file = Import-Csv "C:\Temp\SamAccountName.csv"
 foreach ($line in $file){
     Add-ADGroupMember -Identity "ADGroup" -Members $line
     }
 

############################## - Compare Installed Modules with Modules in PSGallery
# Needs the file Compare-Modules.psm1 in C:\Program Files\WindowsPowerShell\Modules\Compare-Modules

Compare-Module
 
Compare-Module | Where-Object UpdateNeeded | Out-Gridview -title "Select modules to update" -outputMode multiple | ForEach-Object { Update-Module $_.name }
      
Compare-Module -name "VMware*" | Format-Table name, updateneeded, onlineversion, installedversion