<#
    Script will pull out column data classifications and apply it to what should be the same
    database in a second location.

    Created: 2018-12-06

    Author: Josh Smith

    Changelog:
        2019-02-12  Refactored to use the new data catalog PS module. No more querying the source or target database! JDS

#>

$dataCatalog = 'http://[sqlavengers FQDN]:15156/'
$sqlinstance = 'sqlavengers\hawkeye' #Read-Host -Prompt 'Please enter SQL instance with the target database.'
$database = 'WideWorldImportersDW' #Read-Host -Prompt 'Enter the target database name'


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

$emptyCols = Get-Columns -instanceName $sqlinstance -databaseName $database | Where-Object {$_.tableRowCount  -eq 0}

$tags = @{
    "Scope" = @("Descoped: Empty Table")
}

Import-ColumnsTags -columns $emptyCols -categories $tags
