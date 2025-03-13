$FeatureName = "File-Services"
$ComputerName = "DC01"
if (-not(Get-WindowsFeature -Name $FeatureName -ComputerName $ComputerName | Where-Object{$_.Installed -eq $true})) {
    Install-WindowsFeature -Name $FeatureName -ComputerName $ComputerName
}

if (-not (Get-WindowsFeature -Name $FeatureName -ComputerName $ComputerName | Where-Object {$_.Installed -eq true})) {
    Write-Host 
}