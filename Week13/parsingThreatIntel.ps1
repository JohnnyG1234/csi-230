﻿# Array of websites containing threat intell
$drop_urls = @('https://rules.emergingthreats.net/blockrules/emerging-botcc.rules' , 'https://rules.emergingthreats.net/blockrules/compromised-ips.txt')

# Loop through the URLs for the rules list

foreach ($u in $drop_urls) {

    # Extract the filename
    $temp = $u.split("/")

    # The last element in the array plucked off is the filename
    $file_name = $temp[-1]

    if (Test-Path $file_name) {
        
        continue

    } else {
        
        # Download the rules list
        Invoke-WebRequest -Uri $u -OutFile $file_name

    } # close if statement

} # close the foreach loop


# Array containing the filename
$input_paths = @('.\compromised-ips.txt' , '.\emerging-botcc.rules')

# Extract the IP addresses
$regex_drop = '\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b'

# Apend the IP addresses to the temporary IP list
Select-String -Path $input_paths -Pattern $regex_drop | `
ForEach-Object { $_.Matches } | `
ForEach-Object { $_.Value } | Sort-Object | Get-Unique | `
Out-File -FilePath "ips-bad.tmp"

# Get the IP addresses discovered, loop through and replace the begining of the line with the IPTables syntax
# After the IP address, add the remaining IPTables syntax and save the results to a file
# iptables -A INPUT -s IP -j DROP

$choice = Read-Host -Prompt "Type 1 for iptables ruleset or type 2 for windows firewall ruleset"

switch ($choice)
{
    1 {(Get-Content -Path ".\ips-bad.tmp") | % `
    { $_ -replace "^", "iptables -A INPUT -s " -replace "$", "-j DROP" } | `
    Out-File -FilePath "iptables.bash"
    }
    2 {(Get-Content -Path ".\ips-bad.tmp") | % `
    { $_ -replace "^", "netsh advfirewall firewall add rule name = \'BLOCK IP ADDRESS - " -replace "$", "\' dir=in action=block remoteip=$_' | tee -a badips.netsh"} | `
    Out-File -FilePath "windowsFirewall.txt"
    }
}






# netsh advfirewall firewall add rule name=\"BLOCK IP ADDRESS - ${eachip}\" dir=in action=block remoteip=${eachip}" | tee -a badips.netsh