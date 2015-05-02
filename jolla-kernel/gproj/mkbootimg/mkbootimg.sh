#!/sbin/sh
echo \#!/sbin/sh > /tmp/createnewboot.sh
echo /tmp/mkbootimg --kernel /tmp/zImage --ramdisk /tmp/newramdisk.cpio.gz --cmdline \"$(cat /tmp/boot.img-cmdline)\" --base 0x$(cat /tmp/boot.img-base) --pagesize 2048 --ramdiskaddr 0x82500000 --output /tmp/newboot.img >> /tmp/createnewboot.sh
chmod 777 /tmp/createnewboot.sh
/tmp/createnewboot.sh
return $?
