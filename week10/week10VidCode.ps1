# Storyline: View the event logs, check for valid log, and print the results


function select_log(){

    cls
    #List all event logs
    $theLogs = Get-EventLog -list | select log
    $theLogs | Out-Host

    # initialize the array to stor the logs
    $arrLog = @()

    foreach ($tempLog in $theLogs){
        # add each log to the array
        $arrLog += $tempLog
    }

    # promt the user for the log to view, or to quit the program
    $readLog = Read-Host -Prompt "Please enter a log from the list above or 'q' to quit the program"
    
    # check if the user want to quit
    if ($readLog -match  "^[qQ]$"){
        break
    }

    log_check -logToSearch $readLog
}

function log_check(){
    
    Param([string]$logToSearch)

    # format the user input
    # example @{Log=security}
    $theLog = "^@{Log=" + $logToSearch + "}$"

    # search the array for the exact hashtable string
    if ($arrLog -match $theLog){
        Write-Host -BackgroundColor Green -ForegroundColor white "Please wait a few moment to retrieve the log entries"
        sleep 2

        # call the function to view the log
        view_log -logToSearch $logToSearch
    } else {
        Write-Host -BackgroundColor Red -ForegroundColor White "The log specified does not exist"
        
        sleep 2
        select_log
    }
}




function view_log(){

    cls

    # get the logs
    Get-EventLog -Log $logToSearch -Newest 10

    # puase the screen until the user is ready to procced
    Read-Host -Prompt "Press enter when you are done"

    select_log

}


# Run the select log function
select_log


