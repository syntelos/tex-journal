
Structure

  The source is TEX, and the target is a PNG or PDF.

  Old years get sorted into archive folders so that the current year
  is in the working directory with the shell scripts.

Dependencies

  https://github.com/syntelos/home/

Tool scripts

  clean.sh                Drop git orphans from the filesystem

  create.sh               Create a new TEX source file to write

  dig.sh                  Strip the alpha prefix and fext from FLIST

  edit.sh                 Open FILE

  file.sh                 Identify FILE

  flist.sh                List FILE

  import.sh               Transform a source prefix subset to a target prefix subset

  last.sh                 Tail FLIST uniquely

  print.sh                Compile TEX source to ps, pdf, or png

  review.sh               Interactive drop

  search.sh               Page through TEX matching grep

  subtitle.sh             Replace subtitle on FILE

  texf.sh                 FILE TEX

  undo-create.sh          Drop FILE

  view.sh                 Open FILE {dvi|png|txt}

