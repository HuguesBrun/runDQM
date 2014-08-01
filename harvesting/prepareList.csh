#!/bin/csh

setenv nameEOS `cat ../run_analyzer.csh | grep "setenv OUTDIR" | awk '{ print $3}'`
set theFiles = `cat listSample`

foreach i ($theFiles)
	echo "will create $i"
	set listFile = `cmsLs $nameEOS | grep $i | awk '{ print $5}'`
        set nomFile = `echo "$i.list"`
	foreach j ($listFile)
		echo $j >> $nomFile
	end

end 

