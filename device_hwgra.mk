$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

$(call inherit-product-if-exists, vendor/huawei/hwgra/hwgra-vendor.mk)

PRODUCT_PACKAGE_OVERLAYS += \
	device/huawei/hwgra/overlay


ifeq ($(TARGET_PREBUILT_KERNEL),)
	LOCAL_KERNEL := device/huawei/hwgra/kernel
else
	LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif


#HWC workaround - this is CM13 source used as shim lib
#in order to keep the compatibility to the rest since
#in the stock version a few symbols are missing.
#I could not use any shim lib since the problem was 
#a segfault caused by any internal function.
#libgui was just a dependency of surfaceflinger
#which was also replaced.
PRODUCT_PACKAGES += libshim_gui

#Lights
PRODUCT_PACKAGES += lights.hi3635

#Audio
PRODUCT_PACKAGES += \
	audio.a2dp.default \
	audio.usb.default \
	audio.r_submix.default

#Sensors
#Huawei changed stuff here and the defaults do in fact
#not work without further changes.
#So we take their libraries for the moment
#PRODUCT_PACKAGES += \
#	sensorservice \
#	sensors.default \
#	sensorhub.default \
#	sensorcaps.default

#?
PRODUCT_PACKAGES += \
	flp.default

PRODUCT_PACKAGES += \
	com.android.nfc_extras \
	com.nxp.nfc.nq \
	nfc_nci.pn54x.default \
	NQNfcNci \
	nqnfcee_access.xml \
	nqnfcse_access.xml \
	Tagf

#WIFI
PRODUCT_PACKAGES += \
	libwpa_client \
	wpa_supplicant \
	hostapd \
	wificond \
	wifilogd 

#Bluetooth Missing xml files after build
#That's probably not the propper way to do it!
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/bluetooth/bt_vendor.conf:system/etc/bluetooth/bt_vendor.conf \

#Audio config
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/audio/audio_policy.conf:system/etc/audio_policy.conf

#The built kernel
PRODUCT_COPY_FILES += $(LOCAL_KERNEL):kernel

#This will be used as /etc/recovery.fstab only for twrp
PRODUCT_COPY_FILES += $(LOCAL_PATH)/recovery/twrp.fstab:recovery/root/etc/twrp.fstab

# NFC
PRODUCT_COPY_FILES += \
frameworks/native/data/etc/com.nxp.mifare.xml:system/etc/permissions/com.nxp.mifare.xml \
frameworks/native/data/etc/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml \
frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
frameworks/native/data/etc/android.hardware.nfc.hce.xml:system/etc/permissions/android.hardware.nfc.hce.xml \
packages/apps/Nfc/migrate_nfc.txt:system/etc/updatecmds/migrate_nfc.txt \
$(LOCAL_PATH)/nfc/libnfc-nxp_grace.conf:system/etc/libnfc-nxp.conf \
$(LOCAL_PATH)/nfc/libnfc-brcm_grace.conf:system/etc/libnfc-brcm.conf \

#I'm sick of that don't want to copy all manually but they aren't device specific anyway
#Most of them could be copied from the build system.
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/permissions/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
	$(LOCAL_PATH)/permissions/android.hardware.camera.external.xml:system/etc/permissions/android.hardware.camera.external.xml \
	$(LOCAL_PATH)/permissions/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
	$(LOCAL_PATH)/permissions/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
	$(LOCAL_PATH)/permissions/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
	$(LOCAL_PATH)/permissions/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
	$(LOCAL_PATH)/permissions/android.hardware.location.xml:system/etc/permissions/android.hardware.location.xml \
	$(LOCAL_PATH)/permissions/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
	$(LOCAL_PATH)/permissions/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
	$(LOCAL_PATH)/permissions/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
	$(LOCAL_PATH)/permissions/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
	$(LOCAL_PATH)/permissions/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
	$(LOCAL_PATH)/permissions/android.hardware.sensor.stepcounter.xml:system/etc/permissions/android.hardware.sensor.stepcounter.xml \
	$(LOCAL_PATH)/permissions/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
	$(LOCAL_PATH)/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
	$(LOCAL_PATH)/permissions/android.hardware.touchscreen.multitouch.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.xml \
	$(LOCAL_PATH)/permissions/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
	$(LOCAL_PATH)/permissions/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
	$(LOCAL_PATH)/permissions/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
	$(LOCAL_PATH)/permissions/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	$(LOCAL_PATH)/permissions/android.software.app_widgets.xml:system/etc/permissions/android.software.app_widgets.xml \
	$(LOCAL_PATH)/permissions/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml \
	$(LOCAL_PATH)/permissions/android.software.webview.xml:system/etc/permissions/android.software.webview.xml \
	$(LOCAL_PATH)/permissions/com.android.location.provider.xml:system/etc/permissions/com.android.location.provider.xml \
	$(LOCAL_PATH)/permissions/com.android.media.remotedisplay.xml:system/etc/permissions/com.android.media.remotedisplay.xml \
	$(LOCAL_PATH)/permissions/com.android.mediadrm.signer.xml:system/etc/permissions/com.android.mediadrm.signer.xml \
	$(LOCAL_PATH)/permissions/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
	$(LOCAL_PATH)/permissions/platform.xml:system/etc/permissions/platform.xml



#Some files for the boot ramdisk
BOOT_RAMDISK_SRC = $(LOCAL_PATH)/ramdisk6.0
BOOT_RAMDISK_DST = root
PRODUCT_COPY_FILES += \
$(BOOT_RAMDISK_SRC)/init.hi3635.rc:$(BOOT_RAMDISK_DST)/init.hi3635.rc \
$(BOOT_RAMDISK_SRC)/init.recovery.hi3635.rc:$(BOOT_RAMDISK_DST)/init.recovery.hi3635.rc \
$(BOOT_RAMDISK_SRC)/custom.init.mods.rc:$(BOOT_RAMDISK_DST)/custom.init.mods.rc \
$(BOOT_RAMDISK_SRC)/custom.init.usb.rc:$(BOOT_RAMDISK_DST)/custom.init.usb.rc \
$(BOOT_RAMDISK_SRC)/vendor.init.5844.rc:$(BOOT_RAMDISK_DST)/vendor.init.5844.rc \
$(BOOT_RAMDISK_SRC)/vendor.init.audio.rc:$(BOOT_RAMDISK_DST)/vendor.init.audio.rc \
$(BOOT_RAMDISK_SRC)/vendor.init.balong_modem.rc:$(BOOT_RAMDISK_DST)/vendor.init.balong_modem.rc \
$(BOOT_RAMDISK_SRC)/vendor.init.connectivity.bcm4334.rc:$(BOOT_RAMDISK_DST)/vendor.init.connectivity.bcm4334.rc \
$(BOOT_RAMDISK_SRC)/vendor.init.connectivity.gps.rc:$(BOOT_RAMDISK_DST)/vendor.init.connectivity.gps.rc \
$(BOOT_RAMDISK_SRC)/vendor.init.connectivity.rc:$(BOOT_RAMDISK_DST)/vendor.init.connectivity.rc \
$(BOOT_RAMDISK_SRC)/vendor.init.device.rc:$(BOOT_RAMDISK_DST)/vendor.init.device.rc \
$(BOOT_RAMDISK_SRC)/vendor.init.extmodem.rc:$(BOOT_RAMDISK_DST)/vendor.init.extmodem.rc \
$(BOOT_RAMDISK_SRC)/vendor.init.hi3635.rc:$(BOOT_RAMDISK_DST)/vendor.init.hi3635.rc \
$(BOOT_RAMDISK_SRC)/vendor.init.hisi.rc:$(BOOT_RAMDISK_DST)/vendor.init.hisi.rc \
$(BOOT_RAMDISK_SRC)/vendor.init.manufacture.rc:$(BOOT_RAMDISK_DST)/vendor.init.manufacture.rc \
$(BOOT_RAMDISK_SRC)/vendor.init.performance.rc:$(BOOT_RAMDISK_DST)/vendor.init.performance.rc \
$(BOOT_RAMDISK_SRC)/vendor.init.platform.rc:$(BOOT_RAMDISK_DST)/vendor.init.platform.rc \
$(BOOT_RAMDISK_SRC)/vendor.init.protocol.rc:$(BOOT_RAMDISK_DST)/vendor.init.protocol.rc \
$(BOOT_RAMDISK_SRC)/vendor.init.tee.rc:$(BOOT_RAMDISK_DST)/vendor.init.tee.rc \
$(BOOT_RAMDISK_SRC)/vendor.init.post-fs-data.rc:$(BOOT_RAMDISK_DST)/vendor.init.post-fs-data.rc \
$(BOOT_RAMDISK_SRC)/ueventd.hi3635.rc:$(BOOT_RAMDISK_DST)/ueventd.hi3635.rc \
$(BOOT_RAMDISK_SRC)/fstab.hi3635:$(BOOT_RAMDISK_DST)/fstab.hi3635 \
$(BOOT_RAMDISK_SRC)/sbin/volisnotd:$(BOOT_RAMDISK_DST)/sbin/volisnotd \
$(BOOT_RAMDISK_SRC)/sbin/teecd:$(BOOT_RAMDISK_DST)/sbin/teecd \
$(BOOT_RAMDISK_SRC)/sbin/check_root:$(BOOT_RAMDISK_DST)/sbin/check_root \
$(BOOT_RAMDISK_SRC)/sbin/e2fsck_s:$(BOOT_RAMDISK_DST)/sbin/e2fsck_s \
$(BOOT_RAMDISK_SRC)/sbin/emmc_partation:$(BOOT_RAMDISK_DST)/sbin/emmc_partation \
$(BOOT_RAMDISK_SRC)/sbin/hdbd:$(BOOT_RAMDISK_DST)/sbin/hdbd \
$(BOOT_RAMDISK_SRC)/sbin/kmsgcat:$(BOOT_RAMDISK_DST)/sbin/kmsgcat \
$(BOOT_RAMDISK_SRC)/sbin/logctl_service:$(BOOT_RAMDISK_DST)/sbin/logctl_service \
$(BOOT_RAMDISK_SRC)/sbin/ntfs-3gd:$(BOOT_RAMDISK_DST)/sbin/ntfs-3gd \
$(BOOT_RAMDISK_SRC)/sbin/oeminfo_nvm_server:$(BOOT_RAMDISK_DST)/sbin/oeminfo_nvm_server \
$(BOOT_RAMDISK_SRC)/sbin/hw_ueventd:$(BOOT_RAMDISK_DST)/sbin/hw_ueventd \

$(call inherit-product, build/target/product/full.mk)

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

PRODUCT_DEVICE:=hwgra
PRODUCT_NAME:=full_hwgra
PRODUCT_BRAND:=HUAWEI
PRODUCT_MODEL:=HUAWEI GRA-L09
PRODUCT_MANUFACTURER:=HUAWEI
