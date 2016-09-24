#!/bin/bash

file=$(ls journal-*.txt | tail -n 1)

if [ -n "${file}" ]&&[ -f "${file}" ]
then
    if [ -n "${1}" ]
    then
	fext="${1}"
	base=$(basename ${file} ".txt" )

	if [ -n "$(echo "${fext}" | egrep '^\.')" ]
	then
	    file="${base}${fext}"
	else
	    file="${base}.${fext}"
	fi
    fi
    echo "${file}"
    exit 0

else
    file=$(ls journal-*.tex | tail -n 1)

    if [ -n "${file}" ]&&[ -f "${file}" ]
    then
	if [ -n "${1}" ]
	then
	    fext="${1}"
	    base=$(basename ${file} ".tex" )

	    if [ -n "$(echo "${fext}" | egrep '^\.')" ]
	    then
		file="${base}${fext}"
	    else
		file="${base}.${fext}"
	    fi
	fi
	echo "${file}"
	exit 0
    else
	cat<<EOF>&2
$0: file not found.
EOF
	exit 1
    fi
fi
