# Getting processes
Get-Process | Select-Object PorcessName, Path, ID | `
Export-Csv -Path "C:\Users\jgrot\OneDrive\Desktop\CSI-230\csi-230\Week9\myProcesses.csv"

# Getting Services
Get-Service | Export-Csv -Path "C:\Users\jgrot\OneDrive\Desktop\CSI-230\csi-230\Week9\myServices.csv"

# Getting DNS and DHCP server info
Get-WmiObject -Class Win32_NetworkAdapterConfiguration | select DNSDomain, DHCPServer, DefaultIPGateway, IPAddress

# Starting windows calculator
Start-Process Calc.exe

Start-Sleep -Seconds 3

Stop-Process -name "CalculatorApp"


