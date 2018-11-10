#!/sbin/sh

tmp="/tmp/";

cd "$tmp";
cd ramdisk;

sed -i 's/scroff_volctr 1/scroff_volctr 0/' init.jolla-kernel.rc;

exit 0;
