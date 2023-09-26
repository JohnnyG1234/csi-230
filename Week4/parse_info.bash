#!/bin/bash

#check if info file exists, if not exit

file="targetedthreats.csv"
if [[ -f "$file" ]];
then
	echo "File exists"
else
	echo "File Does not exist, dowloading file"
	wget https://raw.githubusercontent.com/botherder/targetedthreats/master/targetedthreats.csv
fi

function menu() {

	# clears the screen
	clear

	echo "[1] iptables"
	echo "[2] cisco"
	echo "[3] windows firewall"
	echo "[4] Mac OS X"
	read -p "Please enter a choice above: " choice

	case "$choice" in

		1) iptables
		;;

		2) cisco
		;;

		3) windowFirewall
		;;

		4) MacOsX
		;;

		*)

			echo ""
			echo "Invalid option"
			echo ""
			sleep 2

			menu
		;;

	esac
}

function iptables()
{
	echo "class-map match-any BAD_URLS"
	echo $(egrep 'domain' /home/john/csi-230/Week4/targetedthreats.csv | less)
}

menu
