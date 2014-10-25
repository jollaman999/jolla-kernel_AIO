#!/system/bin/sh

## frandom Support
rm /dev/random
ln -s /dev/frandom /dev/random
rm /dev/urandom
ln -s /dev/erandom /dev/urandom
rm /dev/hw_random
ln -s /dev/erandom /dev/hw_random

## jollaman999
echo 270000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo 270000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
echo 270000 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
echo 270000 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq
echo 1134000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo 1134000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
echo 1134000 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
echo 1134000 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
echo 320000000 > /sys/devices/platform/kgsl-3d0.0/kgsl/kgsl-3d0/max_gpuclk
echo 1 > /sys/module/intelli_plug/parameters/intelli_plug_active
##
