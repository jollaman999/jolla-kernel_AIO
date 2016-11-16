#!/sbin/sh

# Cleanup duplicated
duplicated="$(grep -ihE 'ro.sdcardfs.enable' '/system/build.prop' | wc -l)";
if [ "$duplicated" -ge 2 ]; then
  sed -i '/ro.sdcardfs.enable/d' /system/build.prop
fi

# Cleanup N
sed -i '/ro.sys.sdcardfs/d' /system/build.prop

# Enable sdcardfs
found="$(grep -ihE 'ro.sdcardfs.enable=true' '/system/build.prop' | wc -l)";
if [ "$found" -eq 0 ]; then
  sed -i '/ro.sdcardfs.enable/d' /system/build.prop
  echo ro.sdcardfs.enable=true >> /system/build.prop
fi
