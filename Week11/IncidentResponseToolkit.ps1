# storyline: An incident response toolkit that gives the user some usefull info in a easy to use way


function menu(){
    #display a menu and ask user what their choice is

    cls
    Write-Host "1: See all running processes"
    Write-Host "2: See all registered services"
    Write-Host "3: See all TCP network sockets"
    Write-Host "4: See all user account information"
    Write-Host "5: See all networkadapterconfiguration information"
    Write-Host "6: Get command history"
    Write-Host "7: Start Discord"
    Write-Host "8: Get a Kanye Quote"
    Write-Host "9: It's over Anakin, I have the high ground!"
    Write-Host "Q: Quit Program"

    $userChoice = Read-Host -Prompt "Please select an option (number) from above"

    if ($userChoice -eq "1"){
        seeRunningProcesses
    }
    elseif ($userChoice -eq "2"){
        getAllRegisteredServices
    }
    elseif ($userChoice -eq "3"){
        #Sorry for not putting this into its own fucntion but it gave me an error when I did
        #I have no idea why :(
        Write-Host "Getting all TCP network sockets"
        Get-NetTCPConnection
        Get-NetTCPConnection | `
        Export-Csv -Path "C:\Users\$Env:UserName\OneDrive\Desktop\CSI-230\csi-230\Week11\data\TCPSocks.csv"
        Read-Host -Prompt "Press enter to continue"

        menu
    }
    elseif ($userChoice -eq "4"){

        getAllUserInfo

    }
    elseif ($userChoice -eq "5"){

        getNetworkdAdpConfig

    }
    elseif ($userChoice -eq "6"){

        getCommandHistory

    }
    elseif ($userChoice -eq "7"){

        startDiscord

    }
    elseif ($userChoice -eq "8"){

        getKanyeQuote

    }
    elseif ($userChoice -eq "9"){

        revengeOfTheSith

    }
    elseif ($userChoice -match "^[qQ]$"){

        break

    }
    else{

        Write-Host "Invalid input, try again"
        sleep 1
        menu

    }
}



function seeRunningProcesses(){
    # Shows all running processes and the file path to them
    cls

    Write-Host "Getting running processes..."
    Get-Process | Select-Object PorcessName, Path, ID
    Get-Process | Select-Object PorcessName, Path, ID | `
    Export-Csv -Path "C:\Users\$Env:UserName\OneDrive\Desktop\CSI-230\csi-230\Week11\data\myProcesses.csv"
    Read-Host -Prompt "Press enter to continue"

    menu  
}

function getAllRegisteredServices(){
    # Shows all registered services and the path to the executable controlling the service
    cls

    Write-Host "Getting all registered services..."
    Get-WmiObject -Class Win32_Service | select Name, PathName
    Get-WmiObject -Class Win32_Service | select Name, PathName | `
    Export-Csv -Path "C:\Users\$Env:UserName\OneDrive\Desktop\CSI-230\csi-230\Week11\data\myServices.csv"
    Read-Host -Prompt "Press enter to continue"

    menu
}

function getAllUserInfo(){
    # Shows all user info
    cls

    Write-Host "Getting all user info..."
    Write-Host "Name               Statues        Password Required"
    Get-WmiObject -Class Win32_UserAccount | select Name, Status, PasswordRequired
    Get-WmiObject -Class Win32_UserAccount | select Name, Status, PasswordRequired | `
    Export-Csv -Path "C:\Users\$Env:UserName\OneDrive\Desktop\CSI-230\csi-230\Week11\data\userInfo.csv"
    Read-Host -Prompt "Press enter to continue"
    
    menu
}

function getNetworkdAdpConfig(){
    # Shows all Network Adapter Configuration information"
    cls

    Write-Host "Getting Network Adapter Configuration Info..."
    Write-Host "User Configuaration      Adapter type        Name"
    Get-WmiObject -Class Win32_NetworkAdapter | select ConfigManagerUserConfig, AdapterType, Name
    Get-WmiObject -Class Win32_NetworkAdapter | select ConfigManagerUserConfig, AdapterType, Name | `
    Export-Csv -Path "C:\Users\$Env:UserName\OneDrive\Desktop\CSI-230\csi-230\Week11\data\NetworkdAdapterConfig.csv"
    Read-Host -Prompt "Press enter to continue"

    menu
}

function getCommandHistory(){
    # Gets the command history of the current session
    cls
    
    Write-Host "Getting command history..."
    Get-History
    Get-History | `
    Export-Csv -Path "C:\Users\$Env:UserName\OneDrive\Desktop\CSI-230\csi-230\Week11\data\commandHistory.csv"
    Read-Host -Prompt "Press enter to continue"

    menu
}

function startDiscord(){
    # Starts Discord!!!
    cls

    Write-Host "Starting Discord..."
    Start-Process -FilePath "C:\Users\$Env:UserName\AppData\Local\Discord\app-1.0.9023\Discord.exe"
    Read-Host -Prompt "Press enter to continue"

    menu
}

function getKanyeQuote(){
    # Gets an formats a Kanye quote from https://api.kanye.rest
    cls

    Write-Host "Getting quote..."
    $quote = Invoke-RestMethod -Uri https://api.kanye.rest
    Write-Host $quote.quote
    Read-Host -Prompt "Press enter to continue"

    menu
}

function revengeOfTheSith(){
    # The dark side of the force is a pathway to many abilities some consider to be unnatural
    cls

    $voice = New-Object -ComObject Sapi.spvoice

    # Set the speed - positive numbers are faster, negative numbers, slower
    $voice.rate = 0
    
    # Say something
    $voice.speak("You have allowed this dark lord to twist your mind, until now, until now you've become the very thing you swore to destroy.")
    $voice.speak("Don't lecture me, Obi-Wan! I see through the lies of the Jedi. I do not fear the dark side as you do. I have brought peace, freedom, justice, and security to my new Empire.")
    $voice.speak("Your new Empire?")
    $voice.speak("Don't make me kill you.")
    $voice.speak("Anakin, my allegiance is to the Republic, to democracy!")
    $voice.speak("If you're not with me, then you're my enemy.")
    $voice.speak("Only a Sith deals in absolutes.")
    $voice.speak("I will do what I must.")
    $voice.speak("You will try")


    $voice.speak("It's over Anakin, I have the high ground.")
    $voice.speak("You underestimate my power!")
    $voice.speak("Don't try it.")


    $voice.speak("You were the chosen one! It was said that you would destroy the Sith, not join them! Bring balance to the force... not leave it in darkness!")
    $voice.speak("I HATE YOU!")
    $voice.speak("You were my brother, Anakin! I loved you!")


    # https://stackoverflow.com/questions/56032478/how-do-you-get-windows-powershell-to-play-a-sound-after-bat-job-has-finished-ru
    sleep 1

    menu

}

menu
