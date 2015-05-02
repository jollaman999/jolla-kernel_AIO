#!/sbin/sh
# Setting prima permissions

chown -R root.shell /system/vendor/firmware/wlan/prima
chown -R root.shell /system/vendor/firmware/wlan/prima_bak
chown -h root.shell /system/vendor/firmware/wlan/prima/WCNSS_qcom_cfg.ini
chown -h root.shell /system/vendor/firmware/wlan/prima/WCNSS_qcom_wlan_nv.bin
chown -h root.shell /system/vendor/firmware/wlan/prima_bak/WCNSS_qcom_cfg.ini
chown -h root.shell /system/vendor/firmware/wlan/prima_bak/WCNSS_qcom_wlan_nv.bin

return $?
