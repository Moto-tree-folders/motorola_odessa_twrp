#
# Copyright 2021 The Android Open Source Project
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

# Release name
PRODUCT_RELEASE_NAME := odessa
PRODUCT_PACKAGES += fastbootd
# Custom vendor used in build tree (automatically taken from prefix of this filename)
CUSTOM_VENDOR := $(lastword $(subst /, ,$(firstword $(subst _, ,$(firstword $(MAKEFILE_LIST))))))

# Inherit from our custom product configuration
$(call inherit-product, vendor/$(CUSTOM_VENDOR)/config/common.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := odessa
PRODUCT_NAME := $(CUSTOM_VENDOR)_$(PRODUCT_DEVICE)
PRODUCT_BRAND := Motorola
PRODUCT_MODEL := odessa
PRODUCT_MANUFACTURER := Motorola
# Inherit from hardware-specific part of the product configuration
$(call inherit-product, device/$(PRODUCT_BRAND)/$(PRODUCT_DEVICE)/device.mk)

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME="motorola G9 Plus" \
    BUILD_PRODUCT="motorola G9 Plus" \
    TARGET_DEVICE="motorola G9 Plus"
