#!/bin/bash

function usage {

    cat<<EOF>&2

Synopsis

  ${0} --list

Description

  List targets for sources as present (U) or missing (N).
  
  
Synopsis

  ${0} --update

Description

  Write missing or stale targets for sources.  Reports 'U' for write,
  'S' for skip, and 'X' for error.

EOF

    exit 1
}
function cache_test {

    [ ! -f ${tgt2} ]||[ $src -nt ${tgt2} ]||[ preamble.tex -nt ${tgt2} ]
}
function overwrite {

    tex ${src} && dvips ${tgt0} && ps2pdf ${tgt1}

    git add ${tgt0} ${tgt1} ${tgt2}
}
function list {

    for src in $(ls journal-*.tex )
    do
	
	name=$(basename $src .tex)

	tgt2=${name}.pdf
	tgt1=${name}.ps
	tgt0=${name}.dvi

	if cache_test
	then

	    echo "U ${name}"

	else

	    echo "N ${name}"
	fi
    done
}
function update {

    for src in $(ls journal-*.tex )
    do
	
	name=$(basename $src .tex)

	tgt2=${name}.pdf
	tgt1=${name}.ps
	tgt0=${name}.dvi

	if cache_test
	then

	    if overwrite
	    then

		echo "U ${name}"
	    else

		echo "X ${name}"
		break
	    fi
	else

	    echo "S ${name}"
	fi
    done
}


#
#
case "${1}" in
    --list)
	list
	;;

    --update)
	update
	;;

    *)
	usage
	;;
esac
