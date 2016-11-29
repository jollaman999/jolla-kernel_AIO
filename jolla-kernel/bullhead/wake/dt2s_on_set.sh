#!/sbin/sh

tmp="/tmp/";
bin="$tmp/bin";

cd "$tmp";
cd ramdisk;

sed -i 's/doubletap2sleep 0/doubletap2sleep 1/' init.bullhead.rc;

exit 0;
