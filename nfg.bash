#!/bin/bash

while getopts n:d: opt
do
    case $opt in
        "n") # number of folders
            if [[ -n `echo -n $OPTARG | sed 's/[0-9]//g'` || $OPTARG < 1 ]]; then
                echo "number of folders must be positive number." >&2
                exit 1
            fi
            opt_n=true
            opt_n_value=$OPTARG
            ;;
        "d") # output dir
            if [[ ! -d $OPTARG ]]; then
                echo "no such a directory $OPTARG." >&2
                exit 1
            fi
            opt_d=true
            opt_d_value=$OPTARG
            ;;
        *)
            echo "usage: `basename $0` [-d dir] [-n number of folders]" >&2
            exit 1
            ;;
    esac
done


if [[ $opt_n == "true" ]]; then
    n=$opt_n_value
else
    n=3
fi

if [[ $opt_d == "true" ]]; then
    d=$opt_d_value
else
    d="."
fi

for i in `sort -R adj`
do
    if [[ $n < 1 ]]; then
        exit 0;
    fi
    mkdir $d/"${i}フォルダ"
    let $((n = $n - 1))
done
