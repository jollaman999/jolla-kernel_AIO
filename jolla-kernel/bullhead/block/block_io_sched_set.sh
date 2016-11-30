#!/sbin/sh

tmp="/tmp/";
bin="$tmp/bin";

cd "$tmp";
cd ramdisk;

sed -i 's/scheduler bfq/scheduler '$1'/' init.bullhead.rc;

exit 0;
