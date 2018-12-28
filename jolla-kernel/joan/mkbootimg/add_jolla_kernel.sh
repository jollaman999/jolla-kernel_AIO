#!/sbin/sh

# Add jolla-kernel import line to init.joan.rc

tmp="/tmp/";

cd "$tmp";
cd ramdisk;

find_jolla_kernel=`grep -i "import /init.jolla-kernel.rc" init.joan.rc`

if [ ! -z "$find_jolla_kernel" ]; then
	echo "Found jolla-kernel rc import! No need to patch!";
else
	echo "Adding jolla-kernel rc import to init.joan.rc"
	sed -i 's/import\ \/init.msm8998_core.rc/import\ \/init.msm8998_core.rc\nimport\ \/init.jolla-kernel.rc/g' init.joan.rc;

fi
