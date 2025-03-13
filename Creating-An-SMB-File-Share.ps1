# WORK IN PROGRESS! CODE IS NOT YET FUNCTIONAL!
# WORK IN PROGRESS! CODE IS NOT YET FUNCTIONAL!
# WORK IN PROGRESS! CODE IS NOT YET FUNCTIONAL!

# This script does 3 things:
# 1. Automatically install the required File Services feature if it is not yet installed
# 2. Will automatically create a folder on a preferred file server, on a custom path
# 3. Will assign preferred permissions to the newly-created folder

# If you're new to PowerShell and you have questions, a quick google search can help you
# Microsoft also provides great documentation of PowerShell on their website
# You can email me at arrianmunsod312@gmail.com 

# $ComputerName is the computer you want to install the File Services, usually your file server or domain controller
$FeatureName = "File-Services"
$ComputerName = "server1"

# This block of code will check if File Services is already installed, if not, installation proceeds
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
