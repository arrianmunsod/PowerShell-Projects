# WORK IN PROGRESS! CODE IS NOT YET FUNCTIONAL!

# First, we need to make sure the File Services feature is installed, if not, we need to automate the installation
# $FeatureName is the variable name used for File-Services
# $ComputerName is the name of the computer you want the feature to be installed at, usually they are your...
# dedicated file server(s). Example: DC01 / FILE-SERVER01
# You need Administrator privilege to run this code
# You also need permissions if you want to run this script on a remote computer
# Write-Host spits out message to PowerShell terminal
# -not and -eq are logical operators for those who are new to PowerShell
# Where-Object documentation at: 
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/where-object?view=powershell-7.5


$FeatureName = "File-Services"
$ComputerName = "server1"

# Installation of File Services feature without the terminal messages
if (-not (Get-WindowsFeature -Name $FeatureName -ComputerName $ComputerName | Where-Object {}))

# Check if the feature is already installed
if (-not (Get-WindowsFeature -Name $FeatureName -ComputerName $ComputerName | Where-Object {$_.Installed -eq $true})) {
    # Feature is not installed, install it
    Write-Host "Feature '$FeatureName' is not installed on '$ComputerName'. Installing..."
    Install-WindowsFeature -Name $FeatureName -ComputerName $ComputerName -Verbose
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Feature '$FeatureName' installed successfully on '$ComputerName'."
    } else {
        Write-Warning "Feature '$FeatureName' installation failed on '$ComputerName'."
    }

} else {
    # Feature is already installed, skip
    Write-Host "Feature '$FeatureName' is already installed on '$ComputerName'. Skipping installation."
}

# You can type this directly to the PowerShell terminal 
New-Item -ItemType Directory -Path "C:\Test-Folder-01"
New-SmbShare -Name "Test-Folder-01" -Path "C:\Test-Folder-01" -CachingMode None

# Line number (#) creates the folder first, assuming you haven't created it

# -ChangeAccess [<String[]>]    specify which users are granted modify permission to access the share
#   multiple users can specified by using a comma-separated list inside the array

# To delete a share, use the Remove-SmbShare

# Another version of the code, this time with permissions
$Parameters = @{
    Name = "Test Folder 02"
    Path = "C:\Test Folder 02"
    ChangeAccess = "DOMAINNAME\HR Users", "DOMAINNAME\Accounting Users"
    FullAccess = "Administrators"}
New-SmbShare @Parameters
# Notice Change Access permission was given to HR Users and Accounting Users
# Full Access permission was given to Administrators
# Take note of the domain name and groups, they are placeholders 
# $Parameters is a PowerShell variable

# One of the reason, it's ideal to have a dedicated file server
# You can automate the creation of an SMB Share per user, just in case you have hundreds, if not,
# thousands of users. And a dedicated files server is usually always powered on and available to use
