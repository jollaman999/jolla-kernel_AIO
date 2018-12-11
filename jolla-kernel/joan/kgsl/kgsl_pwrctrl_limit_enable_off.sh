#!/sbin/sh

tmp="/tmp/";

cd "$tmp";
cd ramdisk;

sed -i 's/kgsl_pwrctrl_limit_enable 1/kgsl_pwrctrl_limit_enable 0/' init.jolla-kernel.rc;

exit 0;
