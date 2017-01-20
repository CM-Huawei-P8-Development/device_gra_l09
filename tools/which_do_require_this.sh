#!/bin/bash
#
# uses aarch64-linux-android-readelf
#
# $1 lib name
# $2 search from this folder

echo "Looking for libraries which require $1 in $2"

FILES=$(find $2);
for f in $FILES;do
	if [ -f $f ];then
		DEPS=$(aarch64-linux-android-readelf -d $f 2>&1)
		if echo "$DEPS" | grep -s $1 &>/dev/null;then
			echo $f
		fi
	fi 
done
echo "Done"
