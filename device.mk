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

DEVICE_PACKAGE_OVERLAYS += \
	device/huawei/hwgra/overlay

# AUDIO
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/audio/audio_policy.conf:system/etc/audio_policy.conf \
	$(LOCAL_PATH)/audio/audio_effects.conf:system/vendor/etc/audio_effects.conf

# NFC
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/com.nxp.mifare.xml:system/etc/permissions/com.nxp.mifare.xml \
	frameworks/native/data/etc/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml \
	frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
	frameworks/native/data/etc/android.hardware.nfc.hce.xml:system/etc/permissions/android.hardware.nfc.hce.xml \
	packages/apps/Nfc/migrate_nfc.txt:system/etc/updatecmds/migrate_nfc.txt \
	$(LOCAL_PATH)/nfc/libnfc-nxp_grace.conf:system/etc/libnfc-nxp.conf \
	$(LOCAL_PATH)/nfc/libnfc-brcm_grace.conf:system/etc/libnfc-brcm.conf

# GPS libs
#Somehow CM looks for this file with another name
#I'l keep the stock ones there too.
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/vendor/system/lib64/hw/gps47531.default.so:system/lib64/hw/gps.hi3635.so

# GPS config
PRODUCT_COPY_FILES += \
	    $(LOCAL_PATH)/gps/gps.conf:system/etc/gps.conf \
	    $(LOCAL_PATH)/gps/gps4752.conf:system/etc/gps4752.conf \
	    $(LOCAL_PATH)/gps/gps4752config.xml:system/etc/gps4752config.xml \
	    $(LOCAL_PATH)/gps/gps47531config.xml:system/etc/gps47531config.xml \
	    $(LOCAL_PATH)/gps/gps47531config_beta.xml:system/etc/gps47531config_beta.xml \
	    $(LOCAL_PATH)/gps/gps47531config_cl.xml:system/etc/gps47531config_cl.xml \
	    $(LOCAL_PATH)/gps/gps47531config_cl_beta.xml:system/etc/gps47531config_cl_beta.xml

# FM RADIO quick hack to copy renamed files, does cm looks for default?
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/vendor/system/lib/hw/fm.bcm.hi3635.so:system/lib/hw/fm.bcm.default.so \
	$(LOCAL_PATH)/vendor/system/lib64/hw/fm.bcm.hi3635.so:system/lib64/hw/fm.bcm.default.so

# CAMERA
PRODUCT_PACKAGES += \
	Snap

# SHIM LIBS
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/vendor/system/lib/libhwui.so:system/lib/libshim_hwui.so \
	$(LOCAL_PATH)/vendor/system/lib64/libhwui.so:system/lib64/libshim_hwui.so \
	$(LOCAL_PATH)/vendor/system/vendor/lib64/egl/libGLES_mali.so:system/vendor/lib64/libGLES_mali.so \
	$(LOCAL_PATH)/vendor/system/vendor/lib/egl/libGLES_mali.so:system/vendor/lib/libGLES_mali.so \
	$(LOCAL_PATH)/vendor/system/lib/libmedia.so:system/lib/libshim_media.so \
	$(LOCAL_PATH)/vendor/system/lib64/libmedia.so:system/lib64/libshim_media.so \
	$(LOCAL_PATH)/vendor/system/lib/libcamera_client.so:system/lib/libshim_camera_client.so \
	$(LOCAL_PATH)/vendor/system/lib64/libcamera_client.so:system/lib64/libshim_camera_client.so

#Bluetooth Missing xml files after build
#That's probably not the propper way to do it!
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/bluetooth/bt_vendor.conf:system/etc/bluetooth/bt_vendor.conf

# Thermal engine
PRODUCT_COPY_FILES += \
	    $(LOCAL_PATH)/prebuilts/thermald.xml:system/etc/thermald.xml \
	    $(LOCAL_PATH)/prebuilts/thermald_performance.xml:system/etc/thermald_performance.xml

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
	$(LOCAL_PATH)/permissions/com.android.location.provider.xml:system/etc/permissions/com.android.location.provider.xml \
	$(LOCAL_PATH)/permissions/com.android.media.remotedisplay.xml:system/etc/permissions/com.android.media.remotedisplay.xml \
	$(LOCAL_PATH)/permissions/com.android.mediadrm.signer.xml:system/etc/permissions/com.android.mediadrm.signer.xml \
	$(LOCAL_PATH)/permissions/com.google.android.media.effects.xml:system/etc/permissions/com.google.android.media.effects.xml \
	$(LOCAL_PATH)/permissions/com.hisi.perfhub.xml:system/etc/permissions/com.hisi.perfhub.xml \
	$(LOCAL_PATH)/permissions/com.huawei.audioalgo.xml:system/etc/permissions/com.huawei.audioalgo.xml \
	$(LOCAL_PATH)/permissions/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
	$(LOCAL_PATH)/permissions/platform.xml:system/etc/permissions/platform.xml

# MEDIA
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/media/media_codecs.xml:system/etc/media_codecs.xml \
    $(LOCAL_PATH)/media/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml \
    $(LOCAL_PATH)/media/media_codecs_dts_audio.xml:system/etc/media_codecs_dts_audio.xml \
    $(LOCAL_PATH)/media/media_codecs_performance.xml:system/etc/media_codecs_performance.xml \
    $(LOCAL_PATH)/media/media_profiles.xml:system/etc/media_profiles.xml

PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:system/etc/media_codecs_google_telephony.xml
#    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml

# LIGHTS
PRODUCT_PACKAGES += \
	lights.hi3635

# AUDIO
PRODUCT_PACKAGES += \
		audio.primary.default \
		audio.a2dp.default \
		audio.usb.default \
		audio.r_submix.default \
		libaudioutils \
		libaudioroute \
		libtinyalsa \
		tinyplay \
		tinycap \
		tinymix \
		tinypcminfo

# FM RADIO
PRODUCT_PACKAGES += \
		FMRadio

# GELLO
PRODUCT_PACKAGES += \
		Gello

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
# PRODUCT_PACKAGES += \
	power.hi3635

# RAMDISK
PRODUCT_PACKAGES += \
	fstab.hi3635 \
	init.hi3635.rc \
	init.recovery.hi3635.rc \
	init.hi3635.usb.rc \
	init.hi3635.gps.rc \
	ueventd.hi3635.rc \
	init.hi3635.power.rc \
	init.hi3635.power.sh

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
	persist.sys.root_access=3

PRODUCT_PROPERTY_OVERRIDES += \
	ro.build.selinux=0 \
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

# DALVIK AND MEMORY
$(call inherit-product, frameworks/native/build/phone-xxhdpi-3072-dalvik-heap.mk)
$(call inherit-product, frameworks/native/build/phone-xxhdpi-3072-hwui-memory.mk)
