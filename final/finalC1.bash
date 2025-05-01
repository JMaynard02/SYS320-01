#! /bin/bash

link="10.0.17.6/IOC.html"
outputFile="IOC.txt"

fullPage=$(curl -sL "$link")

toolOutput=$(echo "$fullPage" | \
xmlstarlet format --html --recover 2>/dev/null | \
xmlstarlet select --template --copy-of \
"//html//body//table//tr")

printf "$toolOutput" | grep -v "th>" | tr -d '\n' | \
	sed 's/<\/tr>/\n/g' | \
	sed -e 's/&amp;//g' | \
	sed -e 's/<tr>//g' | \
	sed -e 's/<td[^>]*>//g' | \
	sed -e 's/<\/td>/;/g' | \
	sed -e 's/<[/\]\{0,1\}a[^>]*>//g' | \
	sed -e 's/<[/\]\{0,1\}nobr>//g' | \
	sed -e 's/&#13;//g' | \
	sed 's/^[ \t]*//' | \
	sed '/^$/d' | \
	cut -d';' -f1 \
	 > "$outputFile"
