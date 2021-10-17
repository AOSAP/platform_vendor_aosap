# Set Aosap specific identifier for Android Go enabled products
PRODUCT_TYPE := go

# Inherit mini common Aosap stuff
$(call inherit-product, vendor/aosap/config/common_mini_phone.mk)
