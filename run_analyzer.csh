#!/bin/csh

echo "fit jobs" | mail -s "lauching the job ${1}" hbrun@cern.ch
set LOCALDIR = `pwd`
setenv WORKINGDIR /afs/cern.ch/user/h/hbrun/CMSSW_7_2_X_2014-07-29-1400_standard/src/
setenv SCRAM_ARCH slc6_amd64_gcc481
#setenv CONF_FILE runRECO_$1.py
setenv LOCAL_PATH runDQM
setenv OUTDIR /store/user/hbrun/dqmTests/720_30julyBuild_std
cd $WORKINGDIR
cmsenv
cd $LOCAL_PATH 
cp recoAndValidation${1}.py $LOCALDIR
cd $LOCALDIR
ls 
cmsRun recoAndValidation${1}.py

echo "bon ben c finin : on list le directory now ! " 
ls 
sleep 120
cmsStage  /tmp/hbrun/dqmFile_${1}.root $OUTDIR

