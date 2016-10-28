#!/sbin/sh

sed -i '/ro.sdcardfs.enable/d' /system/build.prop
sed -i '/ro.sys.sdcardfs/d' /system/build.prop
echo ro.sys.sdcardfs=true >> /system/build.prop
