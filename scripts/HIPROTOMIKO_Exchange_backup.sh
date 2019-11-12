#!/bin/bash


while true; do
  ps aux | grep -qe "rsync$"
  # if not found - equals to 1, start it
  if [ $? -eq 1 ]; then

        echo "Rsync is not running. Will (re)start it now..."

        echo kzion8080 | kinit -f sysadmin
        aklog
	
	/usr/bin/rsync -avubrz --timeout=30 --delete-before --delete --force --ignore-errors --progress --partial -e 'ssh -p 2208' /afs/intranet.highprophil.com/Ex-Change/ konplott-cebu-design.dyndns.org:/afs/intranet.highprophil.com/Ex-Change/

else
    echo "Rsync still running... everything ok."
  fi
  sleep 10
done

