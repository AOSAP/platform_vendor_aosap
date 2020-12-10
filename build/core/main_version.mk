# Versioning System
AOSAP_BASE_VERSION = Eleven

ifndef AOSAP_BUILD_TYPE
    AOSAP_BUILD_TYPE := UNOFFICIAL
endif

# Set all versions
BUILD_DATE := $(shell date -u +%Y%m%d)
AOSAP_VERSION := $(TARGET_PRODUCT)-$(AOSAP_BASE_VERSION)-$(BUILD_DATE)-$(AOSAP_BUILD_TYPE)
TARGET_BACON_NAME := $(AOSAP_VERSION)
ROM_FINGERPRINT := AOSAP/$(PLATFORM_VERSION)/$(AOSAP_BUILD_TYPE)/$(BUILD_DATE)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    ro.aosap.version=$(AOSAP_VERSION) \
    ro.mod.version=$(AOSAP_BUILD_TYPE)-$(AOSAP_BASE_VERSION)-$(BUILD_DATE) \
    ro.aosap.fingerprint=$(ROM_FINGERPRINT) \
    ro.modversion=Eleven \
    ro.aosap.update.version=11
