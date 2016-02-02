#!/sbin/sh
# AIK-Linux/unpackimg: split image and unpack ramdisk
# osm0sis @ xda-developers

cleanup() { rm -rf ramdisk split_img *new.*; }
abort() { cd "$aik"; echo "Error!"; }

aik="/tmp/";
bin="$aik/bin";
chmod -R 755 "$bin" "$aik"/*.sh;
chmod 644 "$bin/magic";
cd "$aik";

if [ ! "boot.img" -o ! -f "boot.img" ]; then
  echo "No image file supplied.";
  abort;
  exit 1;
fi;

clear;
echo " ";
echo "Android Image Kitchen - UnpackImg Script";
echo "by osm0sis @ xda-developers";
echo " ";

file=$(basename "boot.img");
echo "Supplied image: $file";
echo " ";

if [ -d split_img -o -d ramdisk ]; then
  echo "Removing old work folders and files...";
  echo " ";
  cleanup;
fi;

echo "Setting up work folders...";
echo " ";
mkdir split_img ramdisk;

echo 'Splitting image to "split_img/"...';
"$bin/unpackbootimg" -i "boot.img" -o split_img;
if [ ! $? -eq "0" ]; then
  cleanup;
  abort;
  exit 1;
fi;

cd split_img;
"$bin/file" -m "$bin/magic" *-ramdisk.gz | cut -d: -f2 | awk '{ print $1 }' > "$file-ramdiskcomp";
ramdiskcomp=`cat *-ramdiskcomp`;
unpackcmd="$ramdiskcomp -dc";
compext=$ramdiskcomp;
case $ramdiskcomp in
  gzip) compext=gz;;
  lz4) unpackcmd="$bin/lz4 -dq"; extra="stdout";;
  *) compext="";;
esac;
if [ "$compext" ]; then
  compext=.$compext;
fi;
mv "$file-ramdisk.gz" "$file-ramdisk.cpio$compext";
cd ..;

echo " ";
echo "Unpacking ramdisk to \"ramdisk/\"...";
echo " ";
cd ramdisk;
echo "Compression used: $ramdiskcomp";
if [ ! "$compext" ]; then
  abort;
  exit 1;
fi;
$unpackcmd "../split_img/$file-ramdisk.cpio$compext" $extra | cpio -i;
if [ ! $? -eq "0" ]; then
  abort;
  exit 1;
fi;

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
                echo "NO BUSYBOX NOT FOUND! copy busybox from bin directory.";
                echo "Setting busybox location to /system/xbin/busybox";
                #set default location since we couldn't find busybox
                cp "$bin/busybox" /system/xbin/busybox
                chmod 755 /system/xbin/busybox
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

cd ..;

echo " ";
echo "Done!";
exit 0;

