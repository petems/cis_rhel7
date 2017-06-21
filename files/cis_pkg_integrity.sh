#!/bin/sh
# CIS RHEL7 Benchmark
# Rule 1.2.6


PKG=`rpm -qVa | awk '$2 != "c" { print $0}'`


if [[ $PKG ]] 
then	
	echo $PKG
fi

