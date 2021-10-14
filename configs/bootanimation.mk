# Copyright (C) 2019-2021 The PixelDust Project
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

# Bootanimation
ifeq ($(BOOTANIMATION),1080)
     PRODUCT_COPY_FILES += vendor/pixeldust/prebuilt/bootanimation/1080.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip
else ifeq ($(BOOTANIMATION),1440)
     PRODUCT_COPY_FILES += vendor/pixeldust/prebuilt/bootanimation/1440.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip
else ifeq ($(BOOTANIMATION),720)
     PRODUCT_COPY_FILES += vendor/pixeldust/prebuilt/bootanimation/720.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip
else
    ifeq ($(BOOTANIMATION),)
        $(warning "BOOTANIMATION is undefined, assuming 1080p")
    else
        $(warning "Current bootanimation res is not supported, forcing 1080p")
    endif
    PRODUCT_COPY_FILES += vendor/pixeldust/prebuilt/bootanimation/1080.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip
endif

