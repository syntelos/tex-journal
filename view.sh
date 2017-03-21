#!/bin/bash

file_dvi=$(./file.sh $* dvi)

file_png=$(./file.sh $* txt)

file_txt=$(./file.sh $* txt)


if [ -f "${file_dvi}" ]
then
    xdvi ${file_dvi}  
else

    if [ -f "${file_png}" ]
    then
	eog ${file_png}
    else

	if [ -f "${file_txt}" ]
	then
	    cat -n ${file_txt}
	else
	    cat<<EOF>&2
$0: file {dvi,png,txt} not found.
EOF
	    exit 1
	fi
    fi
fi

exit 0
