#!/bin/bash

function create_badIPs(){

	wget https://rules.emergingthreats.net/blockrules/emerging-drop.suricata.rules -O /tmp/emerging-drop.suricata.rules

	egrep -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.0/[0-9]{1,2}' /tmp/emerging-drop.suricata.rules | sort -u | tee badips.txt
}


if [[ -f badIPs.txt ]]
then
	read -p "The badIps.txt file already exist, would you like to redownload it? [Y/N] : " answer
	case "$answer" in
		Y|y)
			echo "Creating badIps.txt..."
			create_badIPs
		;;
		N|n)
			echo "Not redownloading badIps.txt..."
		;;
		*)
			echo "Invalid value"
			exit 1
		;;
	esac
else
	echo "The badIps.txt file does not exist yet. Downloading file..."
	create_badIPs
fi

