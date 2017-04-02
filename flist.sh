#!/bin/bash
#
prefix=journal


function usage {
    cat<<EOF>&2
Synopsis

  $0 

Description

  List today's files.


Synopsis

  $0  [0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]

Description

  Absolute addressing reference, YYYYMMDD.


EOF
    return 1
}

#
# Preserve S^{*} = { p-D-I.y < p-D.y }
#
function serialize {
    #
    # (RRRRRRRR-R < RRRRRRRR)
    #
    leader=''

    for file in ${flist}
    do
	if [ -n "$(echo $file | egrep '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]-[0-9]' )" ]
	then
	    # RRRRRRRR-R

	    echo ${file}
	else
	    # RRRRRRRR

	    leader=${file}
	fi
    done

    if [ -n "${leader}" ]
    then
	# RRRRRRRR

	echo ${leader}
    fi
    return 0
}

#
#
if ! today=$(yyyymmdd) || [ ! -n "${today}" ]
then
    cat<<EOF>&2
$0 error running 'yyyymmdd' for today's date.
EOF
    exit 1
fi

#
#
ref=${today}

#
#
while [ -n "${1}" ]
do
    case "${1}" in

	[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9])

	    ref="${1}"
	    ;;

	*)
	    usage
	    exit 1
	    ;;
    esac
    shift
done

#
if flist=$(2>/dev/null ls ${prefix}-*.tex | sort -V | egrep -e "${ref}" ) && [ -n "${flist}" ]
then

    serialize ${flist}

elif flist=$(2>/dev/null ls ${prefix}-*.txt | sort -V | egrep -e "${ref}" ) && [ -n "${flist}" ]
then
    serialize ${flist}
else
    cat<<EOF>&2
$0 error listing files in '${ref}'.
EOF
    exit 1
fi

