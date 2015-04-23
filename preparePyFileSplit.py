import os
import sys
import optparse
import re
import commands
import das_client
import json

nbJobs=2
eventPerJobs=500

def listFichier(theRelease, theSample, dataTier, tag):
	theQuery = "file dataset=/"+theSample+"*/"+theRelease+"-"+tag+"*/"+dataTier
	jsondict = das_client.get_data('https://cmsweb.cern.ch', theQuery, 0, 0, False)
	status = jsondict['status']
	if status != 'ok':
		print "DAS query status: %s"%(status)
	data = jsondict['data']
	theFileList = []
	for aRaw in data:
		recordStuff = aRaw['file']
   		for aRecord in recordStuff:
        		print "theFile===",aRecord['name']
        		theFileList.append(aRecord['name'])
   	return theFileList



print "inPYthon"

#listFichier('CMSSW_7_1_0_pre5','RelValZMM')

file = open("listSample","r")
jobs = file.readlines()
file.close()

file = open("DIGIUP15.py","r")
scriptLine = file.readlines()
file.close()

sizeList = len(jobs)
listIterator = 2



if (sizeList<3):
    print "size list too small"

sampleRelease = jobs[0][:-1]
sampleTag = jobs[1][:-1]
while (listIterator<sizeList):
    theJob = jobs[listIterator][:-1]
    print "will do ",theJob
    listIterator = listIterator+1
    iteFile = 0
    theFileList = listFichier(sampleRelease, theJob, "GEN-SIM-DIGI-RAW-HLTDEBUG",sampleTag)
    for file in theFileList:
        print "taille=",len(theFileList)
        iteSplit = 0
        while (iteSplit<nbJobs):
            iteFile=iteFile+1
            iteSplit = iteSplit+1
            outFile = open("recoAndValidation"+theJob+"_"+str(iteFile)+".py","w")
            for line in scriptLine:
                print line
                prevLine = ""
                if (scriptLine.index(line)>0):
                    prevLine=scriptLine[scriptLine.index(line)-1]
                if len(re.split("theRAWfiles",line))> 1:
                    outFile.write("'"+file+"',\n")
                    continue
                if len(re.split("step2",line))> 1:
                    outFile.write("fileName = cms.untracked.string('/tmp/hbrun/step2file_"+theJob+"_"+str(iteFile)+".root'),\n")
                    continue
                if len(re.split("secondaryFileNames",line))> 1:
                    outFile.write("skipEvents=cms.untracked.uint32("+str((iteSplit-1)*eventPerJobs)+"),\n")
                    outFile.write(line)
                    continue
                if len(re.split("maxEvents",prevLine))> 1:
                    outFile.write("input = cms.untracked.int32("+str(eventPerJobs)+")\n")
                    continue
                outFile.write(line)









