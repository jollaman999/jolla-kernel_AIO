#!/sbin/sh
base=""
if [ -d "/data/media/MultiROM/multirom" ] ; then
    base="/data/media/MultiROM/multirom"
elif [ -d "/data/media/0/MultiROM/multirom" ] ; then
    base="/data/media/0/MultiROM/multirom"
else
    echo "MultiROM folder was not found"
    exit 0
fi

cd "$base"
/tmp/busybox chattr -R -i enc
rm -rf enc
/tmp/busybox chattr -R -i icons
rm -rf icons
/tmp/busybox chattr -R -i res
rm -rf res
/tmp/busybox chattr -R -i ubuntu-init
rm -rf ubuntu-init
/tmp/busybox chattr -R -i ubuntu-touch-init
rm -rf ubuntu-touch-init
/tmp/busybox chattr -R -i ubuntu-touch-sysimage-init
rm -rf ubuntu-touch-sysimage-init
/tmp/busybox chattr -R -i adbd
rm -rf adbd
/tmp/busybox chattr -R -i busybox
rm -rf busybox
/tmp/busybox chattr -R -i exfat-fuse
rm -rf exfat-fuse
/tmp/busybox chattr -R -i kexec
rm -rf kexec
/tmp/busybox chattr -R -i lz4
rm -rf lz4
/tmp/busybox chattr -R -i mrom.fstab
rm -rf mrom.fstab
/tmp/busybox chattr -R -i multirom
rm -rf multirom
/tmp/busybox chattr -R -i ntfs-3g
rm -rf ntfs-3g
/tmp/busybox chattr -R -i trampoline
rm -rf trampoline

return $?
