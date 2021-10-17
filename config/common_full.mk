# Inherit common Aosap stuff
$(call inherit-product, vendor/aosap/config/common_mobile.mk)

PRODUCT_SIZE := full

# Recorder
PRODUCT_PACKAGES += \
    Recorder
