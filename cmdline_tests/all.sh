#!/bin/bash

SERVER=${1-localhost}
REPTS=${2-40}

./apache_install.sh
./memcached_install.sh
./netperf_install.sh
./mysql_install.sh

./apache.sh $SERVER $REPTS
./mysql.sh run $SERVER $REPTS
./netperf.sh ALL $SERVER $REPTS
./memcached.sh $SERVER $REPTS
