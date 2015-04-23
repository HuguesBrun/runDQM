#!/bin/csh

echo "fit jobs" | mail -s "lauching the job ${1}" hbrun@cern.ch
set LOCALDIR = `pwd`
setenv WORKINGDIR /afs/cern.ch/work/h/hbrun/CMSSW_7_4_0_pre9_DQM/src/
setenv SCRAM_ARCH slc6_amd64_gcc491
#setenv CONF_FILE runRECO_$1.py
setenv LOCAL_PATH runDQM
setenv OUTDIR /store/group/phys_muon/hbrun/dqmTests/RAWpixPU
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
cmsStage  /tmp/hbrun/step2file_${1}.root $OUTDIR

