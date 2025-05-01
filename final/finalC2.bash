#! /bin/bash

file="$1"
IOC="$2"

Help(){
echo -e "\n    HELP MENU"
echo "------------------"
echo "Expecting two inputs:"
echo " - Log file"
echo -e " - IOC file\n"
echo "Usage: bash finalC2.bash access.log IOC.txt"
echo "Output will be saved to report.txt"
echo -e "------------------\n"
}

if [ ! ${#} -eq 2 ]; then
	Help
exit;
fi

results=$(cat "$file" | grep -f "$IOC" | cut -d' ' -f1,4,7 | \
 tr -d "[")
echo "$results" > report.txt
