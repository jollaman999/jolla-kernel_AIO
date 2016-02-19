#!/sbin/sh

aik="/tmp/";

cd "$aik";
cd ramdisk;

# restore init
if [ -e main_init ] ; then
    rm init;
    mv main_init init;
fi;
chmod 750 init;

# Remove mrom.fstab
if [ -e mrom.fstab ] ; then
    rm mrom.fstab;
fi;

# Remove encryption files
rm -rf mrom_enc;

cd ..;

echo " ";
echo "Done!";
exit 0;

