#!/bin/bash

file_pdf=$(ls journal-*.pdf | tail -n 1 )

file_png=$(ls journal-*.png | tail -n 1 )



if [ "${file_pdf}" ]
then
    evince ${file_pdf}  

else
    cat<<EOF>&2
$0: file "${file_pdf}" not found.
EOF

    if [ "${file_png}" ]
    then
	eog ${file_png}  &
    else
	cat<<EOF>&2
$0: file "${file_png}" not found.
EOF
	exit 1
    fi

    exit 1
fi



