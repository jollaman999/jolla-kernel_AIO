#!/sbin/sh

tmp="/tmp/";
bin="$tmp/bin";

cd "$tmp";
cd ramdisk;

sed -i 's/sweep2wake 0/sweep2wake 1/' init.bullhead.rc;

exit 0;
