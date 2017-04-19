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

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from hwgra device
$(call inherit-product, device/huawei/hwgra/device.mk)

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE:=hwgra
PRODUCT_NAME:=full_hwgra
PRODUCT_BRAND:=HUAWEI
PRODUCT_MODEL:=HUAWEI GRA-L09
PRODUCT_MANUFACTURER:=HUAWEI
