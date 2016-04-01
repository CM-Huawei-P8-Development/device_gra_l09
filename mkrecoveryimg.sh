#!/bin/bash
if ls device/huawei/hwgra/ | grep BoardConfig.mk;then
	echo "Building recoveryimage"
	export LC_MESSAGES=en_US
	export CROSS_COMPILE="$(pwd)/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android-"
	make clean
	make clobber
	make -C kernel/huawei/kernel mrproper
	source build/envsetup.sh && lunch cm_hwgra-eng && mka recoveryimage
else
	echo "Please run this script from the Cyanogenmod 13 Source"
fi
