#!/sbin/sh
# backup the old prima stuff

if [ ! -d /system/lib/hw/camera.qcom.so_bak ] ; then
        busybox mv /system/lib/hw/camera.qcom.so /system/lib/hw/camera.qcom.so_bak
fi

return $?
