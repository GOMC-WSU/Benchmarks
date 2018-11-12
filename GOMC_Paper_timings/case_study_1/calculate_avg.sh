#!/bin/bash

awk -v start_ln=$2 -v column=$3 \
'BEGIN {n=0; sum=0; std_dev=0} 
NR>start_ln { 
	sum+=$column/8;
	result[n]=$column/8; 
	n++;
} 
END { 
	avg=sum/n;
	sum=0;
	for(x=0;x<n;x++){
		sum+=((result[x]-avg)^2)
	};
	std_dev=sqrt(sum/n); 
	print "avg= " avg"  std_dev= "std_dev 
}' $1
