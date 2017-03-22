#!/bin/bash

file_pdf=$(./file.sh $* pdf | egrep '\.pdf$' )

file_png=$(./file.sh $* png | egrep '\.png$' )

file_dvi=$(./file.sh $* dvi | egrep '\.dvi$' )

file_txt=$(./file.sh $* txt | egrep '\.txt$' )


if [ -f "${file_png}" ]
then
    eog ${file_png} &
else

    if [ -f "${file_pdf}" ]
    then
	2>/dev/null 1>/dev/null evince ${file_pdf} &
    else

	if [ -f "${file_txt}" ]
	then
	    cat -n ${file_txt}
	else
	    if [ -f "${file_dvi}" ]
	    then
		xdvi ${file_dvi}  &
	    else
		cat<<EOF>&2
$0: file {pdf,png,dvi,txt} not found.
EOF
		exit 1
	    fi
	fi
    fi
fi

exit 0
