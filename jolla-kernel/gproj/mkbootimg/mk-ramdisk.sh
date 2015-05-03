#!/sbin/sh

# compress ramdisk
cd /tmp/ramdisk
find . | cpio -o -H newc | gzip > ../newramdisk.cpio.gz
cd /
