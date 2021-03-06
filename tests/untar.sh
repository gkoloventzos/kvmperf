#!/bin/bash

source common.sh

mkdir ram
mount -t ramfs none ram
pushd ram

wget -q "http://$WEBHOST/$KERNEL_TAR"
if [[ ! $? == 0 ]]; then
	exit 1
fi

for i in `seq 1 $REPTS`; do
	echo -n "."
	rm -rf $KERNEL
	power_start $i
	$TIME tar xjf $KERNEL_TAR
	power_end $i
done
echo ""
mv $TIMELOG ../.

popd
umount ram
