#!/bin/sh

if [ $# != 2 ] ; then
    echo "Usage: $0 <target-process-pid> <time between measurements>"
    exit 1
fi

target_process=$1
time_between_measurements=$2

echo utime stime cutime cstime umode umodelowpriority smode idle time vmpeak vmsize
while [ -e /proc/$target_process ] ; do
    process_time=$(cat /proc/$target_process/stat | cut -d ' ' -f 14-17)
    cpu_time=$(cat /proc/stat | grep cpu\  | cut -d ' ' -f 3-6)
    real_time_in_nanoseconds=$(date +%s)
    memory_peak_size=$(cat /proc/$target_process/status | grep -e VmPeak -e VmSize | cut -f 3 -d ' ')
    echo $process_time $cpu_time $real_time_in_nanoseconds $memory_peak_size
    sleep $time_between_measurements
done

