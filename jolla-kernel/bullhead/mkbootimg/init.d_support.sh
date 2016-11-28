#!/sbin/sh

tmp="/tmp/";
bin="$tmp/bin";

cd "$tmp";
cd ramdisk;

# Disable sysinit or userinit and add init.d support to init.rc
# Also only add init.d support if not already added.
find . -iname '*.rc' -maxdepth 1 -type f -exec sed -i '/start.*sysinit/d' '{}' \;
find . -iname '*.rc' -maxdepth 1 -type f -exec sed -i '/start.*userinit/d' '{}' \;

foundcount="$(find . -iname 'init.rc' -maxdepth 1 -type f -exec grep -ihE 'run\-parts /system/etc/init\.d' '{}' \; | wc -l)";
if [ "$foundcount" -eq 0 ]; then
        # find busybox in /system/
        bblocation=$(find /system/ -name 'busybox')

        # Use busybox in /su/ directory if exist
        if [ -e /data/su.img ] ; then
                mkdir /su/
                mount -t ext4 -o loop,noatime /data/su.img /su/

                # find busybox in /su/
                bblocation=$(find /su/ -name 'busybox')
        fi


        if [ -n "$bblocation" ] && [ -e "$bblocation" ] ; then
                echo "BUSYBOX FOUND!";
                # strip possible leading '.'
                bblocation=${bblocation#.};

                if [ -d /su/ ] ; then
                        umount /su/
                        rmdir /su/
                fi
        else
                echo "NO BUSYBOX NOT FOUND! copy busybox from bin directory.";
                echo "Setting busybox location to /system/xbin/busybox";
                # set default location since we couldn't find busybox
                cp "$bin/busybox" /system/xbin/busybox
                chmod 755 /system/xbin/busybox
                bblocation="/system/xbin/busybox";
        fi

        # append the new lines for this option at the bottom
        echo "" >> init.rc
        echo "service userinit $bblocation run-parts /system/etc/init.d" >> init.rc
        echo "    class late_start" >> init.rc
        echo "    user root" >> init.rc
        echo "    group root" >> init.rc
        echo "    seclabel u:r:init:s0" >> init.rc
        echo "    oneshot" >> init.rc
fi

echo " ";
echo "Done!";
exit 0;
