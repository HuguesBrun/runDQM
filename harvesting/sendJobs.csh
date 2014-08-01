#!/bin/csh

set list=`cat theSendList`

foreach i ($list)
	echo $i
	bsub -q 1nh run_analyzerHarvest.csh $i

end


