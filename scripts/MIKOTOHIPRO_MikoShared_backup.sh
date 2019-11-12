#!/bin/bash


while true; do
  ps aux | grep -qe "rsync$"
  # if not found - equals to 1, start it
  if [ $? -eq 1 ]; then

	echo "Rsync is not running. Will (re)start it now..."
        ssh root@58.69.151.56 -p 2208 'echo kzion8080 | kinit -f sysadmin; aklog'	
	echo kzion8080 | kinit -f sysadmin
	aklog

	/usr/bin/rsync  -avrz  --timeout=120 --delete-before --delete --force --ignore-errors --progress --partial  -e 'ssh -p 2208' /afs/intranet.highprophil.com/MIKO_SHARED/ 58.69.151.56:/afs/intranet.highprophil.com/MIKO_SHARED/
  
else
    echo "Rsync still running... everything ok."
  fi
  sleep 10
done
