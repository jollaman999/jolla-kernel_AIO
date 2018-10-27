#!/sbin/sh

tmp="/tmp/";
bin="$tmp/bin";

cd "$tmp";
cd ramdisk;

sed -i 's/sovc_auto_off_delay 2500/sovc_auto_off_delay '$1'/' init.bullhead.rc;

exit 0;
