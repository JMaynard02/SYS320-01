#! /bin/bash
clear

# filling courses.txt
bash courses.bash

courseFile="courses.txt"

function displayCoursesofInst(){

echo -n "Please Input an Instructor Full Name: "
read instName

echo ""
echo "Courses of $instName :"
cat "$courseFile" | grep "$instName" | cut -d';' -f1,2 | \
sed 's/;/ | /g'
echo ""

}

function courseCountofInsts(){

echo ""
echo "Course-Instructor Distribution"
cat "$courseFile" | cut -d';' -f7 | \
grep -v "/" | grep -v "\.\.\." | \
sort -n | uniq -c | sort -n -r 
echo ""

}

# TODO - 1
# Make a function that displays all the courses in given location
# function dislaplays course code, course name, course days, time, instructor
# Add function to the menu
# Example input: JOYC 310
# Example output: See the screenshots in canvas
function coursesOfRoom() {
	echo -n "Please Input Classroom Name (i.e. JOYC 100): "
	read roomName

	echo ""
	echo "Courses in $roomName : "
	cat "$courseFile" | grep "$roomName" | cut -d";" \
	-f1,2,5,6,7 | sed 's/;/ | /g'
	echo ""
}

# TODO - 2
# Make a function that displays all the courses that has availability
# (seat number will be more than 0) for the given course code
# Add function to the menu
# Example input: SEC
# Example output: See the screenshots in canvas
function availableCourses() {
	echo -n "Please Input a Subject Name (i.e. SEC): "
	read subName

	echo ""
	echo "Available courses in $subName : "
	results=$(cat "$courseFile" | grep "$subName")
	echo "$results" | while read -r line;
	do 
		num=$(echo "$line" | cut -d';' -f4)
		if [ "$num" -gt 0 ]
			then 
				echo "$line" | sed 's/;/ | /g' 
		fi
	done
	echo ""
}


while :
do
	echo ""
	echo "Please select and option:"
	echo "[1] Display courses of an instructor"
	echo "[2] Display course count of instructors"
	echo "[3] Display courses of a classroom"
	echo "[4] Display available courses of subject"
	echo "[5] Exit"

	read userInput
	echo ""

	if [[ "$userInput" == "5" ]]; then
		echo "Goodbye"
		break

	elif [[ "$userInput" == "1" ]]; then
		displayCoursesofInst

	elif [[ "$userInput" == "2" ]]; then
		courseCountofInsts

	elif [[ "$userInput" == "3" ]]; then
		coursesOfRoom

	elif [[ "$userInput" == "4" ]]; then
		availableCourses

	# TODO - 3 Display a message, if an invalid input is given
	else
		echo "Invalid response. Please input a number between 1-5"

	fi
done
