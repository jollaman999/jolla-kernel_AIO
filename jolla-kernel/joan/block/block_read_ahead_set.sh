#!/sbin/sh

tmp="/tmp/";
bin="$tmp/bin";

cd "$tmp";
cd ramdisk;

sed -i 's/read_ahead_kb 2048/read_ahead_kb '$1'/g' init.bullhead.rc;

exit 0;
