#!/bin/bash

BASE_DIR=`pwd`; 
for d in $( echo */run*/.|tr ' ' '\n'); 
do cd $d; 
    cp ${BASE_DIR}/gcmc*inp .;
    cp ${BASE_DIR}/GOMC_CPU_GCMC .;
    #CORE=$(echo $d | egrep -o "run[0-9]{1}|run[0-9]{2}" | cut -c 4-);
    CORE=1;
    sed -i 's#CCC#'$CORE'#g' gcmc*inp;
    sed -i 's#RUN_DIR#'`pwd`'#g' gcmc*inp; 
    qsub gcmc*inp;
    echo $d;
    sleep 1;
    cd $BASE_DIR;
done
