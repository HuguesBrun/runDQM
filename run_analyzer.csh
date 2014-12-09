#!/bin/csh

echo "HLT" | mail -s "lauching the job ${1}" hbrun@cern.ch
set LOCALDIR = `pwd`
setenv WORKINGDIR /afs/cern.ch/user/h/hbrun/CMSSW_7_3_0_pre3_testPR/src/
setenv SCRAM_ARCH slc6_amd64_gcc491 
#setenv CONF_FILE runRECO_$1.py
setenv LOCAL_PATH runDQM
setenv OUTDIR /store/group/phys_muon/hbrun/HLTL3recoTests/oldL3
cd $WORKINGDIR
cmsenv
cd $LOCAL_PATH 
cp hlt_RelValZMM_13_${1}.py $LOCALDIR
cp recoValidation_RAW2DIGI_RECO_VALIDATION_DQM.py $LOCALDIR
cd $LOCALDIR
ls 
cmsRun hlt_RelValZMM_13_${1}.py
echo "first step end"
sleep 120
echo "RECODQM" | mail -s "lauching the job ${1}" hbrun@cern.ch
cmsRun recoValidation_RAW2DIGI_RECO_VALIDATION_DQM.py ${1}
echo "bon ben c finin : on list le directory now ! " 
ls 
sleep 120
cmsStage  /tmp/hbrun/recoValidation_RAW2DIGI_RECO_VALIDATION_DQM_inDQM_${1}.root $OUTDIR

