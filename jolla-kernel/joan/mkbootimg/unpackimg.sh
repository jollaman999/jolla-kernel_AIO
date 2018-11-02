#!/sbin/sh
# AIK-Linux/unpackimg: split image and unpack ramdisk
# osm0sis @ xda-developers

cleanup() { rm -rf ramdisk split_img *new.*; }
abort() { cd "$aik"; echo "Error!"; }

aik="/tmp/";
bin="$aik/bin";
chmod -R 755 "$bin" "$aik"/*.sh;
chmod 644 "$bin/magic";
cd "$aik";

if [ ! "boot.img" -o ! -f "boot.img" ]; then
  echo "No image file supplied.";
  abort;
  exit 1;
fi;

clear;
echo " ";
echo "Android Image Kitchen - UnpackImg Script";
echo "by osm0sis @ xda-developers";
echo " ";

file=$(basename "boot.img");
echo "Supplied image: $file";
echo " ";

if [ -d split_img -o -d ramdisk ]; then
  echo "Removing old work folders and files...";
  echo " ";
  cleanup;
fi;

echo "Setting up work folders...";
echo " ";
mkdir split_img ramdisk;

echo 'Splitting image to "split_img/"...';
"$bin/unpackbootimg" -i "boot.img" -o split_img;
if [ ! $? -eq "0" ]; then
  cleanup;
  abort;
  exit 1;
fi;

cd split_img;
"$bin/file" -m "$bin/magic" *-ramdisk.gz | cut -d: -f2 | awk '{ print $1 }' > "$file-ramdiskcomp";
ramdiskcomp=`cat *-ramdiskcomp`;
unpackcmd="$ramdiskcomp -dc";
compext=$ramdiskcomp;
case $ramdiskcomp in
  gzip) compext=gz;;
  lz4) unpackcmd="$bin/lz4 -dq"; extra="stdout";;
  *) compext="";;
esac;
if [ "$compext" ]; then
  compext=.$compext;
fi;
mv "$file-ramdisk.gz" "$file-ramdisk.cpio$compext";
cd ..;

echo " ";
echo "Unpacking ramdisk to \"ramdisk/\"...";
echo " ";
cd ramdisk;
echo "Compression used: $ramdiskcomp";
if [ ! "$compext" ]; then
  abort;
  exit 1;
fi;
$unpackcmd "../split_img/$file-ramdisk.cpio$compext" $extra | cpio -i;
if [ ! $? -eq "0" ]; then
  abort;
  exit 1;
fi;

cd ..;

echo " ";
echo "Done!";
exit 0;

