#! /bin/bash

link="10.0.17.6/Assignment.html"
outputFile="output.txt"

fullPage=$(curl -sL "$link")

toolOutput=$(echo "$fullPage" | \
xmlstarlet format --html --recover 2>/dev/null | \
xmlstarlet select --template --copy-of \
"//html//body//table//tr")

echo "$toolOutput" | grep -v "th>" | tr -d '\n' | \
	sed 's/<\/tr>/\n/g' | \
	sed -e 's/&amp;//g' | \
	sed -e 's/<tr>//g' | \
	sed -e 's/<td[^>]*>//g' | \
	sed -e 's/<\/td>/;/g' | \
	sed -e 's/<[/\]\{0,1\}a[^>]*>//g' | \
	sed -e 's/<[/\]\{0,1\}nobr>//g' | \
	sed -e 's/&#13;//g' \
	 > "$outputFile"

line_count=$(wc -l < "$outputFile")
midpoint=$((line_count / 2))
startpoint=$((midpoint + 1))
firstHalf=$(head -n "$midpoint" "$outputFile")
echo "$firstHalf" | cut -d';' -f1 > "first_half.txt"
secondHalf=$(tail -n +"$startpoint" "$outputFile")
echo "$secondHalf" | cut -d';' -f1,2 | tr -d ';' > "second_half.txt"

paste -d '' "first_half.txt" "second_half.txt" | \
 sed 's/^[[:space:]]*//'
