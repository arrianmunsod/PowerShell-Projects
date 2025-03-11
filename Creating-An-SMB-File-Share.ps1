# You can type this directly to the PowerShell terminal 
New-Item -ItemType Directory -Path "C:\Test-Folder-01"
New-SmbShare -Name "Test-Folder-01" -Path "C:\Test-Folder-01" -CachingMode None

# Line number 2 creates the folder first, assuming you haven't created it

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
