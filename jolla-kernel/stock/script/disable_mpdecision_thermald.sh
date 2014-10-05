#!/sbin/sh
# backup the old prima stuff

if [ ! -d /system/bin/mpdecision_bak ] ; then
        busybox mv /system/bin/mpdecision /system/bin/mpdecision_bak
fi

if [ ! -d /system/bin/thermal-engine_bak ] ; then
        busybox mv /system/bin/thermal-engine /system/bin/thermal-engine_bak
fi

if [ ! -d /system/bin/thermald_bak ] ; then
        busybox mv /system/bin/thermald /system/bin/thermald_bak
fi

return $?
