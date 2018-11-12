#!/sbin/sh
# AIK-Linux/unpackimg: split image and unpack ramdisk
# osm0sis @ xda-developers

cleanup() { rm -rf ramdisk split_img *new.*; }
abort() { cd "$aik"; echo "Error!"; }

# replace_file <old file> <new file> (preserving metadata)
# replace a file, preserving metadata (using cat)
replace_file() {
	cat "$2" > "$1" || return
	rm -f "$2"
}

# remove_service <service name>
# this comments out a service entry entirely, as well as commands referencing it
remove_service() {
	for rc in "$ramdisk"/*.rc; do
		grep -q "^[[:space:]]*\(service\|start\|stop\|restart\)[[:space:]]\+$1\b" "$rc" || continue
		echo "Found service $1 in $rc"
		awk -vsc_name="$1" '
			!NF || $1 ~ /^#/ { print; next }
			$1 == "service" || $1 == "on" { in_sc = 0 }
			$1 == "service" && $2 == sc_name { in_sc = 1 }
			in_sc || ($2 == sc_name && ($1 == "start" || $1 == "stop" || $1 == "restart")) { printf "#" }
			{ print }
		' "$rc" > "$rc-"
		replace_file "$rc" "$rc-"
	done
}

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

echo "Removing LG root checker rctd service...";
rm -f sbin/rctd;
remove_service rctd;

echo "Cleanup triton service...";
remove_service triton;
sed -i '/start\ triton/d' $aik/ramdisk/init.joan.power.rc;
sed -i '/\/sys\/devices\/system\/cpu\/triton\//d' $aik/ramdisk/init.joan.power.rc;

echo "Cleanup cpu_boost...";
sed -i '/\/sys\/module\/cpu_boost\//d' $aik/ramdisk/init.joan.power.rc;

echo " ";
echo "Done!";
exit 0;

