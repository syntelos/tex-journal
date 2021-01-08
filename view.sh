#!/bin/bash

file_dvi=$(./current.sh dvi $* )

file_png=$(./current.sh png $* )

file_txt=$(./current.sh txt $* )


if [ -f "${file_dvi}" ]
then
    xdvi ${file_dvi} &

elif [ -f "${file_png}" ]
then
    eog ${file_png} &

elif [ -f "${file_txt}" ]
then
    cat -n ${file_txt}

elif [ -f "${file_tex}" ]
then
    cat -n ${file_tex}

else
    cat<<EOF>&2
$0: file {dvi,png,txt} not found.
EOF
    exit 1
fi

exit 0
