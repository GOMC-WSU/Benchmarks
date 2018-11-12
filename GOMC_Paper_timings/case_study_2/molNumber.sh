#!/bin/bash

BASE_DIR=$( pwd )
#PVT_DIR=${BASE_DIR}/pvt

AvgColInFl()
{
    awk -v start_ln=$2 -v column=$3 \
	'BEGIN {n=0; sum=0; std_dev=0} NR>start_ln { sum+=$column; result[n]=$column; n++}
	    END { avg=sum/n; sum=0; for(x=0;x<n;x++){ sum+=((result[x]-avg)^2)}; std_dev=sqrt(sum/n); print avg "  " std_dev}' $1
}

RUN=$( echo run*|tr ' ' '\n' )

for d in $RUN; do
    WORK_DIR=${BASE_DIR}/${d}
    cd  ${WORK_DIR}
    echo "Working in directory:  ${WORK_DIR}"
    N_List=( $( cat Blk*.dat | sed -e '/^$/d' | grep -v '^#' | grep -v '^S' | awk '{print $10}' ) )
    X_List=( $( cat Blk*.dat | sed -e '/^$/d' | grep -v '^#' | grep -v '^S' | awk '{print $19}' ) )
    for ((p=0; p < ${#N_List[@]}; ++p)); do
	N=$( echo "scaled=3; (${N_List[$p]} * ${X_List[$p]})"|bc -l)
	printf "%3.3f\n" "${N}" >> MOL_results.dat
    done
done


echo "Printing average mol Box-1:"

for d in $RUN; do
    WORK_DIR=${BASE_DIR}/${d}
    cd  ${WORK_DIR}
    echo $( AvgColInFl MOL_results.dat  150 1 )
done
