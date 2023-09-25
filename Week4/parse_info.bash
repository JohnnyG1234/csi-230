#check if info file exists, if not exit

tfile="targeted_threats.csv"
if [[ -f "{tfile}" ]]
then
	echo "File exists"
else
	echo "File Does not exist"
fi
