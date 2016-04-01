#!/bin/bash
#by Nexolight 

VENDORNAME="huawei"
CODENAME="hwgra"
PFILES="device/$VENDORNAME/$CODENAME/proprietary-files6.0.txt"
USEADB=false

echo "###############################################"
echo "# Placing vendor blobs"
echo "# for $VENDORNAME $CODENAME"
echo "###############################################"

echo $PWD


VDIR="vendor/$VENDORNAME/$CODENAME"
DST="$VDIR/proprietary"


if [ -d $DST ];then
	echo "Cleaning up..."
	rm -rf $VDIR
fi
echo "Create output dir..."
mkdir -p $DST


if [ $USEADB = false ];then
	SOURCE="device/$VENDORNAME/$CODENAME/vendor6.0/system"
	echo "Source is $SOURCE"
	echo "assuming that it just contains the listed files!"
	echo "cp -r $SOURCE $DST"	
	cp -r $SOURCE/* $DST
	echo "done"
else
	echo "Source is adb"
	echo "Using: $PFILES"
	COUNT=0
	SOURCE="system"
	for VBLOB in $(grep -v -E "(^\s*?#.*$)|(^\s*$)" $PFILES);do
		if [ -d $VBLOB ];then
			VBLOB="$VBLOB/."
		fi	
		echo "adb pull $SOURCE/$VBLOB $DST/$VBLOB"
		if $(adb pull $SOURCE/$VBLOB $DST/$VBLOB);then
			COUNT=$(($COUNT+1))
		fi
	done
	echo "###############################################"
	echo "# Copied $COUNT blobs"
	echo "###############################################"	
fi	
echo "calling setup-makefiles.sh now"
device/$VENDORNAME/$CODENAME/setup-makefiles.sh $VENDORNAME $CODENAME $VDIR $PFILES
