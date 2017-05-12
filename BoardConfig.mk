#Assert
TARGET_OTA_ASSERT_DEVICE := hi3635,GRA-L09,hwgra,HWGRA,gra_l09,huawei_p8,ascend_p8,P8,grace,GRACE

LOCAL_PATH := device/huawei/hwgra

#CM Hardware abstraction
BOARD_USES_CYANOGEN_HARDWARE := true
BOARD_HARDWARE_CLASS := \
    hardware/cyanogen/cmhw \
    $(LOCAL_PATH)/cmhw


#WebGL
ENABLE_WEBGL := true


#Lights
TARGET_PROVIDES_LIBLIGHT := true


#Build
DEVICE_FOLDER = device/huawei/hwgra

#USE JAVA 8 (EXPERIMENTAL)
EXPERIMENTAL_USE_JAVA8 := true

#DEBUG
BOARD_EGL_NEEDS_HANDLE_VALUE := true
LOG_NDEBUG := 0

#Bootloader
TARGET_BOOTLOADER_BOARD_NAME := hi3635
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

#Buttons
BOARD_HAS_NO_SELECT_BUTTON := true

#Charger
BOARD_CHARGER_DISABLE_INIT_BLANK := true
RED_LED_PATH := "/sys/class/leds/red/brightness"
GREEN_LED_PATH := "/sys/class/leds/green/brightness"
BLUE_LED_PATH :=  "/sys/class/leds/blue/brightness"
BACKLIGHT_PATH := "/sys/class/leds/lcd_backlight0/brightness"
HEALTHD_BACKLIGHT_LEVEL := 60

#Stroage
BOARD_HAS_NO_REAL_SDCARD := false
BOARD_HAS_LARGE_FILESYSTEM := true
TARGET_USERIMAGES_USE_EXT4 := true


#Camera
USE_CAMERA_STUB := true
USE_DEVICE_SPECIFIC_CAMERA := true
#BOARD_CAMERA_HAVE_ISO := true
#BOARD_GLOBAL_CFLAGS += -DCAMERA_VENDOR_L_COMPAT
#TARGET_HAS_LEGACY_CAMERA_HAL1 := true


#Screen
TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH := 1080
DEVICE_RESOLUTION := 1080x1920
BOARD_HAS_FLIPPED_SCREEN := false
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi
TARGET_USES_ION := true

# Surfaceflinger
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3

#NFC
TARGET_USES_NQ_NFC := true
BOARD_NFC_CHIPSET := pn547
NXP_CHIP_TYPE := 1

#GPU
TARGET_BOARD_GPU := mali-t628
TARGET_HARDWARE_3D := true
ANDROID_ENABLE_RENDERSCRIPT := true
USE_OPENGL_RENDERER := true
BOARD_EGL_CFG := $(LOCAL_PATH)/gpu/egl.cfg


#Audio
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

#Netowrk
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


#CPU/ARCH
TARGET_ARCH := arm64

TARGET_BOARD_PLATFORM := hi3635
TARGET_CPU_ABI := arm64-v8a
#TARGET_CPU_ABI2 := armeabi-v7a,armeabi
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_VARIANT := cortex-a53
TARGET_CPU_CORTEX_A53 := true
TARGET_CPU_SMP := true
TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
#Technically it msut be cortex-a53e.cortex-a53 
#Huawei used a second overclocked cortex-a53 set in a big.LITTLE setup
#and called the overclocked version cortex-a53e
TARGET_2ND_CPU_VARIANT := cortex-a53
#we have big.LITTLE architecture with 2 sets
ENABLE_CPUSETS := true
#Not sure
ARCH_ARM_HAVE_TLS_REGISTER := true


# 64 bit
ARCH_ARM_HAVE_NEON := true
ARCH_ARM_HIGH_OPTIMIZATION := true
BOARD_VENDOR_PLATFORM := hi3635
HISI_TARGET_PRODUCT := hi3635
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

TARGET_KERNEL_CONFIG :=merge_hi3635_defconfig
HAVE_SELINUX := true

#Kernel Config
BOARD_KERNEL_CMDLINE := androidboot.hardware=hi3635 androidboot.selinux=permissive no_console_suspend=1 mem=3072M coherent_pool=512K mmcparts=mmcblk0:p1(vrl),p2(vrl_backup),p6(modemnvm_factory),p9(splash),p10(modemnvm_backup),p11(modemnvm_img),p12(modemnvm_system),p14(3rdmodemnvm),p15(3rdmodemnvmback),p17(modem_om),p20(modemnvm_update),p30(modem),p31(modem_dsp),p32(dfx),p33(3rdmodem) cpuidle_sysfs_switch=1
BOARD_KERNEL_BASE := 0x00678000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_MKBOOTIMG_ARGS := --kernel_offset 0x00008000 --ramdisk_offset 0x07588000 --tags_offset 0xffb88000


#Partition sizes
BOARD_BOOTIMAGE_PARTITION_SIZE := 25165824
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 33554432
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2684354560
BOARD_USERDATAIMAGE_PARTITION_SIZE := 11448352768
#had a hard time finding this out. cat /proc/mtd - the erasesize column contains this size as hexadecimal value
#so mine is 00001000 (0x00001000) = 4096.
BOARD_FLASH_BLOCK_SIZE := 4096


#SEpolicy
#BOARD_SEPOLICY_DIRS += $(LOCAL_PATH)/sepolicy_cmmerge #They are the result of a substraction from the stock lines and CM13 lines
BOARD_SEPOLICY_DIRS := $(LOCAL_PATH)/sepolicy
#Union is no longer required https://android-review.googlesource.com/#/c/141560/ as its the new default.

#init
TARGET_PROVIDES_INIT_TARGET_RC := true
TARGET_SYSTEM_PROP := $(LOCAL_PATH)/system.prop


PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.root_access=3

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.root_access=3
    #ro.build.selinux=0 \

ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.config.hw_perfhub=true \
    ro.adb.secure=0 \
    ro.secure=0 \
    ro.debuggable=1 \
    ro.allow.mock.location=1 \
    persist.sys.root_access=3 \
    ro.zygote=zygote64_32 \
    persist.logd.logpersistd=logcatd \
    sys.init_log_level=3

#TWRP
RECOVERY_VARIANT := twrp
TWHAVE_SELINUX := false
BOARD_TOUCH_RECOVERY := true
TW_THEME := portrait_hdpi
TW_NO_BATT_PERCENT := false
TW_NO_REBOOT_BOOTLOADER := false
TW_NO_REBOOT_RECOVERY := false
TW_NO_USB_STORAGE := false
TW_NO_BATT_PERCENT := false
TW_NO_CPU_TEMP := false
TW_HAS_NO_RECOVERY_PARTITION := false
TW_HAS_NO_BOOT_PARTITION := false
TWRP_EVENT_LOGGING := false
#BOARD_CUSTOM_GRAPHICS := $(LOCAL_PATH)/recovery/twrp-graphics.c
STE_HARDWARE := true #Not sure if needed
TW_BRIGHTNESS_PATH := /sys/devices/platform/hisi_fb.1048577/leds/lcd_backlight0/brightness
TW_CUSTOM_BATTERY_PATH := /sys/class/power_supply/Battery
TWRP_INCLUDE_LOGCAT := true
TW_MAX_BRIGHTNESS := 255
TW_DEFAULT_BRIGHTNESS := 255
TWRP_INCLUDE_LOGCAT := true
RECOVERY_GRAPHICS_USE_LINELENGTH := true
#in vendor recovery it is RGB565
#TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"  
#TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888" 
#TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/ramdisk6.0/etc/fstab.hi3635 
#this is required to avoid unresponsive touch at boot until screen timeout 
TW_SCREEN_BLANK_ON_BOOT := true 
RECOVERY_SDCARD_ON_DATA := true

# FM Radio
BOARD_HAVE_FM_RADIO := true
BOARD_FM_DEVICE := bcm4334

# BOOTANIMATION
TARGET_BOOTANIMATION_PRELOAD := true
TARGET_BOOTANIMATION_TEXTURE_CACHE := true

#BOARD
BOARD_VENDOR := huawei
PRODUCT_GMS_CLIENTID_BASE := android-huawei

# TAP TO WAKE
TARGET_TAP_TO_WAKE_NODE := "/sys/touchscreen/wakeup_gesture_enable"

# inherit from the proprietary version
-include vendor/huawei/hwgra/BoardConfigVendor.mk







