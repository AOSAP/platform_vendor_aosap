# Allow vendor/extra to override any property by setting it first
$(call inherit-product-if-exists, vendor/extra/product.mk)

include vendor/aosap/build/core/main_version.mk

PRODUCT_BRAND ?= AOSAP

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

ifeq ($(TARGET_BUILD_VARIANT),eng)
# Disable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
else
# Enable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.ota.allow_downgrade=true
endif

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/aosap/config/permissions/backup.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/backup.xml

# Copy all Aosap-specific init rc files
$(foreach f,$(wildcard vendor/aosap/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_SYSTEM)/etc/init/$(notdir $f)))

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/aosap/prebuilt/common/lib/content-types.properties:$(TARGET_COPY_OUT_SYSTEM)/lib/content-types.properties

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/aosap/build/tools/backuptool.sh:$(TARGET_COPY_OUT_SYSTEM)/install/bin/backuptool.sh \
    vendor/aosap/build/tools/backuptool.functions:$(TARGET_COPY_OUT_SYSTEM)/install/bin/backuptool.functions \
    vendor/aosap/build/tools/50-aosap.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-aosap.sh

ifneq ($(AB_OTA_PARTITIONS),)
PRODUCT_COPY_FILES += \
    vendor/aosap/build/tools/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/aosap/build/tools/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/aosap/build/tools/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh
endif

# Enable Android Beam on all targets
PRODUCT_COPY_FILES += \
    vendor/aosap/config/permissions/android.software.nfc.beam.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.nfc.beam.xml

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/Vendor_045e_Product_0719.kl

# Enforce privapp-permissions whitelist
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=false

# Include AOSP audio files
include vendor/aosap/config/aosp_audio.mk

# Include Lineage audio files
include vendor/aosap/config/aosap_audio.mk

# TWRP
ifeq ($(WITH_TWRP),true)
include vendor/aosap/config/twrp.mk
endif

# Face Unlock
TARGET_FACE_UNLOCK_SUPPORTED := false
ifneq ($(TARGET_DISABLE_ALTERNATIVE_FACE_UNLOCK), true)
PRODUCT_PACKAGES += \
    FaceUnlockService
TARGET_FACE_UNLOCK_SUPPORTED := true
endif
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.face.moto_unlock_service=$(TARGET_FACE_UNLOCK_SUPPORTED)

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

# Bootanimation
PRODUCT_COPY_FILES += vendor/aosap/bootanimation/bootanimation.zip:system/media/bootanimation.zip

# Fonts
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,vendor/aosap/prebuilt/fonts,$(TARGET_COPY_OUT_SYSTEM)/fonts)

# AOSP packages
PRODUCT_PACKAGES += \
    Terminal

# Custom Overlays
# Settings
PRODUCT_PACKAGES += \
    SystemPitchBlackOverlay \
    SystemUIPitchBlackOverlay \
    SystemDarkGrayOverlay \
    SystemUIDarkGrayOverlay \
    SystemStyleOverlay \
    SystemUIStyleOverlay \
    SystemNightOverlay \
    SystemUINightOverlay

#AOSAP
PRODUCT_PACKAGES += \
    ThemePicker \
    AosapThemesStub

#OmniJaws
PRODUCT_PACKAGES += \
    OmniJaws \
    WeatherIcons

# Navbar
PRODUCT_PACKAGES += \
    GesturalNavigationOverlayLong \
    GesturalNavigationOverlayMedium

# Extra tools in AOSAP
PRODUCT_PACKAGES += \
    7z \
    awk \
    bash \
    bzip2 \
    curl \
    getcap \
    htop \
    lib7z \
    libsepol \
    nano \
    pigz \
    powertop \
    setcap \
    unrar \
    unzip \
    vim \
    wget \
    zip

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    fsck.ntfs \
    mke2fs \
    mkfs.exfat \
    mkfs.ntfs \
    mount.ntfs

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# These packages are excluded from user builds
PRODUCT_PACKAGES_DEBUG += \
    procmem

# Root
PRODUCT_PACKAGES += \
    adb_root
ifneq ($(TARGET_BUILD_VARIANT),user)
ifeq ($(WITH_SU),true)
PRODUCT_PACKAGES += \
    su
endif
endif

# Dex preopt
PRODUCT_DEXPREOPT_SPEED_APPS += \
    SystemUI \
    TrebuchetQuickStep

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/aosap/overlay
DEVICE_PACKAGE_OVERLAYS += vendor/aosap/overlay/common

PRODUCT_EXTRA_RECOVERY_KEYS += \
    vendor/aosap/build/target/product/security/aosap

-include $(WORKSPACE)/build_env/image-auto-bits.mk
-include vendor/aosap/config/partner_gms.mk
