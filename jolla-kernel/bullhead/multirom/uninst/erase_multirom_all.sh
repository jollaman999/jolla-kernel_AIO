#!/sbin/sh
base1=""
if [ -d "/data/media/multirom" ] ; then
    base1="/data/media/multirom"
elif [ -d "/data/media/0/multirom" ] ; then
    base1="/data/media/0/multirom"
else
    echo "base1 MultiROM folder was not found"
    exit 0
fi

/tmp/busybox chattr -R -i "$base1"
rm -rf "$base1"

base2=""
if [ -d "/data/media/MultiROM" ] ; then
    base2="/data/media/MultiROM"
elif [ -d "/data/media/0/MultiROM" ] ; then
    base2="/data/media/0/MultiROM/"
else
    echo "base2 MultiROM folder was not found"
    exit 0
fi

/tmp/busybox chattr -R -i "$base2"
rm -rf "$base2"


return $?
