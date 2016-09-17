#!/sbin/sh

tmp="/tmp/";
bin="$tmp/bin";

cd "$tmp";
cd ramdisk;

sed -i 's/scroff_volctr 1/scroff_volctr 0/' init.bullhead.rc;

exit 0;
