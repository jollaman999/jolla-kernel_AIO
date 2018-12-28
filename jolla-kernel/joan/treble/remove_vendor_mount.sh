#!/sbin/sh

# Remove vendor mount from fstab.joan

tmp="/tmp/";

cd "$tmp";
cd ramdisk;

sed -i '/\/vendor/d' fstab.joan;
