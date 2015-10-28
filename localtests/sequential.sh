#!/bin/bash

hostname=`hostname`

host=${hostname%%.*} 
for i in 4 64 512 1024 2048; do   
   ./run_all.sh 0 0 40 0 "${i}k"
   echo "fio_${i}k_rr_${host}.txt"
   mv time.txt "fio_${i}k_rr_${host}.txt"
   ./run_all.sh 0 0 0 40 "${i}k"
   mv time.txt "fio_${i}k_rw_${host}.txt"
done
