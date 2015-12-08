#!/bin/bash

if [ -e apache.txt ]; then
  awk '{ sum += $1; n++ } END { if (n > 0) print "apache " sum / n; }' apache.txt >>average.txt
fi

#break netperf.txt
if [ -e netperf.txt ]; then
  TM=`grep -c TCP_MAERTS netperf.txt`
  TS=`grep -c TCP_STREAM netperf.txt`
  TR=`grep -c TCP_RR netperf.txt`
  ALL=`wc -l netperf.txt`
  REPEAT=$(($ALL - $TM - $TS - $TR))
  TESTS=$(($TM + $TS + $TR))
  REPEAT=$(($REPEAT/$TESTS))
  SPLIT=0
  if [ TM -eq 1 ]; then
    SPLIT=$(($REPEAT + 1))
    head -n $SPLIT netperf.txt | tail -n $REPEAT > TCP_MAERTS.txt
    awk '{ sum += $1; n++ } END { if (n > 0) print "TCP_MAERTS " sum / n; }' TCP_MAERTS.txt >>average.txt
  fi
  if [ TS -eq 1 ]; then
    SPLIT=$(($REPEAT + 1))
    head -n $SPLIT netperf.txt | tail -n $REPEAT > TCP_STREAM.txt
    awk '{ sum += $1; n++ } END { if (n > 0) print "TCP_STREAM " sum / n; }' TCP_STREAM.txt >>average.txt
  fi
  if [ TR -eq 1 ]; then
    SPLIT=$(($REPEAT + 1))
    head -n $SPLIT netperf.txt | tail -n $REPEAT > TCP_RR.txt
    awk '{ sum += $1; n++ } END { if (n > 0) print "TCP_RR " sum / n; }' TCP_RR.txt >>average.txt
  fi
fi

#break mysql.txt
if [ -e mysql.txt ]; then
  T1=`grep -wc 1 mysql.txt`
  T2=`grep -wc 2 mysql.txt`
  T4=`grep -wc 4 mysql.txt`
  T8=`grep -wc 8 mysql.txt`
  #these measurements can be as time
  T20=`grep -wc \"20 threads\" mysql.txt`
  T100=`grep -wc \"100 threads\" mysql.txt`
  T200=`grep -wc \"200 threads\" mysql.txt`
  T400=`grep -wc \"400 threads\" mysql.txt`
  head -n 42 mysql.txt | tail -n 40 >mysql_1.txt
  awk '{ sum += $1; n++ } END { if (n > 0) print "mysql 1 " sum / n; }' mysql_1.txt >> average.txt
  head -n 85 mysql.txt | tail -n 40 > mysql_2.txt
  awk '{ sum += $1; n++ } END { if (n > 0) print "mysql 2 " sum / n; }' mysql_2.txt >> average.txt
  head -n 128 mysql.txt | tail -n 40 > mysql_4.txt
  awk '{ sum += $1; n++ } END { if (n > 0) print "mysql 4 " sum / n; }' mysql_4.txt >> average.txt
  head -n 171 mysql.txt | tail -n 40 > mysql_8.txt
  awk '{ sum += $1; n++ } END { if (n > 0) print "mysql 8 " sum / n; }' mysql_8.txt >> average.txt
  head -n 214 mysql.txt | tail -n 40 > mysql_20.txt
  awk '{ sum += $1; n++ } END { if (n > 0) print "mysql 20 " sum / n; }' mysql_20.txt >> average.txt
  head -n 257 mysql.txt | tail -n 40 > mysql_100.txt
  awk '{ sum += $1; n++ } END { if (n > 0) print "mysql 100 " sum / n; }' mysql_100.txt >> average.txt
  head -n 300 mysql.txt | tail -n 40 > mysql_200.txt
  awk '{ sum += $1; n++ } END { if (n > 0) print "mysql 200 " sum / n; }' mysql_200.txt >> average.txt
  head -n 343 mysql.txt | tail -n 40 > mysql_400.txt
  awk '{ sum += $1; n++ } END { if (n > 0) print "mysql 400 " sum / n; }' mysql_400.txt >> average.txt
fi

#memcached
if [ -e memcached.txt ]; then
  grep Totals memcached.txt | awk '{print $2}' > memcached_totals.txt
  awk '{ sum += $1; n++ } END { if (n > 0) print "memcached " sum / n; }' memcached_totals.txt >>average.txt
fi

#fio
if [ -e fio.txt ]; then
  READ=`grep -c \"fio read\" fio.txt`
  WRITE=`grep -c \"fio write\" fio.txt`
  ALL=`wc -l fio.txt`
  REPEAT=$(($ALL - $READ - $WRITE))
  TESTS=$(($READ + $WRITE))
  REPEAT=$(($REPEAT/$TESTS))
  SPLIT=0
  if [ $READ -eq 1 ]; then
    SPLIT=$(($REPEAT + 1))  
    head -n $SPLIT fio.txt | tail -n $REPEAT > rread.txt
    awk '{ sum += $1; n++ } END { if (n > 0) print "fio rr " sum / n; }' rread.txt >>average.txt
  fi
  if [ $READ -eq 1 ]; then
    SPLIT=$(($REPEAT + 1)) 
    head -n $SPLIT fio.txt | tail -n $REPEAT > rwrite.txt
    awk '{ sum += $1; n++ } END { if (n > 0) print "fio rw " sum / n; }' rwrite.txt >>average.txt
  fi
fi

#pbzip
if [ -e pbzip.txt ]; then
  COMP=`grep -wc compress pbzip.txt`
  DECOMP=`grep -wc decompress pbzip.txt`
  ALL=`wc -l pbzip.txt`
  REPEAT=$(($ALL - $COMP - $DECOMP))
  TESTS=$(($COMP + $DECOMP))
  REPEAT=$(($REPEAT/$TESTS))
  SPLIT=0
  if [ $COMP -eq 1 ]; then
    SPLIT=$(($REPEAT + 1))
    head -n $SPLIT pbzip.txt | tail -n $REPEAT >compress.txt
    awk '{ sum += $1; n++ } END { if (n > 0) print "pbzip c " sum / n; }' compress.txt >>average.txt
  fi
  if [ $COMP -eq 1 ]; then
    SPLIT=$(($REPEAT + 1))
    head -n $SPLIT pbzip.txt | tail -n $REPEAT >decompress.txt
    awk '{ sum += $1; n++ } END { if (n > 0) print "pbzip d " sum / n; }' decompress.txt >>average.txt
  fi
fi

if [ -e hackbench.txt ]; then
  awk '{ sum += $1; n++ } END { if (n > 0) print "hackbench " sum / n; }' hackbench.txt >>average.txt
fi

if [ -e kernbench.txt ]; then
  awk '{ sum += $1; n++ } END { if (n > 0) print "kernbench " sum / n; }' kernbench.txt >>average.txt
fi


