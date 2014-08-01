#!/bin/csh

echo "fit jobs" | mail -s "lauching the job ${1}" hbrun@cern.ch
set LOCALDIR = `pwd`
setenv WORKINGDIR /afs/cern.ch/user/h/hbrun/CMSSW_7_2_X_2014-07-29-1400_standard/src/
setenv SCRAM_ARCH slc6_amd64_gcc481
#setenv CONF_FILE runRECO_$1.py
setenv LOCAL_PATH runDQM/harvesting
setenv OUTDIR /afs/cern.ch/work/h/hbrun/webBackUp/testForPre4
cd $WORKINGDIR
cmsenv
cd $LOCAL_PATH 
cp  harvesting_${1}.py $LOCALDIR
cd $LOCALDIR
ls 
cmsRun  harvesting_${1}.py

echo "bon ben c finin : on list le directory now ! " 
ls 
sleep 120
cp DQM_V0001_R000000001__Global__CMSSW_X_Y_Z__RECO.root $OUTDIR/DQM_V0001_R000000001__${1}__CMSSW_7_2_0_pre3__RECO.root

