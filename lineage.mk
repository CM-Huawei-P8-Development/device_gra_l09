# Release name
PRODUCT_RELEASE_NAME := GRA-L09

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/huawei/hwgra/device_hwgra.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE:=hwgra
PRODUCT_NAME:=cm_hwgra
PRODUCT_BRAND:=HUAWEI
PRODUCT_MODEL:=HUAWEI GRA-L09
PRODUCT_MANUFACTURER:=HUAWEI
