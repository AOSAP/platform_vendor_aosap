# Build fingerprint
ifneq ($(BUILD_FINGERPRINT),)
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT)
endif

# Versioning System
AOSAP_BASE_VERSION = Thirteen

ifndef AOSAP_BUILD_TYPE
    AOSAP_BUILD_TYPE := UNOFFICIAL
endif

# Set all versions
BUILD_DATE := $(shell date -u +%Y%m%d)
BUILD_TIME := $(shell date -u +%H%M)
AOSAP_VERSION := $(TARGET_PRODUCT)-$(AOSAP_BASE_VERSION)-$(BUILD_DATE)-$(BUILD_TIME)-$(AOSAP_BUILD_TYPE)
BUILD_DATE_TIME := $(BUILD_TIME)$(BUILD_DATE)
TARGET_BACON_NAME := $(AOSAP_VERSION)
ROM_FINGERPRINT := AOSAP/$(PLATFORM_VERSION)/$(AOSAP_BUILD_TYPE)/$(BUILD_DATE)$(BUILD_TIME)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    ro.aosap.version=$(AOSAP_VERSION) \
    ro.build.datetime=$(BUILD_DATE_TIME) \
    ro.mod.version=$(AOSAP_BUILD_TYPE)-$(AOSAP_BASE_VERSION)-$(BUILD_DATE) \
    ro.aosap.fingerprint=$(ROM_FINGERPRINT) \
    ro.modversion=Thirteen
