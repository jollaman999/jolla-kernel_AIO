#!/sbin/sh
# backup the old prima stuff

if [ ! -d /system/etc/wifi_bak ] ; then
        busybox cp -R /system/etc/wifi /system/etc/wifi_bak
fi

if [ ! -d /system/vendor/firmware/wlan/prima_bak ] ; then
        busybox cp -R /system/vendor/firmware/wlan/prima /system/vendor/firmware/wlan/prima_bak
fi

return $?
