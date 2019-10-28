# Copyright (C) 2014-2015 The SaberMod Project
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
#

# Written for SaberMod toolchains
# TARGET_SM_AND and TARGET_SM_KERNEL can be set before this file, to override the default of gcc 4.9 for ROM.
# This is to avoid hardcoding the gcc versions for the ROM and kernels.

# Inherit sabermod configs.  Default to arm if LOCAL_ARCH is not defined.
ifdef TARGET_SM_AND
export TARGET_SM_AND := $(TARGET_SM_AND)
  $(warning ROM gcc version $(TARGET_SM_AND).)
else
  $(warning =====================================================================)
  $(warning TARGET_SM_AND not defined.)
  $(warning Defaulting to gcc 4.9 for ROM.)
  $(warning =====================================================================)
export TARGET_SM_AND := 4.9
endif

ifdef TARGET_SM_KERNEL
  export TARGET_SM_KERNEL := $(TARGET_SM_KERNEL)
  $(warning Kernel gcc version $(TARGET_SM_KERNEL).)
else
  $(warning =====================================================================)
  $(warning TARGET_SM_KERNEL not defined.)
  $(warning Defaulting to ROM gcc version $(TARGET_SM_AND).)
  $(warning =====================================================================)
  export TARGET_SM_KERNEL := $(TARGET_SM_AND)
endif

# Set GCC colors
export GCC_COLORS := 'error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Find host os
UNAME := $(shell uname -s)

ifeq ($(strip $(UNAME)),Linux)
  HOST_OS := linux
endif

ifndef LOCAL_ARCH
  $(warning =====================================================================)
  $(warning Can not determine arch type, defaulting to arm)
  $(warning  To change this set LOCAL_ARCH :=)
  $(warning =====================================================================)
  LOCAL_ARCH := arm
endif

# Only use these compilers on linux host and arm targets.

ifeq ($(strip $(HOST_OS)),linux)
  ifneq ($(filter arm arm64,$(LOCAL_ARCH)),)
    ifeq ($(strip $(LOCAL_ARCH)),arm)

export TARGET_ARCH_LIB_PATH := $(ANDROID_BUILD_TOP)/prebuilts/gcc/$(HOST_PREBUILT_TAG)/arm/arm-linux-androideabi-$(TARGET_SM_AND)/lib:$(ANDROID_BUILD_TOP)/prebuilts/gcc/$(HOST_PREBUILT_TAG)/arm/arm-eabi-$(TARGET_SM_KERNEL)/lib

      # Path to ROM toolchain
      SM_AND_PATH := prebuilts/gcc/$(HOST_PREBUILT_TAG)/arm/arm-linux-androideabi-$(TARGET_SM_AND)
      SM_AND := $(shell $(SM_AND_PATH)/bin/arm-linux-androideabi-gcc --version)

      # Find strings in version info
      ifneq ($(filter %sabermod,$(SM_AND)),)
        SM_AND_NAME := $(filter %sabermod,$(SM_AND))
        SM_AND_DATE := $(filter 20140% 20141% 20150% 20151%,$(SM_AND))
        SM_AND_STATUS := $(filter (release) (prerelease) (experimental),$(SM_AND))
        SM_AND_VERSION := $(SM_AND_NAME)-$(SM_AND_DATE)-$(SM_AND_STATUS)

        # Write version info to build.prop
        PRODUCT_PROPERTY_OVERRIDES += \
          ro.sm.android=$(SM_AND_VERSION)

        
        # Graphite ROM flags
        OPT1 := [graphite]

        # Some graphite flags are only available for certain gcc versions
 export GRAPHITE_UNROLL_AND_JAM_AND := $(filter 5.1% 6.0%,$(SM_AND_NAME))

        # Graphite flags and friends
        BASE_GRAPHITE_FLAGS := \
          -fgraphite \
          -fgraphite-identity \
          -floop-flatten \
          -ftree-loop-linear \
          -floop-interchange \
          -floop-strip-mine \
          -floop-block
        ifneq ($(GRAPHITE_UNROLL_AND_JAM_AND),)
          BASE_GRAPHITE_FLAGS += \
            -floop-unroll-and-jam
        endif

        # Check if there's already something set somewhere.
        ifndef GRAPHITE_FLAGS
          GRAPHITE_FLAGS := \
            $(BASE_GRAPHITE_FLAGS)
        else
          GRAPHITE_FLAGS += \
            $(BASE_GRAPHITE_FLAGS)
        endif

        # Legacy gcc doesn't understand this flag
        ifneq ($(strip $(USE_LEGACY_GCC)),true)
          GRAPHITE_FLAGS += \
            -Wno-error=maybe-uninitialized
        endif
      endif

      # Path to kernel toolchain
      SM_KERNEL_PATH := prebuilts/gcc/$(HOST_PREBUILT_TAG)/arm/arm-eabi-$(TARGET_SM_KERNEL)
      SM_KERNEL := $(shell $(SM_KERNEL_PATH)/bin/arm-eabi-gcc --version)

      ifneq ($(filter %sabermod,$(SM_KERNEL)),)
 export SM_KERNEL_NAME := $(filter %sabermod,$(SM_KERNEL))
        SM_KERNEL_DATE := $(filter 20140% 20141% 20150% 20151%,$(SM_KERNEL))
        SM_KERNEL_STATUS := $(filter (release) (prerelease) (experimental),$(SM_KERNEL))
        SM_KERNEL_VERSION := $(SM_KERNEL_NAME)-$(SM_KERNEL_DATE)-$(SM_KERNEL_STATUS)

        PRODUCT_PROPERTY_OVERRIDES += \
          ro.sm.kernel=$(SM_KERNEL_VERSION)

        # Graphite flags for kernel

        # Some graphite flags are only available for certain gcc versions
 export GRAPHITE_UNROLL_AND_JAM_KERNEL := $(filter 5.1% 6.0%,$(SM_KERNEL_NAME))

        BASE_GRAPHITE_KERNEL_FLAGS := \
          -fgraphite \
          -fgraphite-identity \
          -floop-flatten \
          -ftree-loop-linear \
          -floop-interchange \
          -floop-strip-mine \
          -floop-block \
          -floop-nest-optimize
        ifneq ($(GRAPHITE_UNROLL_AND_JAM_KERNEL),)
          BASE_GRAPHITE_KERNEL_FLAGS += \
            -floop-unroll-and-jam
        endif

        # Check if there's already something set somewhere.
        ifndef GRAPHITE_KERNEL_FLAGS
   export GRAPHITE_KERNEL_FLAGS := \
            $(BASE_GRAPHITE_KERNEL_FLAGS)
        else
   export GRAPHITE_KERNEL_FLAGS := \
            $(BASE_GRAPHITE_KERNEL_FLAGS) \
            $(GRAPHITE_KERNEL_FLAGS)
        endif

        ifneq ($(filter 5.1% 6.0%,$(SM_KERNEL_NAME)),)
          # Flags to disable graphite in the kernel for gcc 5/6
   export LOCAL_DISABLE_KERNEL_GRAPHITE := \
            -fno-graphite \
            -fno-graphite-identity \
            -fno-loop-flatten \
            -fno-tree-loop-linear \
            -fno-loop-interchange \
            -fno-loop-strip-mine \
            -fno-loop-block \
            -fno-loop-nest-optimize \
            -fno-loop-unroll-and-jam \
            -fno-loop-parallelize-all \
            -ftree-parallelize-loops=0 \
            -fno-openmp
        endif

        ifeq ($(strip $(LOCAL_STRICT_ALIASING)),true)

          # strict-aliasing kernel flags
   export KERNEL_STRICT_FLAGS := \
            -fstrict-aliasing \
            -Werror=strict-aliasing
        endif
      endif
    endif

    ifeq ($(strip $(LOCAL_ARCH)),arm64)

export TARGET_ARCH_LIB_PATH := $(ANDROID_BUILD_TOP)/prebuilts/gcc/$(HOST_PREBUILT_TAG)/aarch64/aarch64-linux-android-$(TARGET_SM_AND)/lib:$(ANDROID_BUILD_TOP)/prebuilts/gcc/$(HOST_PREBUILT_TAG)/aarch64/aarch64-$(TARGET_SM_KERNEL)/lib

      # Path to toolchain
      SM_AND_PATH := prebuilts/gcc/$(HOST_PREBUILT_TAG)/aarch64/aarch64-linux-android-$(TARGET_SM_AND)
      SM_AND := $(shell $(SM_AND_PATH)/bin/aarch64-linux-android-gcc --version)

      # Find strings in version info
      ifneq ($(filter %sabermod,$(SM_AND)),)
        SM_AND_NAME := $(filter %sabermod,$(SM_AND))
        SM_AND_DATE := $(filter 20140% 20141% 20150% 20151%,$(SM_AND))
        SM_AND_STATUS := $(filter (release) (prerelease) (experimental),$(SM_AND))
        SM_AND_VERSION := $(SM_AND_NAME)-$(SM_AND_DATE)-$(SM_AND_STATUS)

        # Write version info to build.prop
        PRODUCT_PROPERTY_OVERRIDES += \
          ro.sm.android=$(SM_AND_VERSION)

        # Graphite ROM flags
        OPT1 := [graphite]

        # Some graphite flags are only available for certain gcc versions
 export GRAPHITE_UNROLL_AND_JAM_AND := $(filter 5.1% 6.0%,$(SM_AND_NAME))

        # Graphite flags and friends
        BASE_GRAPHITE_FLAGS := \
          -fgraphite \
          -fgraphite-identity \
          -floop-flatten \
          -ftree-loop-linear \
          -floop-interchange \
          -floop-strip-mine \
          -floop-block
        ifneq ($(GRAPHITE_UNROLL_AND_JAM_AND),)
          BASE_GRAPHITE_FLAGS += \
            -floop-unroll-and-jam
        endif

        # Check if there's already something set somewhere.
        ifndef GRAPHITE_FLAGS
          GRAPHITE_FLAGS := \
            $(BASE_GRAPHITE_FLAGS)
        else
          GRAPHITE_FLAGS += \
            $(BASE_GRAPHITE_FLAGS)
        endif

        # Legacy gcc doesn't understand this flag
        ifneq ($(strip $(USE_LEGACY_GCC)),true)
          GRAPHITE_FLAGS += \
            -Wno-error=maybe-uninitialized
        endif
      endif
    
      # Path to kernel toolchain
      SM_KERNEL_PATH := prebuilts/gcc/$(HOST_PREBUILT_TAG)/aarch64/aarch64-$(TARGET_SM_KERNEL)
      SM_KERNEL := $(shell $(SM_KERNEL_PATH)/bin/aarch64-gcc --version)

      ifneq ($(filter %sabermod,$(SM_KERNEL)),)
 export SM_KERNEL_NAME := $(filter %sabermod,$(SM_KERNEL))
        SM_KERNEL_DATE := $(filter 20140% 20141% 20150% 20151%,$(SM_KERNEL))
        SM_KERNEL_STATUS := $(filter (release) (prerelease) (experimental),$(SM_KERNEL))
        SM_KERNEL_VERSION := $(SM_KERNEL_NAME)-$(SM_KERNEL_DATE)-$(SM_KERNEL_STATUS)

        PRODUCT_PROPERTY_OVERRIDES += \
          ro.sm.kernel=$(SM_KERNEL_VERSION)

        # Graphite flags for kernel

        # Some graphite flags are only available for certain gcc versions
 export GRAPHITE_UNROLL_AND_JAM_KERNEL := $(filter 5.1% 6.0%,$(SM_KERNEL_NAME))

        BASE_GRAPHITE_KERNEL_FLAGS := \
          -fgraphite \
          -fgraphite-identity \
          -floop-flatten \
          -ftree-loop-linear \
          -floop-interchange \
          -floop-strip-mine \
          -floop-block \
          -floop-nest-optimize
        ifneq ($(GRAPHITE_UNROLL_AND_JAM_KERNEL),)
          BASE_GRAPHITE_KERNEL_FLAGS += \
            -floop-unroll-and-jam
        endif

        # Check if there's already something set somewhere.
        ifndef GRAPHITE_KERNEL_FLAGS
   export GRAPHITE_KERNEL_FLAGS := \
            $(BASE_GRAPHITE_KERNEL_FLAGS)
        else
   export GRAPHITE_KERNEL_FLAGS := \
            $(BASE_GRAPHITE_KERNEL_FLAGS) \
            $(GRAPHITE_KERNEL_FLAGS)
        endif

        ifneq ($(filter 5.1% 6.0%,$(SM_KERNEL_NAME)),)
          # Flags to disable graphite in the kernel for gcc 5/6
   export LOCAL_DISABLE_KERNEL_GRAPHITE := \
            -fno-graphite \
            -fno-graphite-identity \
            -fno-loop-flatten \
            -fno-tree-loop-linear \
            -fno-loop-interchange \
            -fno-loop-strip-mine \
            -fno-loop-block \
            -fno-loop-nest-optimize \
            -fno-loop-unroll-and-jam \
            -fno-loop-parallelize-all \
            -ftree-parallelize-loops=0 \
            -fno-openmp
        endif

        ifeq ($(strip $(LOCAL_STRICT_ALIASING)),true)

        # strict-aliasing kernel flags
 export KERNEL_STRICT_FLAGS := \
          -fstrict-aliasing \
          -Werror=strict-aliasing
        endif
      endif
    endif
    ifdef TARGET_ARCH_LIB_PATH

      # Add extra libs for the compilers to use
export LD_LIBRARY_PATH := $(TARGET_ARCH_LIB_PATH):$(LD_LIBRARY_PATH)
export LIBRARY_PATH := $(TARGET_ARCH_LIB_PATH):$(LIBRARY_PATH)
    endif

    ifneq ($(GRAPHITE_FLAGS),)

      # Force disable some modules that are not compatible with graphite flags.
      # Add more modules if needed for devices in device/sm_device.mk or by ROM in product/rom_product.mk with
      # LOCAL_DISABLE_GRAPHITE:=

      ifneq ($(filter 4.8% 4.9%,$(SM_AND_NAME)),)
        LOCAL_BASE_DISABLE_GRAPHITE := \
          libunwind \
          libFFTEm \
          libicui18n \
          libskia \
          libvpx \
          libmedia_jni \
          libstagefright_mp3dec \
          libart \
          mdnsd \
          libwebrtc_spl \
          third_party_WebKit_Source_core_webcore_svg_gyp \
          libjni_filtershow_filters \
          libavformat \
          libavcodec \
          skia_skia_library_gyp \
          libSR_Core \
          third_party_libvpx_libvpx_gyp \
          ui_gl_gl_gyp \
          fio \
          libpdfiumcore \
          libFraunhoferAAC
      endif

      ifneq ($(filter 5.1% 6.0%,$(SM_AND_NAME)),)
        LOCAL_BASE_DISABLE_GRAPHITE := \
          libjavacore \
          libc_bionic \
          libnetutils \
          libandroid_runtime \
          libpdfiumcore \
          libicui18n \
          libicuuc \
          libhwui \
          libskia \
          dhcpcd \
          libpac \
          libRS \
          clatd \
          libsoftkeymaster \
          libstagefright_avc_common \
          libstagefright_color_conversion \
          libstagefright_matroska \
          libwebm \
          libstagefright_amrnb_common \
          libart \
          libart-compiler \
          libjavacrypto \
          libstagefright_omx \
          libstagefright_amrnbdec \
          librtp_jni \
          libstagefright_amrnbenc \
          libFraunhoferAAC \
          audio.r_submix.default \
          liboverlay \
          libmedia_jni \
          libstagefright_amrwbdec \
          libstagefright_avcenc \
          libstagefright_mp3dec \
          libstagefright_m4vh263dec \
          libstagefright_m4vh263enc \
          libwebrtc_apm
      endif

      # Check if there's already something set somewhere.
      ifndef LOCAL_DISABLE_GRAPHITE
        LOCAL_DISABLE_GRAPHITE := \
          $(LOCAL_BASE_DISABLE_GRAPHITE)
      else
        LOCAL_DISABLE_GRAPHITE += \
          $(LOCAL_BASE_DISABLE_GRAPHITE)
      endif
    endif
    # GCC 5/6 variables.
    ifneq ($(filter 5.1% 6.0%,$(SM_KERNEL_NAME)),)
      WARN_NO_ERROR := \
        base_base_gyp
    endif
  endif
else
    $(warning ========================================================================)
    $(warning   Limited optimization options are available outside of linux host OS.)
    $(warning   To take advantage of all optimization options, build on linux host OS.)
    $(warning ========================================================================)
endif


# General flags for gcc 4.9 to allow compilation to complete.
# Commented out for now since there's no common (non-device specific) modules to list here.
# Add more modules if needed for devices in device/sm_device.mk or by ROM in product/rom_product.mk with
# MAYBE_UNINITIALIZED :=

# Check if there's already something set somewhere.
ifndef MAYBE_UNINITIALIZED
  MAYBE_UNINITIALIZED := \
    fastboot
else
  MAYBE_UNINITIALIZED += \
    fastboot
endif

# O3 optimizations (enable by default)
  OPT2 := [O3]

# Some flags are only available for certain gcc versions
export DISABLE_SANITIZE_LEAK := $(filter 4.8%,$(SM_AND))

OPT3 := [strict]
OPT6 := [mem-sanitizer]
OPT7 := [OpenMP]

# Right all optimization level options to build.prop
GCC_OPTIMIZATION_LEVELS := $(OPT1)$(OPT2)$(OPT4)$(OPT3)$(OPT6)$(OPT7)$(OPT5)
ifneq ($(GCC_OPTIMIZATION_LEVELS),)
  PRODUCT_PROPERTY_OVERRIDES += \
    ro.sm.flags="$(GCC_OPTIMIZATION_LEVELS)"
endif

# Set toolchain
 TARGET_GCC_VERSION_EXP := $(TARGET_SM_AND)
 KERNEL_TOOLCHAIN_PREFIX := arm-eabi-
 KERNEL_TOOLCHAIN := "$(ANDROID_BUILD_TOP)/$(SM_KERNEL_PATH)/bin"
#For kernel
 export CROSS_COMPILE_NAME := $(KERNEL_TOOLCHAIN)/arm-linux-gnueabi-

include device/pantech/msm8960-common/sabermod/saberconfig.mk
