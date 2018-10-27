#!/sbin/sh

tmp="/tmp/";
bin="$tmp/bin";

cd "$tmp";
cd ramdisk;

sed -i 's/doubletap2wake 0/doubletap2wake '$1'/' init.bullhead.rc;

exit 0;
