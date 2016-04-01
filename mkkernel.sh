#!/bin/bash
#The source MUST be inside the kernel folder otherwise the kernel will not build!
KERNELDIR="$(pwd)/kernel/huawei/kernel"
KERNEL_NAME="CMKernel@Nexolight"
TMP_OUT="../outX"
OUTDIR="/tmp/hwgra-l09-kernel"
CROSS_COMPILE_PATH="$(pwd)/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android-"

if ls "$(pwd)/device/huawei/hwgra/" | grep BoardConfig.mk;then
	
	pushd "$KERNELDIR"	

	if [ -d $TMP_OUT ];then
		rm -rf $TMP_OUT
	fi
	mkdir $TMP_OUT
	
	if [ -d "$OUTDIR" ];then
		rm -rf "$OUTDIR"
	fi
	mkdir $OUTDIR
	export LC_MESSAGES=en_US
	export LOCALVERSION=$KERNEL_NAME
	export CROSS_COMPILE=$CROSS_COMPILE_PATH
	make clean
	make mrproper
	make ARCH=arm64 O=$TMP_OUT merge_hi3635_defconfig
	make -j"$(grep processor /proc/cpuinfo|wc -l)" ARCH=arm64 O=$TMP_OUT 
	mv $TMP_OUT "$OUTDIR"
	
	popd
else
	echo "Please run this script from the Cyanogenmod 13 Source"
fi

