#!/bin/bash
#

function usage {
    cat<<EOF>&2
Synopsis

  $0 

Description

  Print current file date and item for file name extension 'tex'.

Synopsis

  $0  [a-z][a-z][a-z]

Description

  Print current file date and item for file name extension '\$1'.


Synopsis

  $0 %[di][+-]N

Description

  Delta arithmetic over current file date (%d-1) or item (%i+1) for
  single digit N.


Synopsis

  $0 %[s]S

Description

  Optional file name substring.


EOF
    return 1
}

#
#
fext=tex
del_date=0
del_item=0
substring=''

#
#
while [ -n "${1}" ]
do
    case "${1}" in

	%d[+-][0-9])
	    exp="0 $(echo ${1} | sed 's/%d//; s/./& /;')"

	    del_date=$(( ${exp} ))

	    del_date="$(echo ${del_date} | sed 's/./& /; s/^ //; s/ $//; s/^[0-9]/+ &/;')"
	    ;;

	%i[+-][0-9])
	    exp="0 $(echo ${1} | sed 's/%i//; s/./& /;')"

	    del_item=$(( ${exp} ))

	    del_item="$(echo ${del_item} | sed 's/./& /; s/^ //; s/ $//; s/^[0-9]/+ &/;')"
	    ;;

	%s*)
	    substring=$(echo "${1}" | sed 's^%s^^')
	    ;;

	[+-]*)
	    usage 
	    ;;

	[a-z][a-z][a-z])
	    fext="${1}"
	    ;;
	\*)
	    fext="${1}"
	    ;;
	*)
	    usage
	    ;;
    esac
    shift
done

#
#set -x
#
file=$(ls journal-*.{tex,txt} | sort -V | egrep -ve '[0-9][0-9][0-9][0-9][0-9][0-9]-[0-9]-[a-zA-Z]' | tail -n 1 )

if [ -n "${file}" ]&&[ -f "${file}" ]
then

    digits=$(echo ${file} | sed 's%journal-%%; s%\.txt$%%; s%\.tex$%%;' )

    if [ "0" != "${del_date}" ] || [ "0" != "${del_item}" ]
    then
	base_date=$(echo "${digits}" | sed 's%-.$%%;')

	base_item=$(echo "${digits}" | sed "s%${base_date}%%; s%-%%;")

	if [ "0" != "${del_item}" ]
	then
	    base_item=$(( ${base_item} ${del_item} ))
	fi

	if [ "0" != "${del_date}" ]
	then
	    base_date=$(( ${base_date} ${del_date} ))
	fi

	base="journal-${base_date}-${base_item}"
    else
	base="journal-${digits}"
    fi


    if [ -n "${substring}" ]
    then
	file="${base}-${substring}.${fext}"
    else
	file="${base}.${fext}"
    fi

    echo "${file}"

    exit 0

else

    cat<<EOF>&2
$0: file not found.
EOF
    exit 1
fi
