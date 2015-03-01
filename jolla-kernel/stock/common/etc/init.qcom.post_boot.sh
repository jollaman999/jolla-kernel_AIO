#!/system/bin/sh

echo 320000000 > /sys/devices/platform/kgsl-3d0.0/kgsl/kgsl-3d0/max_gpuclk
echo 1 > /sys/module/intelli_plug/parameters/intelli_plug_active
##
