#!/sbin/sh

tmp="/tmp/";
bin="$tmp/bin";

cd "$tmp";
cd ramdisk;

sed -i 's/Dyn_fsync_active 1/Dyn_fsync_active 0/' init.bullhead.rc;

exit 0;
