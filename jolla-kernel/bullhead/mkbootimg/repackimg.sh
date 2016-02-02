#!/sbin/sh
# AIK-Linux/repackimg: repack ramdisk and build image
# osm0sis @ xda-developers

abort() { cd "$aik"; echo "Error!"; }

aik="/tmp/";
bin="$aik/bin";
chmod -R 755 "$bin" "$aik"/*.sh;
chmod 644 "$bin/magic";
cd "$aik";

if [ -z "$(ls split_img/* 2> /dev/null)" -o -z "$(ls ramdisk/* 2> /dev/null)" ]; then
  echo "No files found to be packed/built.";
  abort;
  exit 1;
fi;

clear;
echo " ";
echo "Android Image Kitchen - RepackImg Script";
echo "by osm0sis @ xda-developers";
echo " ";

if [ ! -z "$(ls *-new.* 2> /dev/null)" ]; then
  echo "Warning: Overwriting existing files!";
  echo " ";
fi;

rm -f ramdisk-new.cpio*;
case $1 in
  --original)
    echo "Repacking with original ramdisk...";;
  --level|*)
    echo "Packing ramdisk...";
    echo " ";
    if [ "$1" = "--level" -a "$2" ]; then
      level="-$2";
      lvltxt=" - Level: $2";
    fi;
    echo "Using lz4 compression: $lvltxt";
    compext=lz4;
    repackcmd="$bin/lz4 $level -l stdin stdout 2> /dev/null";
    cd ramdisk;
    find . | cpio -H newc -o 2> /dev/null | $repackcmd > ../ramdisk-new.cpio.$compext;

    if [ ! $? -eq "0" ]; then
      abort;
      exit 1;
    fi;
    cd "$aik";;
esac;

echo " ";
echo "Getting build information...";
cd split_img;
kernel=`ls *-zImage`;               echo "kernel = $kernel";
if [ "$1" = "--original" ]; then
  ramdisk=`ls *-ramdisk.cpio*`;     echo "ramdisk = $ramdisk";
  ramdisk="split_img/$ramdisk";
else
  ramdisk="ramdisk-new.cpio.$compext";
fi;
cmdline=`cat *-cmdline`;            echo "cmdline = $cmdline";
board=`cat *-board`;                echo "board = $board";
base=`cat *-base`;                  echo "base = $base";
pagesize=`cat *-pagesize`;          echo "pagesize = $pagesize";
kerneloff=`cat *-kerneloff`;        echo "kernel_offset = $kerneloff";
ramdiskoff=`cat *-ramdiskoff`;      echo "ramdisk_offset = $ramdiskoff";
tagsoff=`cat *-tagsoff`;            echo "tags_offset = $tagsoff";
if [ -f *-second ]; then
  second=`ls *-second`;             echo "second = $second";
  second="--second split_img/$second";
  secondoff=`cat *-secondoff`;      echo "second_offset = $secondoff";
  secondoff="--second_offset $secondoff";
fi;
if [ -f *-dtb ]; then
  dtb=`ls *-dtb`;                   echo "dtb = $dtb";
  dtb="--dt split_img/$dtb";
fi;
cd ..;

echo " ";
echo "Building image...";
echo " ";
"$bin/mkbootimg" --kernel "split_img/$kernel" --ramdisk "$ramdisk" $second --cmdline "$cmdline" --board "$board" --base $base --pagesize $pagesize --kernel_offset $kerneloff --ramdisk_offset $ramdiskoff $secondoff --tags_offset $tagsoff $dtb -o image-new.img;
if [ ! $? -eq "0" ]; then
  abort;
  exit 1;
fi;

echo "Done!";
exit 0;

