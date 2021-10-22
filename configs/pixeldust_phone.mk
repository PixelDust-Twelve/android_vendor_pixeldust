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

$(call inherit-product, vendor/pixeldust/configs/audio.mk)
$(call inherit-product, vendor/pixeldust/configs/fu.mk)
$(call inherit-product, vendor/pixeldust/configs/pixeldust_main.mk)
$(call inherit-product, vendor/pixeldust/configs/pixeldust_optimizations.mk)
$(call inherit-product, vendor/pixeldust/configs/pixeldust_packages.mk)
$(call inherit-product, vendor/pixeldust/configs/version.mk)
$(call inherit-product, vendor/pixeldust/configs/ota.mk)
$(call inherit-product, vendor/pixeldust/configs/pixel_apns.mk)
$(call inherit-product, vendor/pixeldust/configs/telephony.mk)
$(call inherit-product, vendor/pixeldust/prebuilt/bootanimation/bootanimation.mk)

# Include pixel specific sepolicy rules
ifneq ($(filter blueline bonito bramble coral crosshatch redfin sunfish,$(TARGET_DEVICE)),)
$(call inherit-product, vendor/pixeldust/configs/pixel_sepolicy.mk)
endif

# Per default Google apex is not included (as it is only intended for pixel devices)
ifndef TARGET_EXCLUDE_GOOGLE_APEX
  TARGET_EXCLUDE_GOOGLE_APEX := false
endif
ifeq ($(TARGET_EXCLUDE_GOOGLE_APEX),false)
$(call inherit-product, vendor/pixeldust/configs/apex.mk)
endif

# Gapps
ifeq ($(WITH_GMS),true)
$(call inherit-product, vendor/pixelgapps/pixel-gapps.mk)

# SetupWizard and Google Assistant properties
PRODUCT_PRODUCT_PROPERTIES += \
    ro.setupwizard.rotation_locked=true \
    setupwizard.theme=glif_v3_light \
    ro.opa.eligible_device=true
endif


# Gboard configuration
PRODUCT_PRODUCT_PROPERTIES += \
    ro.com.google.ime.bs_theme=true \
    ro.com.google.ime.theme_id=5 \
    ro.com.google.ime.system_lm_dir=/product/usr/share/ime/google/d3_lms

# SetupWizard configuration
PRODUCT_PRODUCT_PROPERTIES += \
    ro.setupwizard.enterprise_mode=1 \
    ro.setupwizard.esim_cid_ignore=00000001 \
    ro.setupwizard.rotation_locked=true \
    setupwizard.enable_assist_gesture_training=true \
    setupwizard.feature.baseline_setupwizard_enabled=true \
    setupwizard.feature.device_default_dark_mode=true \
    setupwizard.feature.show_pai_screen_in_main_flow.carrier1839=false \
    setupwizard.feature.show_pixel_tos=true \
    setupwizard.feature.skip_button_use_mobile_data.carrier1839=true \
    setupwizard.theme=glif_v3_light

# Gboard side padding
PRODUCT_PRODUCT_PROPERTIES += \
    ro.com.google.ime.kb_pad_port_l=4 \
    ro.com.google.ime.kb_pad_port_r=4 \
    ro.com.google.ime.kb_pad_land_l=64 \
    ro.com.google.ime.kb_pad_land_r=64 \

# StorageManager configuration
PRODUCT_PRODUCT_PROPERTIES += \
    ro.storage_manager.show_opt_in=false

# Google legal
PRODUCT_PRODUCT_PROPERTIES += \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html

# Google Play services configuration
PRODUCT_PRODUCT_PROPERTIES += \
    ro.com.google.clientidbase=android-google \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent

# CarrierSetup configuration
PRODUCT_PRODUCT_PROPERTIES += \
    ro.carriersetup.vzw_consent_page=true

# Use gestures by default
PRODUCT_PROPERTY_OVERRIDES += \
    ro.boot.vendor.overlay.theme=com.android.internal.systemui.navbar.gestural;com.google.android.systemui.gxoverlay

# Disable RescueParty due to high risk of data loss
PRODUCT_PRODUCT_PROPERTIES += \
    persist.sys.disable_rescue=true

# Disable touch video heatmap to reduce latency, motion jitter, and CPU usage
# on supported devices with Deep Press input classifier HALs and models
PRODUCT_PRODUCT_PROPERTIES += \
    ro.input.video_enabled=false

# Enable one-handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode=true
