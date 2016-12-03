#!/sbin/sh

tmp="/tmp/";
bin="$tmp/bin";

cd "$tmp";
cd ramdisk;

#### Remove old lines from init.rc ####
#
#service userinit /system/xbin/busybox run-parts /system/etc/init.d
#    oneshot
#    class late_start
#    user root
#    group root
sed -i ':a;N;$!ba;s/\nservice userinit \/system\/xbin\/busybox run-parts \/system\/etc\/init.d\n \ \ \ oneshot\n \ \ \ class late_start\n \ \ \ user root\n \ \ \ group root//' init.rc

#### Remove old lines from init.rc ####
#
#service userinit /system/xbin/busybox run-parts /system/etc/init.d
#    class late_start
#    user root
#    group root
#    seclabel u:r:init:s0
#    oneshot
sed -i ':a;N;$!ba;s/\nservice userinit \/system\/xbin\/busybox run-parts \/system\/etc\/init.d\n \ \ \ class late_start\n \ \ \ user root\n \ \ \ group root\n \ \ \ seclabel u:r:init:s0\n \ \ \ oneshot//' init.rc

echo "Done!";
exit 0;
