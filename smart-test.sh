#!/bin/bash
test=short
while getopts l opt
do
	case $opt in
		l) test=long;;
	esac
done
echo "Start"
for x in {a..f}
do
        echo "/dev/sd$x"
        smartctl -t $test /dev/sd${x} | egrep "success|current test|Read Device Identity failed: Input/output error"
        echo "==="
done
