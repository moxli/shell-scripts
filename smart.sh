#!/bin/bash
#grml SMART Script

rescan="n"

while getopts r opt
do
	case $opt in
		r) rescan="y";;
	esac
done
 
echo "Start"

if [ "$rescan" == "y" ];
then
	echo $rescan
	for y in {0..5}
	do
		echo "0 0 0" > /sys/class/scsi_host/host$y/scan
		echo "rescan $y"
	done
fi



for x in {a..f}
do
        echo "/dev/sd$x"
        smartctl -a /dev/sd${x} | egrep "Serial|Reallocated_Sector|Power-On Hours|Media Wearout Indicator|SMART Self-test log structure|^[Num]|^# |Power_On_Hours|Device Model|SMART overall-health self-assessment test result|of test remaining"
        echo "==="
	echo ""
done
