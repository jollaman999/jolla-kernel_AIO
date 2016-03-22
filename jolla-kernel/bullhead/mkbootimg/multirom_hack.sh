#!/sbin/sh

foundcount="$(mount | grep -ihE '/realdata' | wc -l)";

if [ "$foundcount" != 0 ]; then
  echo "THIS IS MULTIROM!";
  
  awk '{ print $1 }' /etc/fstab | grep -ihE '/realdata' | grep -ihE '/data' | head -n1 > /tmp/mrom_path
  sed -i 's/\/data//' /tmp/mrom_path

  mrom_path="$(cat /tmp/mrom_path)"
  echo "mrom_path=""$mrom_path"

  cp /tmp/image-new.img "$mrom_path""/boot.img"

  echo "multirom=1" > /tmp/aroma-data/multirom.prop
else
  echo "multirom=0" > /tmp/aroma-data/multirom.prop
fi

