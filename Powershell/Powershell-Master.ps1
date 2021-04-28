$DateCutOff = (Get-Date).AddDays(-30)
Get-ADUser -Filter * -Properties whenCreated | Where-Object {$_.whenCreated -gt $DateCutOff} | Format-Table Name, whenCreated



Install-Script -Name SCONFIG