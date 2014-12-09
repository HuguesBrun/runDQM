#!/bin/csh

set counter=40

while ($counter<60)
	echo "send job "$counter
         bsub -q 1nd run_analyzer.csh $counter
	@ counter++
        sleep 5 
end
