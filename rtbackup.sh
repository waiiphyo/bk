#!/bin/bash
source /nfs/backup/RT-Backup/rtbackup-script/rtvars
source /nfs/backup/RT-Backup/rtbackup-script/libs

count=${#servers[@]};
if [ $count -ge 1 ]; then
	echo "`date` Backup started."
	printf '=%.s' {1..70} 
	echo
	for (( i=0; i<${count}; i++ ));
	do
	if ${isbk[$i]}; then
        	if checkHost ${servers[$i]}; then
			echo -en "[`date`]\tBackup ${servers[$i]} ?: ${isbk[$i]}\n";
	                if ${isdb[$i]}; then
        	                echo -en "[`date`]\tDatabase to backup: ${db[$i]}\n";
                	fi
			#echo ${lists[$i]}
                	if processBackupList $i; then
                	        echo -en "[`date`]\tBackup successfully done for ${servers[$i]}.\n";
                	else
                	        echo -en "[`date`]\tError occur when backing up ${servers[$i]}.\n"
                	fi
			printf '+%.s' {1..70} 
			echo
       		else
                	echo -en "[`date`]\t${servers[$i]} is not reachable by ping.\n";
		fi
       	fi
	done
	echo "`date` All Backup completed."
	printf '=%.s' {1..70} 
	echo
else
	echo "Server Array is empty."
fi
