<#
    .SYNOPSIS
    Start Azure VMs based on tag value

    .DESCRIPTION
    This PowerShell script is meant to run inside an Azure Function App that will
    search for Azure VMs with a specific tag value and start them.
           
#>

#Input bindings are passed in via param block
param($Timer)

#The 'IsPastDue' property is 'true' when the current function invocation is later than scheduled
if ($Timer.IsPastDue) {
    Write-Host "PowerShell timer is running late!"
}

#Write an information log with the current time
$currentUTCtime = (Get-Date).ToUniversalTime()
Write-Host "PowerShell timer trigger started $currentUTCtime"

#Tag name and value script will search for on VMs
$tagName = "startup"
$tagValue = "yes"

#Get VMs with specific tag name and value
Write-Output "Query VMs with TagName: $tagName and TagValue: $tagValue"
$vms = Get-AzVM -Status | Where-Object { $_.Tags[$tagName] -eq $tagValue }
If ($vms.count -lt 1) {
    Write-Output "No VMs found with TagName: $tagName and TagValue: $tagValue"   
    exit
}
Else {
    Write-Output "Found $($vms.count) VM(s) with TagName: $tagName and TagValue: $tagValue"
}

#Loop to process power action on select VMs
$jobFailures = @()
Write-Output "Processing VMs for Power On action"
Foreach ($vm in $vms) {    
    If (($vm.PowerState -eq "VM deallocated") -or ($vm.PowerState -eq "VM stopped")) {
            $powerActionRequest = Start-AzVM -Name $($vm.Name) -ResourceGroupName $($vm.ResourceGroupName) -NoWait
            Write-Output "VM: $($vm.Name) with Current State: $($vm.PowerState). Sending startup signal to VM now"
        }
    Elseif ($vm.PowerState -eq "VM running") {            
            Write-Output "VM: $($vm.Name) with Current State: $($vm.PowerState). VM already running. Skipping VM"
        }
    Else {        
        Write-Output "VM: $($vm.Name) with Current State: $($vm.PowerState). Did NOT send startup request to VM. Power state incompatibility"        
        $jobFailures += $vm.Name
    }  
}

#Output power state action failures
Write-Output "Failed VM Power Actions: $($jobFailures.count)"
Write-Output $jobFailures
