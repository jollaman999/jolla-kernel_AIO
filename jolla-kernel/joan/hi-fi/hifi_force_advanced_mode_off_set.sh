#!/sbin/sh

tmp="/tmp/";

cd "$tmp";
cd ramdisk;

sed -i 's/force_advanced_mode 1/force_advanced_mode 0/' init.jolla-kernel.rc;

exit 0;
