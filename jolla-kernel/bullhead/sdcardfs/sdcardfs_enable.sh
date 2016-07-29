#!/sbin/sh

sed -i '/ro.sdcardfs.enable/d' /system/build.prop
echo ro.sdcardfs.enable=true >> /system/build.prop
