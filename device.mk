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
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

$(call inherit-product-if-exists, vendor/huawei/hwgra/hwgra-vendor.mk)

PRODUCT_PACKAGE_OVERLAYS += \
	device/huawei/hwgra/overlay

DEVICE_PACKAGE_OVERLAYS += device/huawei/hwgra/overlay

ifeq ($(TARGET_PREBUILT_KERNEL),)
	LOCAL_KERNEL := device/huawei/hwgra/kernel
else
	LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

# LIGHTS
PRODUCT_PACKAGES += lights.hi3635

# AUDIO
PRODUCT_PACKAGES += \
	audio.a2dp.default \
	audio.usb.default \
	audio.r_submix.default

# FM RADIO
PRODUCT_PACKAGES += \
	FMRadio
	
# GELLO
PRODUCT_PACKAGES += \
	Gello
	
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/audio/audio_policy.conf:system/etc/audio_policy.conf

#?
PRODUCT_PACKAGES += \
	flp.default
# NFC
PRODUCT_PACKAGES += \
	com.android.nfc_extras \
	com.nxp.nfc.nq \
	nfc_nci.pn54x.default \
	NQNfcNci \
	nqnfcee_access.xml \
	nqnfcse_access.xml \
	Tag

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/com.nxp.mifare.xml:system/etc/permissions/com.nxp.mifare.xml \
	frameworks/native/data/etc/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml \
	frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
	frameworks/native/data/etc/android.hardware.nfc.hce.xml:system/etc/permissions/android.hardware.nfc.hce.xml \
	packages/apps/Nfc/migrate_nfc.txt:system/etc/updatecmds/migrate_nfc.txt \
	$(LOCAL_PATH)/nfc/libnfc-nxp_grace.conf:system/etc/libnfc-nxp.conf \
	$(LOCAL_PATH)/nfc/libnfc-brcm_grace.conf:system/etc/libnfc-brcm.conf

# WIFI
PRODUCT_PACKAGES += \
	libwpa_client \
	wpa_supplicant \
	hostapd \
	wificond \
	wifilogd 

# HWC
PRODUCT_PACKAGES += \
	hwcomposer.hi3635

# POWER HAL
#PRODUCT_PACKAGES += \
	power.hi3635

# GPS
#Somehow CM looks for this file with another name
#I'l keep the stock ones there too.
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/vendor6.0/system/lib64/hw/gps47531.default.so:system/lib64/hw/gps.hi3635.so

# FM RADIO quick hack to copy renamed files, does cm looks for default?
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/vendor6.0/system/lib/hw/fm.bcm.hi3635.so:system/lib/hw/fm.bcm.default.so \
	$(LOCAL_PATH)/vendor6.0/system/lib64/hw/fm.bcm.hi3635.so:system/lib64/hw/fm.bcm.default.so
	
# CAMERA
#PRODUCT_PACKAGES += \
	stlport \
	stlport_static

PRODUCT_PACKAGES += \
	libcamera \
	libmmcamera_interface \
	libmmcamera_interface2 \
	libmmjpeg_interface \
	libqomx_core \
	libmm-qcamera \
	mm-qcamera-app \
	Snap
    
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/vendor6.0/system/lib/libhwui.so:system/lib/libshim_hwui.so \
	$(LOCAL_PATH)/vendor6.0/system/lib64/libhwui.so:system/lib64/libshim_hwui.so \
	$(LOCAL_PATH)/vendor6.0/system/vendor/lib64/egl/libGLES_mali.so:system/vendor/lib64/libGLES_mali.so \
	$(LOCAL_PATH)/vendor6.0/system/vendor/lib/egl/libGLES_mali.so:system/vendor/lib/libGLES_mali.so \
	$(LOCAL_PATH)/vendor6.0/system/lib/libmedia.so:system/lib/libshim_media.so \
	$(LOCAL_PATH)/vendor6.0/system/lib64/libmedia.so:system/lib64/libshim_media.so \
	$(LOCAL_PATH)/vendor6.0/system/lib/libcamera_client.so:system/lib/libshim_camera_client.so \
	$(LOCAL_PATH)/vendor6.0/system/lib64/libcamera_client.so:system/lib64/libshim_camera_client.so

#Bluetooth Missing xml files after build
#That's probably not the propper way to do it!
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/bluetooth/bt_vendor.conf:system/etc/bluetooth/bt_vendor.conf


#The built kernel
PRODUCT_COPY_FILES += $(LOCAL_KERNEL):kernel

#This will be used as /etc/recovery.fstab only for twrp
PRODUCT_COPY_FILES += $(LOCAL_PATH)/recovery/twrp.fstab:recovery/root/etc/twrp.fstab

# PERMISSIONS
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

# MEDIA
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/media/media_codecs.xml:system/etc/media_codecs.xml \
    $(LOCAL_PATH)/media/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml \
    $(LOCAL_PATH)/media/media_codecs.xml:system/etc/media_codecs_dts_audio.xml \
    $(LOCAL_PATH)/media/media_codecs_performance.xml:system/etc/media_codecs_performance.xml \
    $(LOCAL_PATH)/media/media_profiles.xml:system/etc/media_profiles.xml

PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:system/etc/media_codecs_google_telephony.xml
#    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml

    
# RAMDISK
PRODUCT_PACKAGES += \
	fstab.hi3635 \
	init.hi3635.rc \
	init.recovery.hi3635.rc \
	custom.init.mods.rc \
	custom.init.usb.rc \
	vendor.init.5844.rc \
	vendor.init.audio.rc \
	vendor.init.balong_modem.rc \
	vendor.init.connectivity.bcm4334.rc \
	vendor.init.connectivity.gps.rc \
	vendor.init.connectivity.rc \
	vendor.init.device.rc \
	vendor.init.extmodem.rc \
	vendor.init.hi3635.rc \
	vendor.init.hisi.rc \
	vendor.init.manufacture.rc \
	vendor.init.performance.rc \
	vendor.init.platform.rc \
	vendor.init.protocol.rc \
	vendor.init.tee.rc \
	vendor.init.post-fs-data.rc \
	ueventd.hi3635.rc 
#	init.hi3635.power.rc \
#	init.hi3635.power.sh \


# Experiments
# Update 1x signal strength after 2s
#PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.radio.snapshot_enabled=1 \
    persist.radio.snapshot_timer=2

#PRODUCT_PROPERTY_OVERRIDES += \
    ro.hwui.texture_cache_size=72 \
    ro.hwui.layer_cache_size=48 \
    ro.hwui.r_buffer_cache_size=8 \
    ro.hwui.path_cache_size=32 \
    ro.hwui.gradient_cache_size=1 \
    ro.hwui.drop_shadow_cache_size=6 \
    ro.hwui.texture_cache_flushrate=0.4 \
    ro.hwui.text_small_cache_width=1024 \
    ro.hwui.text_small_cache_height=1024 \
    ro.hwui.text_large_cache_width=2048 \
    ro.hwui.text_large_cache_height=1024
    
#End Experiments


#Dalvik & memory
$(call inherit-product, frameworks/native/build/phone-xxhdpi-3072-dalvik-heap.mk)
$(call inherit-product, frameworks/native/build/phone-xxhdpi-3072-hwui-memory.mk) 
