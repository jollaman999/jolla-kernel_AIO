#!/sbin/sh
base=""
if [ -d "/data/media/multirom" ] ; then
    base="/data/media/multirom"
elif [ -d "/data/media/0/multirom" ] ; then
    base="/data/media/0/multirom"
else
    echo "MultiROM folder was not found"
    exit 0
fi

/tmp/busybox chattr -R -i "$base"

cd "$base"
rm -rf icons
rm -rf infos
rm -rf res
rm -rf ubuntu-init
rm -rf ubuntu-touch-init
rm -rf ubuntu-touch-sysimage-init
rm -rf adbd
rm -rf busybox
rm -rf exfat-fuse
rm -rf fw_mounter
rm -rf kexec
rm -rf lz4
rm -rf multirom
rm -rf ntfs-3g
rm -rf trampoline

return $?
