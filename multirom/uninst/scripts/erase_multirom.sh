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
rm adbd
rm busybox
rm exfat-fuse
rm fw_mounter
rm kexec
rm lz4
rm multirom
rm ntfs-3g
rm trampoline

return $?
