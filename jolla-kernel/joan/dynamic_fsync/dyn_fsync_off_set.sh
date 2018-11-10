#!/sbin/sh

tmp="/tmp/";

cd "$tmp";
cd ramdisk;

sed -i 's/Dyn_fsync_active 1/Dyn_fsync_active 0/' init.jolla-kernel.rc;

exit 0;
