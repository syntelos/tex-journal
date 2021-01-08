#!/bin/bash


if file_png=$(./current.sh png $* ) &&[ -n "${file_png}" ]&&[ -f "${file_png}" ]
then

    gimp ${file_png}  &

    exit 0

elif file_tex=$(./current.sh tex $* ) &&[ -n "${file_tex}" ]&&[ -f "${file_tex}" ]
then

    emacs ${file_tex}  &

    exit 0
else
    cat<<EOF>&2
$0: file not found.
EOF
    exit 1
fi

