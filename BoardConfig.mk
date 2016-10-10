# inherit from the proprietary version
-include vendor/huawei/hwgra/BoardConfigVendor.mk


#Assert
TARGET_OTA_ASSERT_DEVICE := hwgra,gra_l09,huawei_p8,ascend_p8,p8,grace

#Xtras
#TARGET_SPECIFIC_HEADER_PATH := device/huawei/include
#BOARD_HARDWARE_CLASS += device/huawei/cmhw


# Enable WebGL
ENABLE_WEBGL := true


#Lights
TARGET_PROVIDES_LIBLIGHT := true


#Build
DEVICE_FOLDER = device/huawei/hwgra
TARGET_BUILD_VARIANT = eng
TARGET_BUILD_TYPE = debug


#Debug:
BOARD_EGL_NEEDS_HANDLE_VALUE=true
LOG_NDEBUG=0


#Bootloader
TARGET_NO_BOOTLOADER := true
TARGET_BOOTLOADER_BOARD_NAME := hwgra


#Buttons
BOARD_HAS_NO_SELECT_BUTTON := true


#Stroage
BOARD_HAS_NO_REAL_SDCARD := false
BOARD_HAS_LARGE_FILESYSTEM := true
TARGET_USERIMAGES_USE_EXT4 := true


#Camera
USE_CAMERA_STUB := true


#Screen
DEVICE_RESOLUTION := 1080x1920
BOARD_HAS_FLIPPED_SCREEN := false


#It may complain about a missing font without this but I fixed it somehow else:
#PRODUCT_AAPT_PREF_CONFIG := xxhdpi


#GPU
TARGET_BOARD_GPU := mali-t628
TARGET_HARDWARE_3D := true
ANDROID_ENABLE_RENDERSCRIPT := true
USE_OPENGL_RENDERER := true
BOARD_EGL_CFG := device/huawei/hwgra/gpu/egl.cfg
#BOARD_PROVIDES_ADDITIONAL_BIONIC_STATIC_LIBS += shim_libs


#Audio
#TARGET_PROVIDES_LIBAUDIO := true
BOARD_USES_ALSA_AUDIO := true
BOARD_USES_TINY_ALSA_AUDIO := true
BOARD_USES_GENERIC_AUDIO := false
BUILD_WITH_ALSA_UTILS := true

#RIL
#BOARD_RIL_CLASS := device/huawei/hwgra/ril/


#Netowrk
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WLAN_DEVICE := bcmdhd
BOARD_WLAN_DEVICE_REV := bcm4334
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
#WPA_SUPPLICANT_VERSION := VER_2_0_X
WIFI_DRIVER_NVRAM_PATH := /vendor/firmware/nvram4334_hw.txt
WIFI_DRIVER_FW_PATH_PARAM := /sys/module/bcmdhd/parameters/firmware_path
WIFI_DRIVER_FW_PATH_STA := /system/vendor/firmware/fw_bcm4334_hw.bin
WIFI_DRIVER_FW_PATH_AP := /system/vendor/firmware/fw_bcm4334_apsta_hw.bin
WIFI_BAND := 802_11_ABGN
WIFI_DRIVER_MODULE_NAME := bcmdhd
WIFI_DRIVER_MODULE_PATH := auto
WIFI_DRIVER_MODULE_ARG := "firmware_path=/system/vendor/firmware/fw_bcm4334_hw.bin nvram_path=/system/vendor/firmware/nvram4334_hw.txt ifname=wlan0"
WIFI_DRIVER_MODULE_AP_ARG := "firmware_path=/system/vendor/firmware/fw_bcm4334_apsta_hw.bin nvram_path=/system/vendor/firmware/nvram4334_hw.txt ifname=wlan0"
BOARD_LEGACY_NL80211_STA_EVENTS := true
BOARD_NO_APSME_ATTR := true
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_CUSTOM_BT_CONFIG := device/huawei/hwgra/bluetooth/vnd_hwgra.conf


#CPU/ARCH
TARGET_ARCH := arm64
TARGET_BOARD_PLATFORM := hi3635
TARGET_CPU_ABI := arm64-v8a
#TARGET_CPU_ABI2 := armeabi-v7a,armeabi
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_VARIANT := generic
#TARGET_CPU_CORTEX_A53 := true
TARGET_CPU_SMP := true
TARGET_2ND_ARCH := arm
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_VARIANT := cortex-a15
#TARGET_GLOBAL_CFLAGS += -mcpu=cortex-a15 -mfpu=neon
#TARGET_GLOBAL_CPPFLAGS += -mcpu=cortex-a15 -mfpu=neon
#TARGET_GLOBAL_CFLAGS += --target=aarch64-arm-none-eabi -mcpu=cortex-a53
#TARGET_2ND_GLOBAL_CFLAGS += --target=armv8a-arm-none-eabi -mcpu=cortex-a53
ARCH_ARM_HAVE_TLS_REGISTER := true


# 64 bit
TARGET_USES_64_BIT_BINDER := true
TARGET_IS_64_BIT := true
TARGET_USES_HISI_DTIMAGE := true
TARGET_SUPPORTS_32_BIT_APPS := true
TARGET_SUPPORTS_64_BIT_APPS := true


#Kernelname
KBUILD_BUILD_USER="morphkernel_r002"
KBUILD_BUILD_HOST="the-flux"
#TARGET_PREBUILT_KERNEL := device/huawei/hwgra/kernel #After building it from source to save time
TARGET_KERNEL_SOURCE := kernel/huawei/kernel
#TARGET_KERNEL_SOURCE --> Shared source... Well it's not...
#The kernel has harcoded stuff in it which requires the source to be named "kernel"
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_KERNEL_CROSS_COMPILE_PREFIX := aarch64-linux-android-
BOARD_USES_UNCOMPRESSED_BOOT := true
BOARD_KERNEL_IMAGE_NAME := Image
TARGET_USES_UNCOMPRESSED_KERNEL := true

#TARGET_KERNEL_CONFIG := malimerge_hi3635_defconfig
TARGET_KERNEL_CONFIG :=merge_hi3635_defconfig
#VARIANT_DEFCONFIG := hisi_3635_defconfig
#TARGET_KERNEL_CONFIG := morph_hi3635_defconfig
HAVE_SELINUX := true


#Kernel Config
#BOARD_KERNEL_CMDLINE := enforcing=0 androidboot.selinux=permissive mem=3072M mmcparts=mmcblk0:p1(vrl),p2(vrl_backup),p6(modemnvm_factory),p9(splash),p10(modemnvm_backup),p11(modemnvm_img),p12(modemnvm_system),p14(3rdmodemnvm),p15(3rdmodemnvmback),p17(modem_om),p20(modemnvm_update),p30(modem),p31(modem_dsp),p32(dfx),p33(3rdmodem)
BOARD_KERNEL_CMDLINE := androidboot.hardware=hi3635 enforcing=0 androidboot.selinux=permissive no_console_suspend=1 mem=3072M coherent_pool=512K mmcparts=mmcblk0:p1(vrl),p2(vrl_backup),p6(modemnvm_factory),p9(splash),p10(modemnvm_backup),p11(modemnvm_img),p12(modemnvm_system),p14(3rdmodemnvm),p15(3rdmodemnvmback),p17(modem_om),p20(modemnvm_update),p30(modem),p31(modem_dsp),p32(dfx),p33(3rdmodem)
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
#BOARD_SEPOLICY_DIRS += device/huawei/hwgra/sepolicy_cmmerge #They are the result of a substraction from the stock lines and CM13 lines
BOARD_SEPOLICY_DIRS := device/huawei/hwgra/sepolicy_ucmt
#Union is no longer required https://android-review.googlesource.com/#/c/141560/ as its the new default.


POLICYVERS = 28
#CM 13 would use v30 which freezes because of the kernel - v26 (maybe v28) works with the 3.10.61 kernel  

#init
TARGET_PROVIDES_INIT := true
TARGET_PROVIDES_INIT_TARGET_RC := true

#add props
ADDITIONAL_DEFAULT_PROPERTIES += \
	ro.adb.secure=0 \
	ro.secure=0 \
	ro.debuggable=1 \
	ro.allow.mock.location=1 \
	persist.sys.root_access=3 \
	ro.zygote=zygote64_32 \
	persist.logd.logpersistd=logcatd \
	sys.init_log_level=3

ADDITIONAL_BUILD_PROPERTIES += \
	debug.composition.type=cpu \
	qemu.hw.mainkeys=0 \
	ro.config.mmu_en=1 \
	dalvik.vm.heapsize=256m \
	ro.opengles.version=196609 \
	ro.sf.lcd_density=480 \
	hw.lcd.density=480 \
	sys.config.jankenable=true \
	persist.sys.strictmode.disable=true \
	ro.bt.bdaddr_path=/data/misc/bluedroid/macbt \
	ro.config.keypasstouser=true \
	ro.config.hw_navigationbar=true \
	ro.config.hw_sensorhub=true \
	ro.balong_debug.port_num=8 \
	ro.product.platform.pseudonym=1ARB9CV \
	ro.hwui.texture_cache_size=48 \
	ro.hwui.texture_cache_flushrate=0.4 \
	ro.hwui.layer_cache_size=48 \
	ro.hwui.path_cache_size=32 \
	ro.hwui.shape_cache_size=2 \
	ro.hwui.drop_shadow_cache_size=6 \
	ro.hwui.gradient_cache_size=1 \
	ro.hwui.text_large_cache_height=1024 \
	ro.hwui.text_large_cache_width=2048 \
	ro.hwui.text_small_cache_height=1024 \
	ro.hwui.text_small_cache_width=1024 \
	ro.hwui.r_buffer_cache_size=8 \
	debug.hwui.render_dirty_regions=false \
	ro.config.hw_music_lp=true \
	keyguard.no_require_sim=true \
	hw.enterinto.imm_chat.scene=false \
	bastet.service.enable=true \
	ro.config.hw_emerg=on \
	ro.sys.umsdirtyratio=2 \
	ro.product.cpuinfo.normal=HisiliconKirin930 \
	ro.product.cpuinfo.high=HisiliconKirin935 \
	ro.product.cpuinfo.highhigh=HisiliconKirin935 \
	ro.config.hw_enable_merge=true \
	ro.config.helix_enable=true \
	ro.config.huawei_smallwindow=505,197,1065,1257 \
	ro.config.hw.security_volume=8 \
	ro.config.hw_eapsim=true \
	ro.config.hw_multiscreen=true \
	ro.config.hw_omacp=1 \
	ro.config.hw_privacymode=true \
	ro.config.hw_RemindWifiToPdp=false \
	ro.config.hw_simpleui_enable=1 \
	ro.config.hw_singlehand=1 \
	ro.config.hw_vcardBase64=true \
	ro.config.hwinternet_audio=1 \
	ro.config.switchPrimaryVolume=true \
	ro.huawei.cust.oma=false \
	ro.huawei.cust.oma_drm=false \
	ro.config.hwtheme=0 \
	ro.config.hw_allow_rs_mms=true \
	ro.config.hw_hungtasklist=whitelist,system_server,SurfaceFlinger \
	ro.config.fm_type=libbcmfm_if \
	persist.radio.apm_sim_not_pwdn=1 \
	persist.service.tm2.tofile=true \
	persist.sys.dualcards=false \
	ril.hw_modem0.rssi=-1 \
	ril.hw_modem1.rssi=-1 \
	ro.cellbroadcast.emergencyids=0-65534 \
	ro.config.delay_send_signal=true \
	ro.config.hw_accesscontrol=true \
	ro.config.hw_disable_cops=true \
	ro.config.hw_ecclist_nocard=1+110,6+119,8+118 \
	ro.config.hw_ecclist_withcard=1+110,6+119,8+118 \
	ro.config.hw_globalEcc=true \
	ro.config.hw_useCtrlSocket=true \
	ro.config.updatelocation=true \
	ro.networkstatus.delaytimer=6 \
	ro.check.modem_network=true \
	ro.config.dsds_mode=umts \
	persist.radio.modem.cap=89894 \
	persist.dsds.enabled=false \
	rild.rild1_ready_to_start=false \
	rild.libpath=/system/lib64/libbalong-ril.so \
	ro.config.hw_dsda=false \
	ro.multi.rild=false \
	rild.libargs=-mmodem0 \
	ro.telephony.default_network=9 \
	ro.config.bluetooth.name=HuaweiP8\
	ro.config.attach_apn_enabled=true \
	ro.config.hw_lte_support=true \
	ro.config.hw_show_network_icon=true \
	net.tethering.noprovisioning=true \
	ro.cofig.onlinemusic.enabled=false \
	ro.cofig.onlinevideo.enabled=false \
	ro.config.hw_floatvideo=false \
	ro.config.hw_ReduceSAR=true \
	ro.config.hw_use_browser_ua=http://wap1.huawei.com/uaprof/HUAWEI_GRA_L09_UAProfile.xml \
	ro.setupwizard.mode=DISABLED \
	ro.config.calendarsound=Step.ogg \
	ro.config.hw_nfc_on=false \
	ro.config.hw_nfc_msimce=false \
	ro.config.hw_hotswap_on=true \
	ro.dual.sim.phone=false \
	ro.config.hw_sim2airplane=false \
	ro.config.show_sim_icon=true \
	ro.config.soundtrigger_enabled=0 \
	ro.huawei.flag.oma_reboot=true \
	ro.config.messagesound=Whisper.ogg \
	ro.config.linkplus.roaming=false \
	ro.com.google.clientidbase.am=android-huawei \
	ro.com.google.clientidbase.gmm=android-huawei \
	ro.com.google.clientidbase.ms=android-huawei \
	ro.com.google.clientidbase.yt=android-huawei \
	ro.config.spare_ntp_server=ntp.sjtu.edu.cn,time.windows.com,time.nist.gov,1.cn.pool.ntp.org \
	ro.config.hw_channel_info=0,0,0,0 \
	ro.product.hardwareversion=HL2UGRACEM \
	ro.config.support_ca=false \
	ro.product.varprofile.base=L09 \
	ro.config.hw_cp_showagree=true \
	ro.product.varprofile.highhigh=L09 \
	ro.product.varprofile=true \
	ro.config.hw_ECT=true \
	ro.config.hw_rcs_product=true \
	audioril.lib=libhuawei-audio-ril.so

#ro.boardid.product:
#eighter 6238 or 5844 both contain "GRACE" which is a code in the origin build.props
#pretty sure it is 5844 because it contains nfc related stuff which the p8 has

#ro.hardware
#is made from /proc/cpuinfo

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
#BOARD_CUSTOM_GRAPHICS := device/huawei/hwgra/recovery/twrp-graphics.c
STE_HARDWARE := true #Not sure if needed
TW_BRIGHTNESS_PATH := /sys/devices/platform/hisi_fb.1048577/leds/lcd_backlight0/brightness
#TW_CUSTOM_BATTERY_PATH
TWRP_INCLUDE_LOGCAT := true
TW_MAX_BRIGHTNESS := 255
TW_DEFAULT_BRIGHTNESS := 255
TWRP_INCLUDE_LOGCAT := true
RECOVERY_GRAPHICS_USE_LINELENGTH := true
#in vendor recovery it is RGB565
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
#TARGET_RECOVERY_FSTAB := device/huawei/hwgra/recovery/twrp.fstab twrp already handles this


