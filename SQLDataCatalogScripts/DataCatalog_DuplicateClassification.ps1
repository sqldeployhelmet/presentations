<#
    Script will pull out column data classifications and apply it to what should be the same
    database in a second location.

    Created: 2018-12-06

    Author: Josh Smith

    Changelog:
        2019-02-12  Refactored to use the new data catalog PS module. No more querying the source or target database! JDS

#>

$dataCatalog = 'http://[sqlavengers FQDN]:15156/'
$sourceSQLinstance = 'sqlavengers\hawkeye' 
$sourceDatabase = 'WideWorldImporters' 
$targetSQLInstance = 'sqlavengers\hawkeye' 
$targetDatabase = 'WideWorldImporters_Development'
                  
##################################################################################################
$AuthToken = 'NTg2MTYxODI4NDY4MzU5MTY4OjRkZjQ4YTFhLWM4NTMtNDY3MS1iMDE1LTc1MmMxOWY1ZGUzYw=='
$Headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$Headers.Add("Authorization", "Bearer $AuthToken")

# refresh the PS module for Data catalog and store the auth token:
$cmd = $dataCatalog + 'powershell'
$outfile = 'C:\Program Files\WindowsPowerShell\Modules\data-calog.psm1'
Invoke-WebRequest -Uri $cmd -OutFile $outfile -Headers @{"Authorization"="Bearer $AuthToken"; "Accept"="text/plain"}
Import-Module $outfile

Use-Classification -ClassificationAuthToken $AuthToken

$start = Get-Date


#Get-Columns -instanceName $sourceSQLinstance -databaseName $sourceDatabase

Copy-DatabaseClassification -sourceInstanceName $sourceSQLInstance -sourceDatabaseName $sourceDatabase -destinationInstanceName $targetSQLInstance -destinationDatabaseName $targetDatabase -ErrorAction Stop
$end = Get-Date
$duration = $end - $start
$m = $duration.Minutes
Write-Host "Operation took $m minute(s)."
