# hdinsight-auto-os-patch-code
powershell commands to execute:

new-azresourcegroupdeployment -resourcegroupname HDI-DEMO -templateuri https://raw.githubusercontent.com/javieriroman/hdinsight-auto-os-patch-code/master/script-action-template.json -templateparameterfile /home/javier/script-action-parameters.json -v

Import-AzAutomationRunbook -Path /home/javier/auto-runbook.ps1 -Name hdi-patch-os -ResourceGroupName automationtest1 -AutomationAccountName testautomation -Type PowerShell

Publish-AzAutomationRunbook -AutomationAccountName testautomation -Name hdi-patch-os -ResourceGroupName automationtest1

$StartTime = Get-Date "1:00:00"
$EndTime = $StartTime.AddYears(1)
New-AzureRmAutomationSchedule -AutomationAccountName testautomation -Name Schedule02 -StartTime $StartTime -ExpiryTime $EndTime -DayInterval 1 -ResourceGroupName automationtest1

Register-AzureRmAutomationScheduledRunbook –AutomationAccountName testautomation –Name hdi-patch-os –ScheduleName Schedule02 -ResourceGroupName automationtest1
