#!/bin/bash
logs="*.bak *.aux *.log *.bbl *.blg *.toc *.lot *.lof *.out *.idx *.ilg *.ind *.brf *.backup"
swaps="*% *~ .*~ .*%"

clean() {
	for extensio in $logs; do
 		rm -f $extensio
	done
	for extensio in $swaps; do
		rm -f $extensio
	done
	
	if [ "$(ls -l | grep ^d)" != "" ]; then
		ls -1d */ | while read DIR; do
		 	cd "$DIR"
			echo "$DIR"
			clean
			cd ..
		done
	fi
}

clean
