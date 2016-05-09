#!/sbin/sh
sed -i 's/AUTO_OFF_VALUE/'$1'/' /system/etc/init.d/77sovc_auto_off
