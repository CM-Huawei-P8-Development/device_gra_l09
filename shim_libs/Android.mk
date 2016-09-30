# Copyright (C) 2015 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

# Debugging (uncomment to enable)
LOCAL_CFLAGS += -DHW_LIBC_DEBUG
LOCAL_WHOLE_STATIC_LIBRARIES := liblog

LOCAL_SRC_FILES := \
    hw_cutils.c

LOCAL_MODULE := libhw_cutils
LOCAL_MODULE_TAGS := optional

include $(BUILD_SHARED_LIBRARY)

# ================================

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
    hw_log.c

LOCAL_MODULE := libhw_log
LOCAL_MODULE_TAGS := optional

include $(BUILD_SHARED_LIBRARY)

# ================================

include $(CLEAR_VARS)

LOCAL_SHARED_LIBRARIES := liblog libcutils libgui libbinder libutils
LOCAL_ADDITIONAL_DEPENDENCIES := libboringssl-compat

LOCAL_SRC_FILES := \
    hw_gui.c

LOCAL_MODULE := libhw_gui
LOCAL_MODULE_CLASS := SHARED_LIBRARIES

include $(BUILD_SHARED_LIBRARY)

# ================================

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	hw_graphics.cpp

LOCAL_SHARED_LIBRARIES := libgui libsurfaceflinger liblog libcutils libbinder libutils
LOCAL_MODULE := libhw_graphics
LOCAL_MODULE_TAGS := optional

include $(BUILD_SHARED_LIBRARY)
