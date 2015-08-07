#!/bin/bash

#the count sould be changed also when we change bs
source common.sh
DEFAULT_SIZE="32k"
SIZE=${1:-$DEFAULT_SIZE}
REPTS=1
dd if=/dev/urandom bs=$SIZE count=2600 of=foo > /dev/null 2>&1

cat > dd_cmd.sh << EOF
#!/bin/bash

dd if=foo bs=$SIZE count=2600 of=/dev/null
sync
EOF
chmod a+x dd_cmd.sh
DD="./dd_cmd.sh"

cat ./dd_cmd.sh
echo $REPTS

for i in `seq 1 $REPTS`; do
	echo -n "."
#	rm bar
	sync
	echo 3 > /proc/sys/vm/drop_caches
	power_start $i
	$TIME $DD > /dev/null 2>&1
	power_end $i
done
echo ""
