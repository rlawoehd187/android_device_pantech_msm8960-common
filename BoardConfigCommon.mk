#
# Copyright (C) 2016 XDAVN
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

COMMON_PATH := device/pantech/msm8960-common

# inherit from the proprietary version
-include vendor/pantech/msm8960-common/BoardConfigVendor.mk
TARGET_SPECIFIC_HEADER_PATH 		:= device/pantech/msm8960-common/include
TARGET_RELEASETOOLS_EXTENSIONS 		:= device/pantech/msm8960-common

BOARD_VENDOR 					:= pantech

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := MSM8960
TARGET_NO_BOOTLOADER := true

# Platform
TARGET_BOARD_PLATFORM := msm8960
TARGET_BOARD_PLATFORM_GPU := qcom-adreno200

# Architecture
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := krait

# QCOM hardware
BOARD_USES_QCOM_HARDWARE := true

#Boot and recovery config
BOARD_KERNEL_BASE := 0x80200000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_FORCE_RAMDISK_ADDRESS := 0x82200000
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset 0x2000000
BOARD_KERNEL_CMDLINE := console=NULL,115200,n8 androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x3F ehci-hcd.park=3 loglevel=0 vmalloc=0x16000000 androidboot.selinux=permissive
TARGET_KERNEL_CROSS_COMPILE_PREFIX := arm-linux-androideabi-


TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_SUPPRESS_EMMC_WIPE := true

#Init
TARGET_UNIFIED_DEVICE := true
TARGET_INIT_VENDOR_LIB := libinit_pantech
TARGET_RECOVERY_DEVICE_MODULES := libinit_pantech

# QCOM
BOARD_USES_QCOM_HARDWARE 		:= true
TARGET_GLOBAL_CFLAGS += -DQCOM_HARDWARE -DQCOM_BSP
TARGET_GLOBAL_CPPFLAGS += -DQCOM_HARDWARE -DQCOM_BSP

BOARD_USES_OVERLAY 				:= true
USE_OPENGL_RENDERER 				:= true
TARGET_USES_ION					:= true
TARGET_USES_C2D_COMPOSITION 			:= true
TARGET_DISPLAY_INSECURE_MM_HEAP 	:= true

# LightHAL
TARGET_PROVIDES_LIBLIGHT 			:= true

HAVE_ADRENO_SOURCE				:= false
OVERRIDE_RS_DRIVER 				:= libRSDriver_adreno.so

# Audio
BOARD_USES_ALSA_AUDIO := true
AUDIO_USE_LL_AS_PRIMARY_OUTPUT := true
USE_CUSTOM_AUDIO_POLICY := 1

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_QCOM := true
BLUETOOTH_HCI_USE_MCT := true

# QCOM enhanced A/V
TARGET_ENABLE_QC_AV_ENHANCEMENTS 	:= true

BOARD_USES_SECURE_SERVICES 		:= true

BOARD_USES_EXTRA_THERMAL_SENSOR 	:= true

# Camera
BOARD_GLOBAL_CFLAGS += -DCAMERA_VENDOR_L_COMPAT
TARGET_PROVIDES_CAMERA_HAL := true
USE_DEVICE_SPECIFIC_CAMERA := true
BOARD_USES_CAMERA_FAST_AUTOFOCUS 	:= true
BOARD_GLOBAL_CFLAGS += -DPANTECH_CAMERA_HARDWARE
TARGET_NEEDS_PLATFORM_TEXT_RELOCATIONS := true
BOARD_GLOBAL_CFLAGS += -DMETADATA_CAMERA_SOURCE
TARGET_HAS_LEGACY_CAMERA_HAL1 := true

#Media
TARGET_USES_MEDIA_EXTENSIONS := true


#Ril class
BOARD_RIL_CLASS := ../../../device/pantech/msm8960-common/ril/

#Use cyanogenmod hardware
BOARD_USES_CYANOGEN_HARDWARE := true

#Preload Boot Animation
TARGET_BOOTANIMATION_PRELOAD 		:= true

# GPS
BOARD_VENDOR_QCOM_LOC_PDK_FEATURE_SET := true
TARGET_NO_RPC := true
TARGET_PROVIDES_GPS_LOC_API := true

# PowerHAL
TARGET_POWERHAL_VARIANT			:= qcom
#CM_POWERHAL_EXTENSION			:= lehoang

# Properties
TARGET_SYSTEM_PROP += $(COMMON_PATH)/system.prop

# Enable dex-preoptimization to speed up first boot sequence
ifeq ($(HOST_OS),linux)
  ifeq ($(TARGET_BUILD_VARIANT),user)
    ifeq ($(WITH_DEXPREOPT),)
      WITH_DEXPREOPT := true
    endif
  endif
endif
DONT_DEXPREOPT_PREBUILTS := true

# Init
TARGET_NO_INITLOGO := true

# Charger
BOARD_CHARGER_ENABLE_SUSPEND 		:= true

# Enable keymaster app checking
TARGET_KEYMASTER_WAIT_FOR_QSEE := true

BOARD_VOLD_MAX_PARTITIONS := 28

# Sensors
TARGET_NEEDS_GCC_LIBC := true

# Flags
BOARD_NO_SECURE_DISCARD := true

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=7

MALLOC_SVELTE := true

# Encryption
TARGET_HW_DISK_ENCRYPTION := false

TARGET_NO_SD_ADOPT_ENCRYPTION := true

#BOARD_USES_QC_TIME_SERVICES 		:= true

PRODUCT_GMS_CLIENTID_BASE 			:= android-pantech
# Enable Minikin text layout engine
USE_MINIKIN 						:= true

#Enable prebuild chromium for cut time build
PRODUCT_PREBUILT_WEBVIEWCHROMIUM 	:= yes

# Include an expanded selection of fonts
EXTENDED_FONT_FOOTPRINT 			:= true

# qcom sepolicy
include device/qcom/sepolicy/sepolicy.mk

#BOARD_SEPOLICY_DIRS += \
       device/pantech/msm8960-common/sepolicy
       
# Wifi
BOARD_HAS_QCOM_WLAN              		:= true
BOARD_WLAN_DEVICE                		:= qcwcn
WPA_SUPPLICANT_VERSION           		:= VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER      		:= NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB 		:= lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_HOSTAPD_DRIVER             		:= NL80211
BOARD_HOSTAPD_PRIVATE_LIB        		:= lib_driver_cmd_$(BOARD_WLAN_DEVICE)
WIFI_DRIVER_MODULE_NAME          		:= "wlan"
WIFI_DRIVER_FW_PATH_STA          		:= "sta"
WIFI_DRIVER_FW_PATH_AP           		:= "ap"
