#!/sbin/sh

# Cleanup duplicated
duplicated="$(grep -ihE 'ro.sys.sdcardfs' '/system/build.prop' | wc -l)";
if [ "$duplicated" -ge 2 ]; then
  sed -i '/ro.sys.sdcardfs/d' /system/build.prop
fi

# Cleanup M
sed -i '/ro.sdcardfs.enable/d' /system/build.prop

# Enable sdcardfs
found="$(grep -ihE 'ro.sys.sdcardfs=true' '/system/build.prop' | wc -l)";
if [ "$found" -eq 0 ]; then
  sed -i '/ro.sys.sdcardfs/d' /system/build.prop
  echo ro.sys.sdcardfs=true >> /system/build.prop
fi
