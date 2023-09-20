#!/bin/bash

function menu() {

	# clears the screen
	clear

	echo "[1] Admin Menu"
	echo "[2] Security Menu"
	echo "[3] Exit"
	read -p "Please enter a choice above: " choice

	case "$choice" in

		1) admin_menu
		;;

		2) security_menu
		;;

		3) exit 0
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


function admin_menu(){

	clear
	echo "[L]ist Running Processes"
	echo "[N]etwork Sockets"
	echo "[V]PN Menu"
	echo "[4] Exit"
	read -p "Please enter a choice above: " choice

	case "$choice" in

		L|l) ps -ef |less
		;;

		N|n) netstat -an --inet |less
		;;

		V|v) vpn
		;;

		4) Exit 0
		;;

		*)

			echo ""
			echo "Invalid option"
			echo ""
			sleep 2

			admin_menu
	
		;;

	esac
	admin_menu
}

function vpn() {

	clear
	echo "[A}dd a user"
	echo "[D}elete a user"
	echo "[B]ack to admin menu"
	echo "[M]ain menu"
	echo "[E]xit"
	read -p "Please selct an option: " choice

	case "$choice" in

		A|a)

			bash peerchanged.bash
			tail -6 wg0.conf |less

		;;
		D|d) bash manage-users.bash
		;;
		B|b) admin_menu
		;;
		M|m) menu
		;;
		E|e) exit 0
		;;
		*)

			echo ""
			echo "Invalid option"
			echo ""
			sleep 2

			vpn

		;;


	esac
	vpn
}

menu

