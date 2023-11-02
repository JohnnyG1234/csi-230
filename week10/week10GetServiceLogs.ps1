# lists all registered services
# promts the user if they want to view all, stopped or runing services

function prompt_user(){
    cls

    # promt the user for what they want to see
    $userChoice = Read-Host -Prompt "Do you want to see all, running, or stopped services? (press q to quit)"

    # If user wants to quit then... THEN QUIT!!!! What else would you do? Sorry that was rude my bad
    if ($userChoice -match "^[qQ]$"){
        break
    }

    # Determine what function to run next based on user input
    if ($userChoice -match "^all$"){
        get_all_services
    }
    elseif ($userChoice -match "^stopped$"){
        get_stopped_services
    }
    elseif ($userChoice -match "^running$"){
        get_running_services
    }
    else{
        Write-Host "Invalid input, try again"
        sleep 2
        prompt_user
    }

}


function get_all_services(){
    cls
    
    Get-Service

    # puase the screen until the user is ready to procced
    Read-Host -Prompt "Press enter when you are done"

    prompt_user
}


function get_stopped_services(){
    cls
    
    Get-Service | where { $_.Status -eq "Stopped" }

    # puase the screen until the user is ready to procced
    Read-Host -Prompt "Press enter when you are done"

    prompt_user
}


function get_running_services(){
    cls
    
    Get-Service | where { $_.Status -eq "Running" }

    # puase the screen until the user is ready to procced
    Read-Host -Prompt "Press enter when you are done"

    prompt_user
}



prompt_user