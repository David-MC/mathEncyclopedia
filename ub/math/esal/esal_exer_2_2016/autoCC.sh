#!/bin/bash
if [ $# != 0 ]; then
	doc=./$1 
else
	doc=./document
fi

logs="*.bak *.aux *.log *.bbl *.blg *.toc *.lot *.lof *.out *.idx *.ilg *.ind *.brf *.backup"
swaps="*% *~ .*~ .*%"
rec=true

# Creation
pdflatex $doc".tex"
makeindex $doc".idx"
bibtex $doc
pdflatex $doc".tex"
pdflatex $doc".tex"

# Clean
clean() {
	for extensio in $logs; do
 		rm -f $extensio
	done
	for extensio in $swaps; do
		rm -f $extensio
	done
	
	if [ "$(ls -l | grep ^d)" != "" ] && [ "$rec" = true ]; then
		ls -1d */ | while read DIR; do
		 	cd "$DIR"
			echo "$DIR"
			clean
			cd ..
		done
	fi
}

clean