#!/bin/bash

backupdir=/nfs/backup/RT-Backup
lastmonth=$(date -d "-1 month" +%Y-%m)
scp -r $backupdir/$lastmonth-* portaladmin@192.168.101.98:/termaxia/sbsbackup/RT-Backup
if [ $? -eq 0 ] 
then
cd $backupdir
rm -r $lastmonth-*
else
	echo $?
fi
