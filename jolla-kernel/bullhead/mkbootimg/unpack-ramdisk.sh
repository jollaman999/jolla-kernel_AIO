#!/sbin/sh

# copy old kernel to sdcard
if [ ! -e /sdcard/zImage_bak ]; then
	cp /tmp/boot.img-zImage /sdcard/Image.gz-dtb_bak
fi

# decompress ramdisk
mkdir /tmp/ramdisk
cd /tmp/ramdisk
gunzip -c ../boot.img-ramdisk.gz | cpio -i

# Disable sysinit or userinit and add init.d support to init.rc
# Also only add init.d support if not already added.
find . -iname '*.rc' -maxdepth 1 -type f -exec sed -i '/start.*sysinit/d' '{}' \;
find . -iname '*.rc' -maxdepth 1 -type f -exec sed -i '/start.*userinit/d' '{}' \;
foundcount="$(find . -iname 'init.rc' -maxdepth 1 -type f -exec grep -ihE 'run\-parts /system/etc/init\.d' '{}' \; | wc -l)";
if [ "$foundcount" -eq 0 ]; then
        #find busybox in /system
        bblocation=$(find /system/ -name 'busybox')
        if [ -n "$bblocation" ] && [ -e "$bblocation" ] ; then
                echo "BUSYBOX FOUND!";
                #strip possible leading '.'
                bblocation=${bblocation#.};
        else
                echo "NO BUSYBOX NOT FOUND! init.d support will not work without busybox!";
                echo "Setting busybox location to /system/xbin/busybox! (install it and init.d will work)";
                #set default location since we couldn't find busybox
                bblocation="/system/xbin/busybox";
        fi
		#append the new lines for this option at the bottom
        echo "" >> init.rc
        echo "service userinit $bblocation run-parts /system/etc/init.d" >> init.rc
        echo "    oneshot" >> init.rc
        echo "    class late_start" >> init.rc
        echo "    user root" >> init.rc
        echo "    group root" >> init.rc
fi
