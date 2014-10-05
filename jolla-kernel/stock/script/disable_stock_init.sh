#!/sbin/sh
# backup the old prima stuff

if [ ! -d /system/etc/init.qcom.post_boot.sh ] ; then
        busybox mv /system/etc/init.qcom.post_boot.sh /system/etc/init.qcom.post_boot.sh_bak
fi

return $?
