#
# Copyright (C) 2016 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

LOCAL_PATH := device/huawei/hwgra

# OTA ASSERT
TARGET_OTA_ASSERT_DEVICE := hi3635,GRA-L09,hwgra,HWGRA,gra_l09,huawei_p8,ascend_p8,P8,grace,GRACE

# HARDWARE CLASS
BOARD_USES_CYANOGEN_HARDWARE := true
BOARD_HARDWARE_CLASS := \
    hardware/cyanogen/cmhw \
    $(LOCAL_PATH)/cmhw

# WEBGL
ENABLE_WEBGL := true

# LIGHTS
TARGET_PROVIDES_LIBLIGHT := true

# USE JAVA 8 (EXPERIMENTAL)
EXPERIMENTAL_USE_JAVA8 := true

# DEBUG
BOARD_EGL_NEEDS_HANDLE_VALUE := true
LOG_NDEBUG := 0

# BOOTLOADER
TARGET_BOOTLOADER_BOARD_NAME := hi3635
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

# BUTTONS
BOARD_HAS_NO_SELECT_BUTTON := true

# CHARGER
BOARD_CHARGER_DISABLE_INIT_BLANK := true
RED_LED_PATH := "/sys/class/leds/red/brightness"
GREEN_LED_PATH := "/sys/class/leds/green/brightness"
BLUE_LED_PATH :=  "/sys/class/leds/blue/brightness"
BACKLIGHT_PATH := "/sys/class/leds/lcd_backlight0/brightness"
HEALTHD_BACKLIGHT_LEVEL := 60

# STORAGE
BOARD_HAS_NO_REAL_SDCARD := false
BOARD_HAS_LARGE_FILESYSTEM := true
TARGET_USERIMAGES_USE_EXT4 := true
#TARGET_USERIMAGES_USE_F2FS := true

# CAMERA
USE_CAMERA_STUB := true
USE_DEVICE_SPECIFIC_CAMERA := true
#BOARD_CAMERA_HAVE_ISO := true
#COMMON_GLOBAL_CFLAGS += -DHAVE_ISO
#BOARD_GLOBAL_CFLAGS += -DCAMERA_VENDOR_L_COMPAT
#TARGET_HAS_LEGACY_CAMERA_HAL1 := true

# SCREEN
DEVICE_RESOLUTION := 1080x1920
BOARD_HAS_FLIPPED_SCREEN := false
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi
TARGET_USES_ION := true

# SURFACEFLINGER
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3

# NFC
TARGET_USES_NQ_NFC := true
BOARD_NFC_CHIPSET := pn547
NXP_CHIP_TYPE := 1

# GPU
TARGET_BOARD_GPU := mali-t628
TARGET_HARDWARE_3D := true
ANDROID_ENABLE_RENDERSCRIPT := true
USE_OPENGL_RENDERER := true
BOARD_EGL_CFG := $(LOCAL_PATH)/gpu/egl.cfg

# AUDIO
TARGET_PROVIDES_LIBAUDIO := true
BOARD_USES_ALSA_AUDIO := true
#BOARD_USES_TINY_ALSA_AUDIO := true
BOARD_USES_GENERIC_AUDIO := false
#BUILD_WITH_ALSA_UTILS := true
BOARD_SUPPORTS_SOUND_TRIGGER := true

# RIL
#COMMON_GLOBAL_CFLAGS += -DDISABLE_ASHMEM_TRACKING
#PROTOBUF_SUPPORTED := true
#TARGET_RIL_VARIANT := proprietary
BOARD_RIL_CLASS := ../../../$(LOCAL_PATH)/ril/

# WIFI
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WLAN_DEVICE := bcmdhd
BOARD_WLAN_DEVICE_REV := bcm4334
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
WIFI_DRIVER_NVRAM_PATH := "/vendor/firmware/nvram4334_hw.txt"
WIFI_DRIVER_FW_PATH_PARAM := "/sys/module/bcmdhd/parameters/firmware_path"
WIFI_DRIVER_FW_PATH_STA := "/system/vendor/firmware/fw_bcm4334_hw.bin"
WIFI_DRIVER_FW_PATH_AP := "/system/vendor/firmware/fw_bcm4334_apsta_hw.bin"
WIFI_BAND := 802_11_ABGN
WIFI_DRIVER_MODULE_ARG := "firmware_path=/system/vendor/firmware/fw_bcm4334_hw.bin nvram_path=/system/vendor/firmware/nvram4334_hw_fifa_ul.txt ifname=wlan0"
WIFI_DRIVER_MODULE_P2P := "firmware_path=/system/vendor/firmware/fw_bcm4334_apsta_hw.bin nvram_path=/system/vendor/firmware/nvram4334_hw_fifa_ul.txt ifname=wlan0"
WIFI_DRIVER_MODULE_AP_ARG := "firmware_path=/system/vendor/firmware/fw_bcm4334_apsta_hw.bin nvram_path=/system/vendor/firmware/nvram4334_hw_fifa_ul.txt ifname=wlan0"
BOARD_LEGACY_NL80211_STA_EVENTS := true
BOARD_NO_APSME_ATTR := true
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_CUSTOM_BT_CONFIG := $(LOCAL_PATH)/bluetooth/vnd_hwgra.conf

# CPU/ARCH
TARGET_ARCH := arm64
#TARGET_ARM_TYPE := arm64
TARGET_BOARD_PLATFORM := hi3635
BOARD_VENDOR_PLATFORM := hi3635
HISI_TARGET_PRODUCT := hi3635
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_VARIANT := cortex-a53
TARGET_CPU_CORTEX_A53 := true
TARGET_CPU_SMP := true
TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a53
#we have big.LITTLE architecture with 2 sets
ENABLE_CPUSETS := true
#Not sure
ARCH_ARM_HAVE_TLS_REGISTER := true
ARCH_ARM_HAVE_NEON := true
ARCH_ARM_HIGH_OPTIMIZATION := true
#ANDROID_64=true
TARGET_USES_64_BIT_BINDER := true
TARGET_IS_64_BIT := true
TARGET_USES_HISI_DTIMAGE := true
TARGET_SUPPORTS_32_BIT_APPS := true
TARGET_SUPPORTS_64_BIT_APPS := true

#TARGET_KERNEL_SOURCE --> Shared source... Well it's not...
#The kernel has harcoded stuff in it which requires the source to be named "kernel"
TARGET_KERNEL_SOURCE := kernel/huawei/kernel
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_KERNEL_CROSS_COMPILE_PREFIX := aarch64-linux-android-
BOARD_USES_UNCOMPRESSED_BOOT := true
BOARD_KERNEL_IMAGE_NAME := Image
TARGET_USES_UNCOMPRESSED_KERNEL := true
TARGET_KERNEL_CONFIG := merge_hi3635_defconfig
#HAVE_SELINUX := true

# KERNEL CONFIG
BOARD_KERNEL_CMDLINE := androidboot.hardware=hi3635 androidboot.selinux=permissive no_console_suspend=1 mem=3072M coherent_pool=512K mmcparts=mmcblk0:p1(vrl),p2(vrl_backup),p6(modemnvm_factory),p9(splash),p10(modemnvm_backup),p11(modemnvm_img),p12(modemnvm_system),p14(3rdmodemnvm),p15(3rdmodemnvmback),p17(modem_om),p20(modemnvm_update),p30(modem),p31(modem_dsp),p32(dfx),p33(3rdmodem) cpuidle_sysfs_switch=1
BOARD_KERNEL_BASE := 0x00678000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_MKBOOTIMG_ARGS := --kernel_offset 0x00008000 --ramdisk_offset 0x07588000 --tags_offset 0xffb88000

# PARTITIONS SIZES
BOARD_BOOTIMAGE_PARTITION_SIZE := 25165824
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 33554432
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2684354560
BOARD_USERDATAIMAGE_PARTITION_SIZE := 11448352768
BOARD_FLASH_BLOCK_SIZE := 4096

# SEPOLICY
# BOARD_SEPOLICY_DIRS := $(LOCAL_PATH)/sepolicy

# INIT
TARGET_PROVIDES_INIT_TARGET_RC := true
#TARGET_PROVIDES_INIT_RC := true

# PROPERTIES
TARGET_SYSTEM_PROP := $(LOCAL_PATH)/system.prop

TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/rootdir/fstab.hi3635
# RECOVERY (twrp breaks brunch, I won't build it but if you really want to... uncomment following two lines)
# RECOVERY_VARIANT := twrp
#-include $(LOCAL_PATH)twrp.mk

# FM RADIO
BOARD_HAVE_FM_RADIO := true
BOARD_FM_DEVICE := bcm4334
BOARD_GLOBAL_CFLAGS += -DHAVE_FM_RADIO

# BOOTANIMATION
TARGET_BOOTANIMATION_PRELOAD := true
TARGET_BOOTANIMATION_TEXTURE_CACHE := true

# TAP TO WAKE
TARGET_TAP_TO_WAKE_NODE := "/sys/touchscreen/wakeup_gesture_enable"

# inherit from the proprietary version
-include vendor/huawei/hwgra/BoardConfigVendor.mk
