#! /bin/bash

inputFile="report.txt"
outputFile="/var/www/html/report.html"

echo "<html><body>Access logs with IOC indicators:<table border=\"1\"><br><br>" \
 > "$outputFile"

cat "$inputFile" | while read -r line;
do 
	col1=$(echo "$line" | cut -d' ' -f1)
	col2=$(echo "$line" | cut -d' ' -f2)
	col3=$(echo "$line" | cut -d' ' -f3)
	echo "<tr><td>$col1</td><td>$col2</td><td>$col3</td></tr>" \
	 >> "$outputFile"
done

echo "</table></body></html>" >> "$outputFile"
