#!/bin/bash

RUNUMBER=`ldapsearch -LLL -xb 'dc=intranet,dc=highprophil,dc=com' '(objectClass=posixaccount)' | awk '/uidNumber/ { print $2 | "sort -nk2"}' | awk 'END{print}'`
#RUNUMBER=`cat UNUMBER.txt`
TNUMBER=$((RUNUMBER + 1))

echo -e "Please enter the username: \c "
read LNAME

PS3='Please enter your choice: '
options=("Accounting" "Admin" "Graphics" "HRD" "IT" "Logistics" "Planning" "Sampling" "Stocks" "User" "Production" "Plating")
select opt in "${options[@]}"
do
    case $opt in
        "Accounting")
            GNUMBER=20000
	    OGROUP=accounting
	    break
            ;;
        "Admin")
            GNUMBER=20001
	    OGROUP=admin
            break
            ;;
        "Graphics")
            GNUMBER=20002
	    OGROUP=graphics
            break
            ;;
	"HRD")
            GNUMBER=20003
	    OGROUP=hrd
            break
            ;;
	"IT")
            GNUMBER=20004
	    OGROUP=it
            break
            ;;
	"Logistics")
            GNUMBER=20005
	    OGROUP=logistics
            break
            ;;
	"Planning")
            GNUMBER=20006
	    OGROUP=planning
            break
            ;;
	"Sampling")
            GNUMBER=20007
	    OGROUP=sampling
            break
            ;;
	"Stocks")
            GNUMBER=20008
	    OGROUP=stocks
            break
            ;;
	"User")
            GNUMBER=20009
	    OGROUP=user
            break
            ;;
	"Production")
            GNUMBER=20010
            OGROUP=production
            break
            ;;
	"Plating")
            GNUMBER=20011
	    OGROUP=plating
            break
            ;;
        *) echo invalid option;;
    esac
done

echo "dn: uid=$LNAME,ou=users,dc=intranet,dc=highprophil,dc=com
uid: $LNAME
objectClass: top
objectClass: posixAccount
objectClass: shadowAccount
objectClass: inetOrgPerson
cn: $LNAME
sn: $LNAME
uidNumber: $TNUMBER
gidNumber: $GNUMBER
homeDirectory: /afs/intranet.highprophil.com/HOME/$LNAME
loginShell: /bin/bash
gecos: $LNAME" > LADD.txt

ldapadd -f LADD.txt
ldappasswd uid=$LNAME,ou=users,dc=intranet,dc=highprophil,dc=com -s xwd12345

pts createuser $LNAME
pts adduser $LNAME $OGROUP 
mkdir /afs/intranet.highprophil.com/HOME/$LNAME
fs sa /afs/intranet.highprophil.com/HOME/$LNAME $LNAME all
fs sa /afs/intranet.highprophil.com/HOME/$LNAME system:anyuser none

echo "dn: cn=$OGROUP,ou=groups,dc=intranet,dc=highprophil,dc=com
changetype: modify
add: memberUid
memberUid: uid=$LNAME,ou=users,dc=intranet,dc=highprophil,dc=com" > ldapmodify.ldif

ldapmodify -f ldapmodify.ldif
#pts membership $LNAME | awk '/id:/{print int($4)}' > UNUMBER.txt
pts membership $LNAME

