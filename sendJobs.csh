#!/bin/csh

set list=`cat theSendList`

foreach i ($list)
	echo $i
	bsub -q 1nd run_analyzer.csh $i

end


