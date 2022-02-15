#!/bin/bash

global=global.json
data=$1

output_name=$(basename -s .json $data).tex

java -jar ~/prgms/TimeSheetGenerator/target/TimeSheetGenerator*-jar-with-dependencies.jar --file $global $data $output_name

latexmk -pdf $output_name

latexmk -c

rm $output_name
