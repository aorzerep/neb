#!/bin/bash

echo kzion8080 | kinit -f sysadmin
aklog

find /incremental_backup/monthly/ -noleaf -ctime 60 -type f -exec rm -rf {} \;

find /afs/intranet.highprophil.com -noleaf -mtime -30  -type f -print | tar -cpzf "/incremental_backup/monthly/`date +%m%d%Y`.tar.gz" -T-

kdestroy
unlog
exit 0
