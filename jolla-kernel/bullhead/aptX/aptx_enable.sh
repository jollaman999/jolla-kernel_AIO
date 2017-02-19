#!/sbin/sh

# Cleanup duplicated
duplicated="$(grep -ihE 'persist.bt.enableAptXHD' '/system/build.prop' | wc -l)";
if [ "$duplicated" -ge 2 ]; then
  sed -i '/persist.bt.enableAptXHD/d' /system/build.prop
fi

# Enable aptX
found="$(grep -ihE 'persist.bt.enableAptXHD=true' '/system/build.prop' | wc -l)";
if [ "$found" -eq 0 ]; then
  sed -i '/persist.bt.enableAptXHD/d' /system/build.prop
  echo persist.bt.enableAptXHD=true >> /system/build.prop
fi
