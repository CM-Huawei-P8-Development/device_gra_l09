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
#BOARD_CUSTOM_GRAPHICS := $(LOCAL_PATH)/recovery/twrp-graphics.c
STE_HARDWARE := true #Not sure if needed
TW_BRIGHTNESS_PATH := /sys/devices/platform/hisi_fb.1048577/leds/lcd_backlight0/brightness
TW_CUSTOM_BATTERY_PATH := /sys/class/power_supply/Battery
TWRP_INCLUDE_LOGCAT := true
TW_MAX_BRIGHTNESS := 255
TW_DEFAULT_BRIGHTNESS := 255
TWRP_INCLUDE_LOGCAT := true
RECOVERY_GRAPHICS_USE_LINELENGTH := true
#in vendor recovery it is RGB565
#TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"  
#TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888" 
TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/recovery.fstab 
#this is required to avoid unresponsive touch at boot until screen timeout 
TW_SCREEN_BLANK_ON_BOOT := true 
RECOVERY_SDCARD_ON_DATA := true
