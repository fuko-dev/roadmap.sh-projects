#!/usr/bin/env bash

echo "+++++++++++++++++++++++++++++++++ Server Stats +++++++++++++++++++++++++++++++++"


# Get CPU use with '/proc/stat'
grep 'cpu ' /proc/stat | awk '{cpuUsage=($2+$4)*100/($2+$4+$5)} END {printf "CPU Usage: %.2f%%\n", cpuUsage}'

# Get Memory usage with 'free'
free -l | grep 'Mem:' | awk '{memUsage=$3*100/$2} END {printf "Memory Usage: %.2f%%\n", memUsage}'

# Get disk usage of root partition with 'df' and format output
diskUsage=$(df -h / | sed 1d)

diskUsed=$(echo ${diskUsage} | awk '{print $3}')
diskTotal=$(echo ${diskUsage} | awk '{print $2}')
diskPercent=$(echo ${diskUsage} | awk '{print $5}')

echo "Disk Usage (/): ${diskUsed}/${diskTotal} (${diskPercent})"

# Top 5 processes by CPU
echo "Top 5 Processes by CPU Usage"
top -b -n 1 -o %CPU | sed 1,6d | head -6

# Top 5 processes by MEM
echo "Top 5 Processes by Memory Usage"
top -b -n 1 -o %MEM | sed 1,6d | head -6