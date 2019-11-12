#!/bin/bash

echo kzion8080 | kinit -f sysadmin
aklog

find /incremental_backup/weekly/ -noleaf -ctime 14 -type f -exec rm -rf {} \;

find /afs/intranet.highprophil.com -noleaf -not -path '*/\.*' -mtime -7  -type f -print | tar -cpzf "/incremental_backup/weekly/`date +%m%d%Y`.tar.gz" -T-

kdestroy
unlog
exit 0
