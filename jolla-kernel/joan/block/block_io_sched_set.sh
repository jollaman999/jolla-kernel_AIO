#!/sbin/sh

tmp="/tmp/";
bin="$tmp/bin";

cd "$tmp";
cd ramdisk;

sed -i 's/scheduler bfq/scheduler '$1'/g' init.bullhead.rc;

exit 0;
