Disable-AzContextAutosave -Scope Process
#Param(
# [string]$clustername
#)
$clustername = Get-AutomationVariable -Name 'clustername'
$connection = Get-AutomationConnection -Name 'AzureRunAsConnection'

$logonAttempt = 0
while(!($connectionResult) -And ($logonAttempt -le 10))
{
    $LogonAttempt++
    # Logging in to Azure...
    $connectionResult = Connect-AzAccount -ServicePrincipal -Tenant $connection.TenantID -ApplicationID $connection.ApplicationID -CertificateThumbprint $connection.CertificateThumbprint -SubscriptionId 7798bfea-7477-48a8-ab1a-8eef391c0218
Start-Sleep -Seconds 30
}


$dt = Get-Date -Format FileDateUniversal
$actionscriptname = $clustername+$dt
$workernode = 'wk'+$actionscriptname
$headnode = 'hd'+$actionscriptname

Submit-AzHDInsightScriptAction -resourcegroupname HDIESP-RG -name $workernode -clustername $clustername -uri "https://hdiconfigactions.blob.core.windows.net/linuxospatchingrebootconfigv02/install-updates-schedule-reboots.sh" -NodeTypes WorkerNode -parameters "1 1"

Submit-AzHDInsightScriptAction -resourcegroupname HDIESP-RG -name $headnode -clustername $clustername -uri "https://hdiconfigactions.blob.core.windows.net/linuxospatchingrebootconfigv02/install-updates-schedule-reboots.sh" -NodeTypes HeadNode -parameters "1 0"
