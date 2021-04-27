<#
.Synopsis
    Connect to all Office 365 services
.DESCRIPTION
   Connect to all Office 365 services in an easy way. Also tries to automatically install all the needed modules for the command to work. 
.EXAMPLE
   Connect-All
.EXAMPLE
   Connect-all -Credentials $CredentialObject
#>
function Connect-All
{
    [CmdletBinding()]
    Param
    (
        [System.Management.Automation.PSCredential]$Credentials
    )
    Process
    {
    
    if ($Credentials -eq $null)
    {
        $credentials = Get-Credential
    }

    $tenant = (($credentials.UserName.Split("@"))[1]).split(".")[0]

    $WarningPreference = 'SilentlyContinue'
    $HasSkypeModule = $false
    $IsLocalAdmin = $true

    #Kontrollera ifall vårt Shell körs med eleverade rättigheter (som krävs för installation av moduler)
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    $IsLocalAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

    if ((Test-Connection 8.8.8.8 -Quiet -Count 1) -eq $false)
    {
        Write-Host "No Internet connection found!" -ForegroundColor Red
        Write-Host "Command aborted.." -ForegroundColor Red
        Read-Host
        break
        #Eventuellt använd exit istället för break..
    }

    #Kontrollera ifall modulen msonline finns.. 
    if(-not(Get-Module -ListAvailable "msonline"))
    {
        Write-Host "Module MSOnline module not found" -ForegroundColor Yellow
        Write-Host "Installing module MSOnline" -ForegroundColor Green
        if($IsLocalAdmin)
        { 
            install-module msonline
        }
        else 
        {
            Write-Host "This shell needs elevated privileges to install modules" -ForegroundColor Red
            break
        }
    }
    #Kontrollera ifall ExchangeOnline-module finns
    if(-not(Get-Module -ListAvailable "ExchangeOnlineManagement"))
    {
        Write-Host "Module ExchangeOnlineManagement module not found" -ForegroundColor Yellow
        Write-Host "Installing module ExchangeOnlineManagement" -ForegroundColor Green
        if($IsLocalAdmin)
        { 
            install-module ExchangeOnlineManagement
        }
        else 
        {
            Write-Host "This shell needs elevated privileges to install modules" -ForegroundColor Red
            break
        }
    }
    #Kontrollera ifall modulen AzureAD finns..och preview..  
    if(-not(Get-Module -ListAvailable "AzureAD*"))
    {
        Write-Host "Module AzureAD module not found" -ForegroundColor Yellow
        Write-Host "Installing module AzureAD" -ForegroundColor Green
        if($IsLocalAdmin)
        { 
            install-module azureadpreview
        }
        else 
        {
            Write-Host "This shell needs elevated privileges to install modules" -ForegroundColor Red
            break
        }
    }
    if(-not(Get-Module -ListAvailable "Microsoft.Online.SharePoint.PowerShell"))
    {
        Write-Host "Microsoft.Online.SharePoint.PowerShell module not found" -ForegroundColor Yellow
        Write-Host "Installing module Microsoft.Online.SharePoint.PowerShell" -ForegroundColor Green
        if($IsLocalAdmin)
        { 
            install-module Microsoft.Online.SharePoint.PowerShell
        }
        else 
        {
            Write-Host "This shell needs elevated privileges to install modules" -ForegroundColor Red
            break
        }
    }
    if(-not(Get-Module -ListAvailable "MicrosoftTeams"))
    {
        Write-Host "MicrosoftTeams module not found" -ForegroundColor Yellow
        Write-Host "Installing module MicrosoftTeams" -ForegroundColor Green
        if($IsLocalAdmin)
        { 
            install-module MicrosoftTeams
        }
        else 
        {
            Write-Host "This shell needs elevated privileges to install modules" -ForegroundColor Red
            break
        }
    }
    if(-not(Get-Module -ListAvailable "SkypeOnlineConnector"))
    {
        $HasSkypeModule = $false
        Write-Host "SkypeOnlineConnector module not found" -ForegroundColor Yellow
        Write-Host "To use Skype command you need to download the SkypeOnlineConnector from:" -ForegroundColor Yellow
        Write-Host 'https://www.microsoft.com/en-us/download/details.aspx?id=39366' -ForegroundColor Green
        Write-Host "Attempting to connect to other services" -ForegroundColor Green
    }
    else
    {
        Write-Host "Connecting Skype Online.." -ForegroundColor Green
        $sfbSession = New-CsOnlineSession -Credential $Credentials
        Import-Module (Import-PSSession $sfbSession -AllowClobber) -Global -ErrorAction SilentlyContinue
    }
    
    Write-Host "Connecting MsOnline.." -ForegroundColor Green
    try
    {
        Connect-MsolService -Credential $credentials
    }
    catch
    {
        Write-Host "Could not connect to MsOnline" -ForegroundColor Red
        Write-Host "Check your Credentials" -ForegroundColor Red
        Write-Host "Command will abort" -ForegroundColor Red
        break
    }
    
    Write-Host "Connecting AzureAD.." -ForegroundColor Green
    Connect-AzureAD -Credential $credentials
    Write-Host "Connecting SPO.." -ForegroundColor Green
    try{
        Connect-SPOService -Url https://$tenant-admin.sharepoint.com -credential $credentials
    }
    catch {
        Write-Host "Error Connecting Sharepoint Online." -ForegroundColor Yellow
        Write-Host -NoNewline "Please enter Tenant "
        write-host -NoNewline "NAME" -ForegroundColor Green 
        Write-Host -NoNewline " to connect to http://"
        Write-Host -NoNewline "NAME" -ForegroundColor Green
        Write-Host -NoNewline "-admin.sharepoint.com or "
        Write-Host -NoNewline "X" -ForegroundColor Red
        Write-Host -NoNewline " to abort operation and continue"
        $tenant = Read-Host
        if (($tenant -ne "X") -or ($tenant.Length -ne 0))
        {
           Connect-SPOService -Url https://$tenant-admin.sharepoint.com -credential $credentials 
        }
        else
        {
            Write-Host "Connecting to Sharepoint Online - Skipped" -ForegroundColor Yellow
        }
    }
    Write-Host "Connecting Exchange Online.." -ForegroundColor Green
    #$exchangeSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "https://outlook.office365.com/powershell-liveid/" -Credential $credentials -Authentication "Basic" -AllowRedirection
    #Import-Module (Import-PSSession $exchangeSession -AllowClobber) -Global -ErrorAction SilentlyContinue
    Connect-ExchangeOnline -credential $credentials
    Write-Host "Connecting SCC.." -ForegroundColor Green
    $SccSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.compliance.protection.outlook.com/powershell-liveid/ -Credential $credentials -Authentication "Basic" -AllowRedirection
    Import-module (Import-PSSession $SccSession -Prefix cc -AllowClobber) -Global -ErrorAction SilentlyContinue
    
    
    if($HasSkypeModule)
    {
       Write-Host "Connecting Skype.." -ForegroundColor Green
       $sfboSession = New-CsOnlineSession -Credential $credential
       Import-module(Import-PSSession $sfboSession -AllowClobber) -Global 
    }


    Write-Host "Connecting Teams.." -ForegroundColor Green
    try{
    Connect-MicrosoftTeams -Credential $credentials
    }
    catch
    {
        Write-Host "Could not connect to Teams" -ForegroundColor Red
        Write-Host "Try installing latest version of .NET framework" -ForegroundColor Yellow
    }
    }
    
}


