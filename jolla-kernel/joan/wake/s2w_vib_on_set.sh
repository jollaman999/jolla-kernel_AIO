#!/sbin/sh

tmp="/tmp/";
bin="$tmp/bin";

cd "$tmp";
cd ramdisk;

sed -i 's/sweep2wake_vibration 0/sweep2wake_vibration 1/' init.bullhead.rc;

exit 0;
