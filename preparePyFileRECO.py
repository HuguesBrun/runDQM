import os
import sys
import optparse
import re




file = open("listFileRAWHLT","r")
jobs = file.readlines()
file.close()

file = open("RECOUP15.py","r")
scriptLine = file.readlines()
file.close()

iteFile=0


for fileName in jobs:
    nbFileInside = 0
    iteFile=iteFile+1
    print fileName
    theName = re.split("\.",re.split("step2file_",fileName)[1])[0]
    print theName
    outFile = open("runRecoAndValidation_"+theName+".py","w")
    for line in scriptLine:
        print line
        if len(re.split("theRAWfiles",line))> 1:
            outFile.write("'"+fileName[:-1]+"',\n")
            continue
        if len(re.split("step3_inDQM",line))> 1:
            outFile.write("fileName = cms.untracked.string('/tmp/hbrun/step3DQMfile_"+theName+".root'),\n")
            continue
        outFile.write(line)









