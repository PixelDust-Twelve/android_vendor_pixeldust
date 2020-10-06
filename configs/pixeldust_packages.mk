# Copyright (C) 2018-2021 The PixelDust Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += libprotobuf-cpp-full

# Include support for additional filesystems
PRODUCT_PACKAGES += \
    e2fsck \
    mke2fs \
    tune2fs \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    ntfsfix \
    ntfs-3g

# Build missing packages to prevent zip signing failure
PRODUCT_HOST_PACKAGES += \
    signapk \
    avbtool \
    brotli \
    aapt2 \
    deapexer \
    debugfs \
    zipalign \
    apexer \
    brillo_update_payload

# RCS Service
PRODUCT_PACKAGES += \
    rcscommon \
    rcscommon.xml \
    rcsservice \
    rcs_service_aidl \
    rcs_service_aidl.xml \
    rcs_service_aidl_static \
    rcs_service_api \
    rcs_service_api.xml

# Bluetooth
# Disable AAC whitelist
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.vendor.bt.a2dp.aac_whitelist=false

# Bluetooth Audio (A2DP)
PRODUCT_PACKAGES += libbthost_if

# MSIM manual provisioning
PRODUCT_PACKAGES += ims-ext-common
PRODUCT_PACKAGES += telephony-ext
#PRODUCT_BOOT_JARS += telephony-ext

# Telephony packages
PRODUCT_PACKAGES += \
    Stk \
    CellBroadcastReceiver

# Extra Packages
PRODUCT_PACKAGES += \
    GoogleWallpaperPickerOverlay \
    Launcher3QuickStep \
    LiveWallpapers \
    LiveWallpapersPicker \
    PixeldustThemesStub \
    QuickAccessWallet \
    SimpleDeviceConfig \
    StitchImage \
    ThemePicker \
    Themes \

# Themes
-include vendor/themes/common.mk

# Include Potato volume panels
-include packages/apps/PotatoPlugins/plugins.mk

# Devices should opt-in to include Seedvault
ifneq ($(filter blueline bonito bramble coral crosshatch miatoll redfin sunfish surya taimen,$(TARGET_DEVICE)),)
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += \
    vendor/pixeldust/overlay-seedvault
PRODUCT_PACKAGES += \
    Seedvault
endif

# Devices should opt-in to include PixelDustLauncher
ifneq ($(filter marlin sailfish blueline bonito bramble coral crosshatch miatoll redfin sunfish surya taimen,$(TARGET_DEVICE)),)
INCLUDE_PIXELDUSTLAUNCHER := true
endif

ifeq ($(INCLUDE_PIXELDUSTLAUNCHER), true)
REMOVE_GAPPS_PACKAGES += \
    NexusLauncherRelease
else
INCLUDE_PIXELLAUNCHER := true
DEVICE_PACKAGE_OVERLAYS += \
    vendor/pixeldust/overlay-nexuslauncher
endif

# Pixel specific
ifneq ($(filter blueline bonito bramble coral crosshatch redfin sunfish taimen,$(TARGET_DEVICE)),)
PRODUCT_PACKAGES += \
    ElmyraService
endif

# Android Beam
PRODUCT_COPY_FILES += \
    vendor/pixeldust/config/permissions/android.software.nfc.beam.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.nfc.beam.xml

# Backup Tool
ifeq ($(AB_OTA_UPDATER),true)
PRODUCT_COPY_FILES += \
    vendor/pixeldust/prebuilt/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/pixeldust/prebuilt/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/pixeldust/prebuilt/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh
else
PRODUCT_COPY_FILES += \
    vendor/pixeldust/prebuilt/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/pixeldust/prebuilt/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/pixeldust/prebuilt/bin/50-base.sh:system/addon.d/50-base.sh
endif