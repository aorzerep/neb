#!/bin/bash

echo kzion8080 | kinit -f sysadmin
aklog

find /incremental_backup/daily/ -noleaf -ctime 7 -type f -exec rm -rf {} \;

find /afs/intranet.highprophil.com -noleaf -not -path '*/\.*' -mtime -1  -type f -print | tar -cpzf "/incremental_backup/daily/`date +%m%d%Y`.tar.gz" -T-

kdestroy
unlog
exit 0

