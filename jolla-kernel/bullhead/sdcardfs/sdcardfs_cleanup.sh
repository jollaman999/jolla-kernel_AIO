#!/sbin/sh

sed -i '/ro.sdcardfs.enable/d' /system/build.prop
sed -i '/ro.sys.sdcardfs/d' /system/build.prop
