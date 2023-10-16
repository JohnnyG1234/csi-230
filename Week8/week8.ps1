# Storyline: Review the security event log

$saveDir = "C:\Users\jgrot\OneDrive\Desktop\CSI-230\csi-230\Week8\Logs"

Get-EventLog -list

# Create a promt to allow user to select the log to view
$readLog = Read-host -Promt "Please select a log to review from the list above"
$searchString = Read-host -Promt "What string do you want to search for?"

$searchString = "*$searchString*"

# Print the results for the log
Get-EventLog -LogName $readLog -Newest 40 | where {$_.Message -ilike $searchString } | export-csv -NoTypeInformation -Path $saveDir
