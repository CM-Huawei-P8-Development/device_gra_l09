# Release name
PRODUCT_RELEASE_NAME := GRA-L09

# Inherit device configuration
$(call inherit-product, device/huawei/hwgra/full_hwgra.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)


# Boot animation
TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH := 1080

BOARD_VENDOR := huawei

PRODUCT_GMS_CLIENTID_BASE := android-huawei

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := hwgra
PRODUCT_NAME := lineage_hwgra
PRODUCT_BRAND := HUAWEI
PRODUCT_MODEL := HUAWEI GRA-L09
PRODUCT_MANUFACTURER := HUAWEI
