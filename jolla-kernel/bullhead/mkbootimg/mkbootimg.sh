#!/sbin/sh
echo \#!/sbin/sh > /tmp/createnewboot.sh

cd /tmp/

cmdline=`cat *-cmdline`;
board=`cat *-board`;
base=`cat *-base`;
pagesize=`cat *-pagesize`;
kerneloff=`cat *-kerneloff`;
ramdiskoff=`cat *-ramdiskoff`;
tagsoff=`cat *-tagsoff`;
if [ -f *-second ]; then
  second=`ls *-second`;
  second="--second /tmp/$second";
  secondoff=`cat *-secondoff`;
  secondoff="--second_offset $secondoff";
fi;
if [ -f /tmp/anykernel/zImage ]; then
  kernel=/tmp/anykernel/zImage;
else
  kernel=`ls *-zImage`;
  kernel=$split_img/$kernel;
fi;
if [ -f /tmp/dtb ]; then
  dtb="--dt /tmp/dtb";
elif [ -f *-dtb ]; then
  dtb=`ls *-dtb`;
  dtb="--dt /tmp/$dtb";
fi;

chmod 777 /tmp/mkbootimg
/tmp/mkbootimg --kernel /tmp/zImage --ramdisk /tmp/newramdisk.cpio.gz $second --cmdline "$cmdline" --board "$board" --base $base --pagesize $pagesize --kernel_offset $kerneloff --ramdisk_offset $ramdiskoff $secondoff --tags_offset $tagsoff $dtb --output /tmp/newboot.img

return $?
