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

  $0 [+-]N

Description

  Basic arithmetic over current file item.

EOF
    return 1
}

fext=tex
del=0

#
#
while [ -n "${1}" ]
do
    case "${1}" in
	[+-]*)
	    exp="$del $(echo ${1} | sed 's/./& /')"

	    del=$(( ${exp} ))

	    del_exp="$(echo ${del} | sed 's/./& /; s/^ //; s/ $//;')"
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
#
file=$(ls journal-*.{tex,txt} | tail -n 1)

if [ -n "${file}" ]&&[ -f "${file}" ]
then

    base=$(echo ${file} | sed 's%\.txt$%%; s%\.tex$%%;' )

    if [ 0 -ne $del ]
    then
	base_date=$(echo $base | sed 's%-.$%%; ')

	base_item=$(echo $base | sed "s%${base_date}%%; s%-%%;")

	base_item=$(( ${base_item} ${del_exp} ))

	base=${base_date}-${base_item}
    fi


    file="${base}.${fext}"

    echo "${file}"

    exit 0

else

    cat<<EOF>&2
$0: file not found.
EOF
    exit 1
fi
