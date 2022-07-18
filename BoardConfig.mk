#
# Copyright 2017 The Android Open Source Project
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
#

# This contains the module build definitions for the hardware-specific
# components for this device.
#
# As much as possible, those components should be built unconditionally,
# with device-specific names to avoid collisions, to avoid device-specific
# bitrot and build breakages. Building a component unconditionally does
# *not* include it on all devices, so it is safe even with hardware-specific
# components.

LOCAL_PATH := device/motorola/odessa

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := kryo

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a73
TARGET_USES_64_BIT_BINDER := true

ENABLE_CPUSETS := true
ENABLE_SCHEDBOOST := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := odessa
TARGET_NO_BOOTLOADER := true
TARGET_USES_UEFI := true

BUILD_BROKEN_DUP_RULES := true


# a12 source
TARGET_SUPPORTS_64_BIT_APPS := true

# Kernel
BOARD_KERNEL_CMDLINE := \
    console=ttyMSM0,115200,n8 \
    androidboot.hardware=qcom \
    androidboot.console=ttyMSM0 \
    androidboot.memcg=1 \
    lpm_levels.sleep_disabled=1 \
    video=vfb:640x400,bpp=32,memsize=3072000 \
    msm_rtb.filter=0x237 \
    service_locator.enable=1 \
    swiotlb=1 \
    earlycon=msm_geni_serial,0x4a90000 \
    cgroup.memory=nokmem,nosocket \
    androidboot.usbcontroller=4e00000.dwc3 \
    printk.devkmsg=on \
    firmware_class.path=/vendor/firmware_mnt/image
# For the love of all that is holy, please do not include this in your ROM unless you really want TWRP to not work correctly!
BOARD_KERNEL_CMDLINE += androidboot.fastboot=1
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
BOARD_KERNEL_PAGESIZE := 4096
BOARD_BOOT_HEADER_VERSION := 2
BOARD_KERNEL_BASE          := 0x00000000
BOARD_KERNEL_TAGS_OFFSET   := 0x00000100
BOARD_KERNEL_OFFSET        := 0x00008000
BOARD_KERNEL_SECOND_OFFSET := 0x00f00000
BOARD_RAMDISK_OFFSET       := 0x01000000
BOARD_DTB_OFFSET           := 0x01f00000

TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_KERNEL_VERSION := 4.14
BOARD_KERNEL_IMAGE_NAME := Image.gz
TARGET_KERNEL_ARCH := arm64
BOARD_INCLUDE_RECOVERY_DTBO := true

BUILD_WITH_KERNEL_SOURCE := true

ifeq ($(BUILD_WITH_KERNEL_SOURCE), true)
TARGET_KERNEL_SOURCE := kernel/motorola/odessa
TARGET_KERNEL_CONFIG := twrp_odessa_defconfig
TARGET_KERNEL_CLANG_COMPILE := true
BOARD_KERNEL_SEPARATED_DTBO := true
# clang 12.7 r416183b1
TARGET_KERNEL_CLANG_VERSION := r416183b1
else
TARGET_PREBUILT_KERNEL := device/motorola/odessa/prebuilt/Image.gz-dtb
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/dtbo.img
endif

BOARD_MKBOOTIMG_ARGS += --base $(BOARD_KERNEL_BASE)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --second_offset $(BOARD_KERNEL_SECOND_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
# BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)

BOARD_INCLUDE_DTB_IN_BOOTIMG := true

# Platform
TARGET_BOARD_PLATFORM := sm6150
TARGET_BOARD_PLATFORM_GPU := qcom-adreno612
QCOM_BOARD_PLATFORMS += sm6150

# AVB
BOARD_AVB_ENABLE := true

BOARD_AVB_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)

# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144

BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_DTBOIMG_PARTITION_SIZE := 25165824
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_PARTITION_RESERVED_SIZE := 536870912
BOARD_USERDATAIMAGE_PARTITION_SIZE := 116995371008
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Super
BOARD_SUPER_PARTITION_SIZE := 9730785280
BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 4865392640
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    system \
    product \
    vendor

TARGET_NO_KERNEL := false
TARGET_NO_RECOVERY := false

# Partitions (listed in the file) to be wiped under recovery.
TARGET_RECOVERY_WIPE := $(LOCAL_PATH)/recovery.wipe

# Workaround for error copying vendor files to recovery ramdisk
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_PRODUCT := product

# Recovery
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_HAS_NO_SELECT_BUTTON := true

# Use mke2fs to create ext4 images
TARGET_USES_MKE2FS := true

# A/B device flags
TARGET_NO_KERNEL := false
TARGET_NO_RECOVERY := false
BOARD_USES_RECOVERY_AS_BOOT := false
BOARD_BUILD_SYSTEM_ROOT_IMAGE := false

# TWRP specific build flags
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_INCLUDE_NTFS_3G := true
TW_INCLUDE_RESETPROP := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_MAX_BRIGHTNESS := 255
TW_DEFAULT_BRIGHTNESS := 120
TW_THEME := portrait_hdpi
TARGET_USE_CUSTOM_LUN_FILE_PATH := /config/usb_gadget/g1/functions/mass_storage.0/lun.%d/file
TW_NO_SCREEN_BLANK := true
TW_NO_USB_STORAGE := true

# Additional binaries & libraries needed for recovery
TARGET_RECOVERY_DEVICE_MODULES += \
    android.hidl.base@1.0 \
    ashmemd \
    ashmemd_aidl_interface-cpp \
    libashmemd_client \
    libcap \
    libicui18n \
    libicuuc \
    libion \
    libpcrecpp \
    libprocinfo \
    libxml2

TW_RECOVERY_ADDITIONAL_RELINK_BINARY_FILES += \
    $(TARGET_OUT_EXECUTABLES)/ashmemd

TW_RECOVERY_ADDITIONAL_RELINK_LIBRARY_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hidl.base@1.0.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/ashmemd_aidl_interface-cpp.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libashmemd_client.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libcap.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libicui18n.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libicuuc.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libpcrecpp.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libprocinfo.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libxml2.so

# Encryption
PLATFORM_VERSION := 16.1.0
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := 2099-12-31
TW_INCLUDE_CRYPTO := true
BOARD_USES_QCOM_FBE_DECRYPTION := true
BOARD_USES_METADATA_PARTITION := true
# TWRP specific build flags
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
TW_EXCLUDE_SUPERSU := true

# Extras
TARGET_SYSTEM_PROP += $(PLATFORM_PATH)/system.prop

BOARD_SUPPRESS_SECURE_ERASE := true
TW_USE_TOOLBOX := true
TW_EXCLUDE_TWRPAPP := true
TW_HAS_EDL_MODE := true

# Asian region languages
TW_EXTRA_LANGUAGES := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_INCLUDE_RESETPROP := true
TW_DEFAULT_BRIGHTNESS := 120
TW_INCLUDE_NTFS_3G := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_MAX_BRIGHTNESS := 255
TW_THEME := portrait_hdpi
TARGET_RECOVERY_DEVICE_MODULES += android.hardware.boot@1.0
TARGET_USE_CUSTOM_LUN_FILE_PATH := /config/usb_gadget/g1/functions/mass_storage.0/lun.%d/file
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
TW_NO_SCREEN_BLANK := true
TW_USE_TOOLBOX := true
BOARD_PROVIDES_GPTUTILS := true
BOARD_SUPPRESS_SECURE_ERASE := true
TW_EXCLUDE_TWRPAPP := true
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true
TW_NO_USB_STORAGE := true

ALLOW_MISSING_DEPENDENCIES := true
