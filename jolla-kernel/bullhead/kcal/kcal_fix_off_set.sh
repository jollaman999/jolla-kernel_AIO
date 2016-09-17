#!/sbin/sh

tmp="/tmp/";
bin="$tmp/bin";

cd "$tmp";
cd ramdisk;

sed -i 's/kcal_fix_yellow 1/kcal_fix_yellow 0/' init.bullhead.rc;

exit 0;
