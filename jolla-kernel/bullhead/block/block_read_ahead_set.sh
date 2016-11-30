#!/sbin/sh

tmp="/tmp/";
bin="$tmp/bin";

cd "$tmp";
cd ramdisk;

sed -i 's/read_ahead_kb 128/read_ahead_kb '$1'/' init.bullhead.rc;

exit 0;
