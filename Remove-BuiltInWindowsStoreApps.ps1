$appxPackages = @{}
Get-AppxPackage  | Where {!$_.IsFramework} | foreach { $appxPackages.Add($_.Name, $_); }
$appToRemove = (Get-Content ".\AppsToRemove.json") -join "" | ConvertFrom-json
$appToRemove | foreach {
    trap{
        Write-Error "Failed to remove $($_.AppName)"
    }
    $appxPackage = $appxPackages[$_.AppName];
    if(!$appxPackage){return;}
    Write-Information "Removing $($_.AppName)"
    Remove-AppxPackage $appxPackage.PackageFullName
}
