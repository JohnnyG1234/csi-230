#!/bin/bash

#check if info file exists, if not exit

file="~/targetedthreats.csv"
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

		2) iptables
		;;

		3) iptables
		;;

		4) iptables
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
	egrep [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3} $file
	sleep 5
}

menu
