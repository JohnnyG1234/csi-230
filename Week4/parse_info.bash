#!/bin/bash

function create_badIPs(){

	wget https://rules.emergingthreats.net/blockrules/emerging-drop.suricata.rules -O /tmp/emerging-drop.suricata.rules

	egrep -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.0/[0-9]{1,2}' /tmp/emerging-drop.suricata.rules | sort -u | tee badips.txt
}

	function iptables(){
	for eachip in $(cat badips.txt)
	do
		echo "iptables -a input -s ${eachip} -j drop" | tee -a badips.iptables
	done
	clear
	echo "Created IPTables firewall drop rules in file \"badips.iptables\""
}

function cisco(){
	egrep -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.0' badips.txt | tee badips.nocidr
	for eachip in $(cat badips.nocidr)
	do
		echo "deny ip host ${eachip} any" | tee -a badips.cisco
	done
	rm badips.nocidr
	clear
	echo 'Created IP Tables for firewall drop rules in file "badips.cisco"'
}

function wfirewall() {
	egrep -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.0' badips.txt | tee badips.windowsform
	for eachip in $(cat badips.windowsform)
	do
		echo "netsh advfirewall firewall add rule name=\"BLOCK IP ADDRESS - ${eachip}\" dir=in action=block remoteip=${eachip}" | tee -a badips.netsh
	done
	rm badips.windowsform
	clear
	echo "Created IPTables for firewall drop rules in file \"badips.netsh\""
}

function macOS(){
	echo '
	scrub-anchor "com.apple/*"
	nat-anchor "com.apple/*"
	rdr-anchor "com.apple/*"
	dummynet-anchor "com.apple/*"
	anchor "com.apple/*"
	load anchor "com.apple" from "/etc/pf.anchors/com.apple"

	' | tee pf.conf

	for eachip in $(cat badips.txt)
	do
		echo "block in from ${eachip} to any" | tee -a pf.conf
	done
	clear
	echo "Created IP tables for firewall drop rules in file \"pf.conf\""
}

function parseCisco(){
	wget https://raw.githubusercontent.com/botherder/targetedthreats/master/targetedthreats.csv -O /tmp/targetedthreats.csv
	awk '/domain/ {print}' /tmp/targetedthreats.csv | awk -F \" '{print $4}' | sort -u > threats.txt
	echo 'class-map match-any BAD_URLS' | tee ciscothreats.txt
	for eachip in $(cat threats.txt)
	do
		echo "match protocol http host \"${eachip}\"" | tee -a ciscothreats.txt
	done
	rm threats.txt
	echo 'Cisco URL filters file successfully parsed and created at "ciscothreats.txt"'
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


echo "Choose a format"
echo "[1] iptables"
echo "[2] cisco"
echo "[3] wfirewall"
echo "[4] macOS"
echo "[5] parseCisco"
echo "[6] exit"

read -p "Please choose an option above: " OPTION

case "$OPTION" in
	1) 
		iptables
	;;
	2) 
		cisco
	;;
	3) 
		wfirewall
	;;
	4)
		macOS
	;;
	5)
		parseCisco
	;;
	6) 
		echo "Exiting..."
		exit 0
	;;
	*)
		echo "Invalid input..."
		exit 1
	;;
esac

