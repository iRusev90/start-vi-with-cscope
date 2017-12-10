#!/bin/bash

finalCommand="rm -f cscope.*;find . \\("

if [ $# -eq 0 ]; then 
    echo You must provide at least 1 file type. Ex: \"viscope js html\"
    exit
fi

argumentInteration=0
for fileType in "$@"
do
    argumentInteration=$(($argumentInteration + 1))
    findSearchParam=" -name \"*."$fileType"\""

    if [ $argumentInteration -lt $# ]; then
        findSearchParam=$findSearchParam" -o"
    fi

    finalCommand=$finalCommand$findSearchParam
done

finalCommand=$finalCommand" \\) > cscope.files; cscope -b;rm -f cscope.files; vi +\"cs add cscope.out\""
echo "$finalCommand"
eval "$finalCommand"

