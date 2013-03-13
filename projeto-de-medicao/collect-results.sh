#!/bin/bash

if [ $# != 1 ] ; then
    echo "Usage: $0 <number-of-cpus>"
    exit 1
fi

number_of_cpus=$1
collection_file="results.txt"

echo "encoder resolution frames motion repetition.number cpu.usage mem.peak output.size start.time end.time" > $collection_file

for i in experiments/* ; do
    Rscript analize.R $i/raw-cpu-and-memory-log.txt $number_of_cpus > $i/cpu-and-memory-log.txt
    cat $i/factors.txt $i/{cpu-and-memory,output-size,time}-log.txt | paste -d ' ' - - - - >> $collection_file
done

