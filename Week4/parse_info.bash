#check if info file exists, if not exit

tfile="targeted_threats.csv"
if [[ -f "{tfile}" ]]
then
	echo "File exists"
else
	echo "File Does not exist"
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
	


	esac
}