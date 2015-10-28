#!/bin/bash

hostname=`hostname`

host=${hostname%%.*} 
for i in 4 8 16 32 64 128 256 512 1024 2048; do   
   ./run_all.sh 0 0 40 0 "${i}k" 0
   mv time.txt "fio_${i}k_sr_${host}.txt"
   ./run_all.sh 0 0 0 40 "${i}k" 0
   mv time.txt "fio_${i}k_sw_${host}.txt"
done

for i in 4 8 16 32 64 128 256 512 1024 2048; do   
   ./run_all.sh 0 0 40 0 "${i}k" 1
   mv time.txt "fio_${i}k_rr_${host}.txt"
   ./run_all.sh 0 0 0 40 "${i}k" 1
   mv time.txt "fio_${i}k_rw_${host}.txt"
done

