$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

$(call inherit-product-if-exists, vendor/huawei/hwgra/hwgra-vendor.mk)

DEVICE_PACKAGE_OVERLAYS += \
	device/huawei/hwgra/overlay


ifeq ($(TARGET_PREBUILT_KERNEL),)
	LOCAL_KERNEL := device/huawei/hwgra/kernel
else
	LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif


#For shim libs or any other additional lib
PRODUCT_PACKAGES += \
	lights.hi3635 \
	audio.a2dp.default \
	audio.usb.default \
	audio.r_submix.default

#Bluetooth Missing xml files after build
#That's probably not the propper way to do it!
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/bluetooth/bt_vendor.conf:system/etc/bluetooth/bt_vendor.conf \
	frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
	frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml
	

#Audio config
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/audio/audio_policy.conf:system/etc/audio_policy.conf

#The built kernel
PRODUCT_COPY_FILES += $(LOCAL_KERNEL):kernel

#This will be used as /etc/recovery.fstab only for twrp
PRODUCT_COPY_FILES += $(LOCAL_PATH)/recovery/twrp.fstab:recovery/root/etc/twrp.fstab

#Use the modified wpa_supplicant.conf
PRODUCT_COPY_FILES += $(LOCAL_PATH)/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf

#Some files for the boot ramdisk
BOOT_RAMDISK_SRC = $(LOCAL_PATH)/ramdisk6.0
BOOT_RAMDISK_DST = root
PRODUCT_COPY_FILES += \
$(BOOT_RAMDISK_SRC)/init.hi3635.rc:$(BOOT_RAMDISK_DST)/init.hi3635.rc \
$(BOOT_RAMDISK_SRC)/init.recovery.hi3635.rc:$(BOOT_RAMDISK_DST)/init.recovery.hi3635.rc \
$(BOOT_RAMDISK_SRC)/custom.init.mods.rc:$(BOOT_RAMDISK_DST)/custom.init.mods.rc \
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
PRODUCT_NAME := full_hwgra
PRODUCT_DEVICE := hwgra
