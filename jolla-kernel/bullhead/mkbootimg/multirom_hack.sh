#!/sbin/sh

foundcount="$(mount | grep -ihE '/realdata' | wc -l)";
otgcount="$(cat /etc/fstab | grep -ihE '/mnt/multirom-bullhead' | wc -l)";

if [ "$foundcount" != 0 ]; then
  echo "THIS IS MULTIROM!";
  echo "multirom=1" > /tmp/aroma-data/multirom.prop

  if [ "$otgcount" != 0 ]; then
    echo "THIS ROM IS LOCATED IN OTG!";
    echo "otg=1" > /tmp/aroma-data/otg.prop
    awk '{ print $1 }' /etc/fstab | grep -ihE '/mnt/multirom-bullhead' | grep -ihE '/data.img' | head -n1 > /tmp/mrom_path
    sed -i 's/\/data.img//' /tmp/mrom_path
  else
    echo "otg=0" > /tmp/aroma-data/otg.prop
    awk '{ print $1 }' /etc/fstab | grep -ihE '/realdata' | grep -ihE '/data' | head -n1 > /tmp/mrom_path
    sed -i 's/\/data//' /tmp/mrom_path
  fi
    mrom_path="$(cat /tmp/mrom_path)"
    echo "mrom_path=""$mrom_path"

    cp /tmp/image-new.img "$mrom_path""/boot.img"
else
  echo "multirom=0" > /tmp/aroma-data/multirom.prop
fi
