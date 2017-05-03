#!/bin/bash
max=$1
cwd=$PWD
for ((i=1; i <= max; i++))
do
    cwd=$cwd/..
done
cd "$cwd" || exit
