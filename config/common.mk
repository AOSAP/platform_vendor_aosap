ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PRODUCT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PRODUCT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# General additions
PRODUCT_PRODUCT_PROPERTIES += \
    keyguard.no_require_sim=true \
    dalvik.vm.debug.alloc=0 \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dataroaming=false \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.com.android.dateformat=MM-dd-yyyy \
    persist.debug.wfd.enable=1 \
    persist.sys.wfd.virtual=0 \
    ro.setupwizard.rotation_locked=true \
    persist.sys.disable_rescue=true \
    ro.build.selinux=1

# Allow tethering without provisioning app
PRODUCT_PRODUCT_PROPERTIES += \
    net.tethering.noprovisioning=true

# Gestures
PRODUCT_PROPERTY_OVERRIDES += \
    ro.boot.vendor.overlay.theme=com.android.internal.systemui.navbar.gestural

PRODUCT_COPY_FILES += \
    vendor/aosap/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \

# Init files
PRODUCT_COPY_FILES += \
    vendor/aosap/prebuilt/common/etc/init.local.rc:system/etc/init/abc.rc

# Backup tool
#PRODUCT_COPY_FILES += \
    #vendor/aosap/build/tools/backuptool.sh:install/bin/backuptool.sh \
    #vendor/aosap/build/tools/backuptool.functions:install/bin/backuptool.functions \
    #vendor/aosap/build/tools/50-aosap.sh:system/addon.d/50-aosap.sh

# Packages
include vendor/aosap/config/packages.mk

# Branding
include vendor/aosap/config/branding.mk

# Themes
include vendor/themes/common.mk

# Gapps
include vendor/gapps/config.mk

# Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/aosap/overlay/common

