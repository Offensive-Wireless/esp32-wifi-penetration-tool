#!/bin/bash

if [ -z "$1" ] ; then
    echo "Missing argument - filename!"
    exit 1
fi

output_name=$(echo "$1" | sed 's/.html//')
output_filename="page_${output_name}.h"

echo """#ifndef PAGE_${output_name^^}_H
#define PAGE_${output_name^^}_H

const char page_${output_name,,}[] =""" > $output_filename


cat $1 | sed 's/\\/\\\\/' | sed 's/http:\/\/192.168.4.1\///' | sed 's/"/\\"/g' | sed 's/ */&"/' | sed 's/$/\\n"&/' >> $output_filename

echo """
;
#endif
""" >> $output_filename

pages_location="../pages"
echo "Copying $output_filename to $pages_location/$output_filename"
cp $output_filename $pages_location/$output_filename