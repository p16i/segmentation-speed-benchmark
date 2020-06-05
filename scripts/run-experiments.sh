#!/bin/bash

RUNS=$TOTAL
METHODS="$METHOD"

rm -rf .result*

for d in "$@"
do
    for m in $METHODS
    do
        for i in `seq 1 $RUNS`
        do
            slug="$d-$m-$i"
            echo "Running $slug"
            time python3 "./scripts/$m" $d > .result-$slug
            echo "sleep" && sleep 2
        done
    done
done