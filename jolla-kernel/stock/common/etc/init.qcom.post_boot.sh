#!/system/bin/sh

## frandom Support
rm /dev/random
ln -s /dev/frandom /dev/random
rm /dev/urandom
ln -s /dev/erandom /dev/urandom
rm /dev/hw_random
ln -s /dev/erandom /dev/hw_random

## power
echo 0 > /sys/module/pm_8x60/modes/cpu0/retention/idle_enabled
echo 1 > /sys/module/pm_8x60/modes/cpu1/retention/idle_enabled
echo 1 > /sys/module/pm_8x60/modes/cpu2/retention/idle_enabled
echo 1 > /sys/module/pm_8x60/modes/cpu3/retention/idle_enabled
echo 1 /sys/module/pm_8x60/modes/cpu0/standalone_power_collapse/suspend_enabled
echo 1 /sys/module/pm_8x60/modes/cpu1/standalone_power_collapse/suspend_enabled
echo 1 /sys/module/pm_8x60/modes/cpu2/standalone_power_collapse/suspend_enabled
echo 1 /sys/module/pm_8x60/modes/cpu3/standalone_power_collapse/suspend_enabled
echo 1 /sys/module/pm_8x60/modes/cpu0/standalone_power_collapse/idle_enabled
echo 1 /sys/module/pm_8x60/modes/cpu1/standalone_power_collapse/idle_enabled
echo 1 /sys/module/pm_8x60/modes/cpu2/standalone_power_collapse/idle_enabled
echo 1 /sys/module/pm_8x60/modes/cpu3/standalone_power_collapse/idle_enabled
echo 1 /sys/devices/system/cpu/cpu1/online
echo 1 /sys/devices/system/cpu/cpu2/online
echo 1 /sys/devices/system/cpu/cpu3/online

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
