#!/sbin/sh
base=""
if [ -d "/data/media/multirom" ] ; then
    base="/data/media/multirom"
elif [ -d "/data/media/0/multirom" ] ; then
    base="/data/media/0/multirom"
else
    if [ -d "/data/media/0" ] ; then
        base="/data/media/0/multirom"
    else
        base="/data/media/multirom"
    fi

    mkdir "$base"
    chown root:root "$base"
    chmod 770 "$base"

    mkdir "$base/roms"
    chown media_rw:media_rw "$base/roms"
    chmod 777 "$base/roms"

    touch "$base/.nomedia"
    chown media_rw:media_rw "$base/.nomedia"
fi

cp /tmp/trampoline "$base/"
chmod 750 "$base/trampoline"


