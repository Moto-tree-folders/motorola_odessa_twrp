# Release name
PRODUCT_RELEASE_NAME := sofiar
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_PACKAGES += fastbootd
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_minimal.mk)

# Inherit from our custom product configuration
$(call inherit-product, vendor/pb/config/common.mk)

# Inherit from hardware-specific part of the product configuration
$(call inherit-product, device/motorola/sofiar/device.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := sofiar
PRODUCT_NAME := omni_sofiar
PRODUCT_BRAND := Motorola
PRODUCT_MODEL := sofiar
PRODUCT_MANUFACTURER := Motorola


#PRODUCT_SYSTEM_PROPERTY_BLACKLIST += \

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME="motorola G8 Power" \
    BUILD_PRODUCT="motorola G8 Power" \
    TARGET_DEVICE="motorola G8 Power"

# HACK: Set vendor patch level
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.build.security_patch=2099-12-31
