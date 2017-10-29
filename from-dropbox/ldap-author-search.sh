#!/bin/bash

user=$1
tmpfile=/tmp/ldapsearch$$.txt

ldapsearch -x -y $HOME/ldap.bin mailNickname=${user}* mail cn > $tmpfile

mail=$(grep -e "^mail:" $tmpfile | cut -d' ' -f 2 | head -n 1)
fullname=$(grep -e "^cn:" $tmpfile | cut -d' ' -f 2- | head -n 1)

echo "${fullname} <${mail}>"
rm -f $tmpfile
