#!/bin/bash

gen_ps=false
gen_pdf=false
gen_png=true

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
  
  
Synopsis

  ${0} --last

Description

  Overwrite the last target.  Reports 'U' for write, and 'X' for
  error.

EOF

    exit 1
}
function cache_test {

    [ ! -f ${tgt_dvi} ]||[ $src -nt ${tgt_dvi} ]||[ preamble.tex -nt ${tgt_dvi} ]
}
function overwrite {

    if tex ${src}
    then
	git add ${tgt_dvi}

	if ${gen_ps} && dvips ${tgt_dvi}
	then
	    git add ${tgt_ps}

	    if ${gen_pdf} && ps2pdf ${tgt_ps} 
	    then
		git add ${tgt_pdf}
	    fi
	fi

	if ${gen_png} && dvipng -T bbox -o ${tgt_png} ${tgt_dvi}
	then
	    git add ${tgt_png}
	fi

	return 0
    else
	return 1
    fi
}
function list {

    for src in $(ls journal-*.tex )
    do
	
	name=$(basename $src .tex)

	tgt_png=${name}.png
	tgt_pdf=${name}.pdf
	tgt_ps=${name}.ps
	tgt_dvi=${name}.dvi

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

	tgt_png=${name}.png
	tgt_pdf=${name}.pdf
	tgt_ps=${name}.ps
	tgt_dvi=${name}.dvi

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
function last {

    src=$(ls journal-*.tex | tail -n 1 )

    name=$(basename $src .tex)

    tgt_png=${name}.png
    tgt_pdf=${name}.pdf
    tgt_ps=${name}.ps
    tgt_dvi=${name}.dvi

    if overwrite
    then

	echo "U ${name}"
    else

	echo "X ${name}"
	break
    fi
}


#
#
case "${1}" in
    --list)
	list
	;;

    --last)
	last
	;;

    --update)
	update
	;;

    *)
	usage
	;;
esac
