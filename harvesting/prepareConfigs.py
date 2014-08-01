import os
import re

file = open("listSample","r")
jobs = file.readlines()
file.close()

file = open("step4_HARVESTING.py","r")
scriptLine = file.readlines()
file.close()

#f = os.system('ls ..')


for job in jobs:
	outFile = open("harvesting_"+job[:-1]+".py","w")
	for line in scriptLine:
		if len(re.split("theDQMfile",line))> 1:
			file = open(job[:-1]+".list","r")
			theFiles = file.readlines()
			file.close()
			for aFile in theFiles:
				outFile.write("'"+aFile[:-1]+"',\n")
			continue
		outFile.write(line)


