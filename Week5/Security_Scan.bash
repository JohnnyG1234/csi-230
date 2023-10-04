#!/bin/bash


function checks()
{
    if [[ $2 != $3 ]]
    then
        echo "The $1 is not compliant. The current policy should be: $2. The current value is: $3"
    else
        echo "The $1 is compliant. Current value $3"
    fi
}


pmax=$(egrep -i '^PASS_MAX_DAYS' /etc/login.defs | awk ' { print $2 } ')

# Check for password max
checks "Password Max Days" "365" "${pmax}"

# Check for password min
pmin=$(egrep -i '^PASS_MIN_DAYS' /etc/login.defs | awk ' { print $2 } ')
checks "Password min days" "14" "${pmin}"

# Check the pass warn age
pwarn=$(egrep -i '^PASS_WARN_AGE' /etc/login.defs | awk ' { print $2 } ')
checks "Password warn age" "7" "${pwarn}"

# Check the SSH UsePam configuration
chkSSHPAM=$(egrep -i "^UsePAM" /etc/ssh/ssh_config | awk ' { print $2 } ')
checks "SSH UsePam" "yes" "${chkSSHPAM}"

# Check permissions or users home directory

echo ""
for eachDir in $(ls -l /home | egrep '^d' | awk ' { print $3 } ')
do

    chDir=$(ls -ld /home/${eachDir} | awk ' {print $1 } ')
    checks "Home Directory ${eachDir}" "drwx------" "${chDir}"

done

chkIpForward=$(egrep -i "net\.ipv4\.ip_forward" /etc/sysctl.conf /etc/sysctl.d/* | awk ' { print $1 } ')
checks "IP Forwading" "0" "${chkIpForward: -1}"

chkICMPRe=$(sysctl net.ipv4.conf.all.send_redirects | awk ' {print $3 } ')
checks "ICMP redirects" "0" "${chkICMPRe}"

chkUid=$(stat /etc/crontab | grep "Uid:" | awk ' {print $5 } ')
checks "Uid in /etc/crontab" "0/" "${chkUid}"


chkGid=$(stat /etc/crontab | grep "Gid:" | awk ' {print $9 } ')
checks "Gid in /etc/crontab" "0/" "${chkGid}"

chkUidPass=$(stat /etc/passwd | grep "Acces:" | awk ' {print $5 } ')
checks "Uid for pass perm" "0/" "${chkUid}"

chkGidPass=$(stat /etc/passwd | grep "Acces:" | awk ' {print $9 } ')
checks "Gid for pass perm" "0/" "${chkGid}"

chkAccesPass=$(stat /etc/passwd | grep "Gid:" | awk ' {print $2 } ')
checks "Acces num for pass" "(0644/-rw-r--r--)" "${chkAccesPass}"

chkShadUid=$(stat /etc/shadow | grep "Gid:" | awk ' {print $5 } ')
checks "Uid for /etc/shadow" "0/" "${chkShadUid}"

chkShadGid=$(stat /etc/shadow | grep "Gid:" | awk ' {print $10 } ')
checks "Gid for /etc/shadow" "0/" "${chkShadUid}"

chkShadAcces=$(stat /etc/shadow | grep "Gid:" | awk ' {print $2 } ')
checks "Acces for /etc/shadow" "(0640/-rw-r-----)" "${chkShadAcces}"

chkgroupUid=$(stat /etc/group | grep "Gid:" | awk ' {print $5 } ')
checks "Uid for /etc/group" "0/" "${chkgroupUid}"

chkgroupGid=$(stat /etc/group | grep "Gid:" | awk ' {print $9 } ')
checks "Gid for /etc/group" "0/" "${chkgroupGid}"

chkAccesGroup=$(stat /etc/passwd | grep "Gid:" | awk ' {print $2 } ')
checks "Acces num for group" "(0644/-rw-r--r--)" "${chkAccesGroup}"


