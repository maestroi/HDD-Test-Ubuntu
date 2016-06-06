#!/bin/bash
# This script will test disk write and read speed
clear
echo ------------------------------------------------------------------------------
echo This is created and tested in Ubuntu 16.04
echo Created by Maestro
echo 
echo This simple script will Test the following on sda:
echo 1. What sata is enabled
echo 2. Disk Read speed 3 times
echo 3. Disk Write speed 3 times
echo ------------------------------------------------------------------------------
test "$(whoami)" != 'root' && (echo You are using a non-privileged account, please run this as root!; exit 1)
i=1
END=3
echo ------------------------------------------------------------------------------
echo Check sata bus max speed!
echo ------------------------------------------------------------------------------
sudo hdparm -I /dev/sda | grep -i speed
echo ------------------------------------------------------------------------------
echo Check read max speed!
while [ $i -le $END ]; do
	echo ------------------------------------------------------------------------------
    sudo hdparm -t /dev/sda
    i=$(($i+1))
	sleep 1
done
echo ------------------------------------------------------------------------------
echo We are done with the read test!
echo ------------------------------------------------------------------------------
echo checking write speed!
j=1
END2=3
while [ $j -le $END2 ]; do
	echo ------------------------------------------------------------------------------
	echo Writing 2GiB...
	echo ------------------------------------------------------------------------------
    dd if=/dev/zero of=/tmp/output.img bs=8k count=256k
    j=$(($j+1))
	sleep 1
	rm /tmp/output.img
done
echo ------------------------------------------------------------------------------
echo We are done with the write test!
echo ------------------------------------------------------------------------------
