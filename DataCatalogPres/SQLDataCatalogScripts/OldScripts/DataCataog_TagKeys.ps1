$dataCatalog = 'http://sqlavengers.stcu.local:15156/'
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

$catCols = Get-Columns -instanceName $sqlinstance -databaseName $database | Where-Object {$_.columnName  -like "*key"}

$tags = @{
    "Sensitivity" = @("General")
    "Information Type" = @("Other")
}

Import-ColumnsTags -columns $catCols -categories $tags