#!/bin/sh

TID=0

counter=1
pid=`pgrep $1|sed -n "1p"`
#TID=`ls -l|awk '{print $9}'|sed -n '100p' `



	if [ -z $pid ]
	then
	echo "pid not exist,exit"
	exit
	else
	echo "pid is:"$pid
	fi

TOTAL_LINE=`ls -l /proc/$pid/task|wc -l`
TOTAL_LINE=`expr $TOTAL_LINE + 1`

echo "ls total line is:"$TOTAL_LINE

echo "==========================="

while [ $counter -lt $TOTAL_LINE ]
do
	line=`echo $counter"p"`
	TID=`ls -l /proc/$pid/task|awk '{print $9}'|sed -n $line `

	counter=`expr $counter + 1`
	echo "===counter:   "$counter            "TID is: "$TID
	

	if [ -z $TID ]
	then
	echo "tid is NULL!"
	else
	rm -rf /tmp/lcs_gdb.txt
	echo "attach "$TID >> /tmp/lcs_gdb.txt
	echo "bt" >> /tmp/lcs_gdb.txt
	echo "detach" >> /tmp/lcs_gdb.txt
	echo "quit" >> /tmp/lcs_gdb.txt
	gdb --quiet -x /tmp/lcs_gdb.txt -batch
	fi
echo "==========================="	
done



