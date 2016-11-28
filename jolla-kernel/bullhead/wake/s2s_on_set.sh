#!/sbin/sh

tmp="/tmp/";
bin="$tmp/bin";

cd "$tmp";
cd ramdisk;

sed -i 's/sweep2sleep 0/sweep2sleep 1/' init.bullhead.rc;

exit 0;
