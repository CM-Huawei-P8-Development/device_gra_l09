# Release name
PRODUCT_RELEASE_NAME := hwgra

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/huawei/hwgra/device_hwgra.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := hwgra
PRODUCT_NAME := cm_hwgra
PRODUCT_BRAND := huawei
PRODUCT_MODEL := hwgra
PRODUCT_MANUFACTURER := huawei
