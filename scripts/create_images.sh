#!/usr/bin/env bash

while getopts “:h:o:s:” opt; do
  case "${opt}" in
    h) html=${OPTARG} ;;
    o) output=${OPTARG} ;;
		s) script=${OPTARG} ;;

  esac
done

echo $output;
directory=`pwd`
htmldoc="file://"${directory}'/'${html}
strcount=`wc -l ${script}`

count=($(echo $strcount | tr -s " " " "))



for i in $(seq 1 1 $count) ;
do
numero=`printf "%03d" $i`
wkhtmltoimage -f png --height 990 --width 1760 "${htmldoc}#(${i})" "${output}.${numero}.png"
done
