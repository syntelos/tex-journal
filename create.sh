#!/bin/bash

yyyymmdd=$(yyyymmdd)
file=journal-${yyyymmdd}.tex
index=0

while [ -f ${file} ]
do
    index=$(( ${index} + 1 ))
    file=journal-${yyyymmdd}-${index}.tex
done

cat<<EOF>${file}
\input preamble



\bye
EOF

git add ${file}
emacs ${file} &
