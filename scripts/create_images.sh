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
wkhtmltoimage -f png --user-style-sheet slides.css --minimum-font-size 18 --enable-local-file-access --height 990 --width 1760 --enable-javascript --javascript-delay 5000 "${htmldoc}#(${i})" "${output}.${numero}.png"
done
