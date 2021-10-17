# Inherit full common Aosap stuff
$(call inherit-product, vendor/aosap/config/common_full.mk)

# Required packages
PRODUCT_PACKAGES += \
    LatinIME

# Include Aosap LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/aosap/overlay/dictionaries

$(call inherit-product, vendor/aosap/config/telephony.mk)
