# Set Aosap specific identifier for Android Go enabled products
PRODUCT_TYPE := go

# Inherit full common Aosap stuff
$(call inherit-product, vendor/aosap/config/common_full_phone.mk)
