#!/bin/bash

output_file="tests.txt"

speedtest_output=$(speedtest)
download_speed=$(echo "$speedtest_output" | grep 'Download:' | awk '{print $2 " " $3}')
upload_speed=$(echo "$speedtest_output" | grep 'Upload:' | awk '{print $2 " " $3}')
current_time=$(date "+%H:%M")

echo "Speedtest:" >> $output_file
echo "$current_time | $download_speed | $upload_speed" >> $output_file

ping_1_output=$(ping -c 1 1.1.1.1)
time_1=$(echo "$ping_1_output" | tail -1 | awk -F'/' '{print $5}')
echo "$current_time | Ping time to 1.1.1.1: $time_1 ms" >> $output_file

ping_8_output=$(ping -c 1 8.8.8.8)
time_8=$(echo "$ping_8_output" | tail -1 | awk -F'/' '{print $5}')
echo "$current_time | Ping time to 8.8.8.8: $time_8 ms" >> $output_file

ping_100_output=$(ping -c 100 8.8.8.8)
packet_loss=$(echo "$ping_100_output" | grep 'packet loss' | awk -F',' '{print $3}' | awk '{print $1}')

echo "$current_time | Packet loss: $packet_loss" >> $output_file
