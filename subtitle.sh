#!/bin/bash

if src=$(./file.sh)&& [ -n "${src}" ]&& tgt=$(./file.sh $* )&& [ -n "${tgt}" ]&& [ "${src}" != "${tgt}" ]
then
    read -p "[yN] git mv ${src} ${tgt} ?" -n 1 r_gmv
    case "${r_gmv}" in
         [yY])
              echo git mv "${src}" "${tgt}"
              git mv "${src}" "${tgt}"
              ;;
            *)
              echo skipping
              ;;
    esac
    exit 0
else
  cat<<EOF>&2
Synopsis

  $0 %s<SUBTITLE>

EOF
  exit 1
fi
