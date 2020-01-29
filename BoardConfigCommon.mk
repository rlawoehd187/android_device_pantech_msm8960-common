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

# Binder
TARGET_USES_64_BIT_BINDER := true

# QCOM hardware
BOARD_USES_QCOM_HARDWARE := true

# Boot and recovery config
BOARD_KERNEL_BASE := 0x80200000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_FORCE_RAMDISK_ADDRESS := 0x82200000
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset 0x2000000
BOARD_KERNEL_IMAGE_NAME := zImage
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
USE_XML_AUDIO_POLICY_CONF := 1

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_QCOM := true
BLUETOOTH_HCI_USE_MCT := true

# QCOM enhanced A/V
TARGET_ENABLE_QC_AV_ENHANCEMENTS 	:= true

BOARD_USES_SECURE_SERVICES 		:= true

BOARD_USES_EXTRA_THERMAL_SENSOR 	:= true

# Camera
TARGET_PROVIDES_CAMERA_HAL := true
USE_DEVICE_SPECIFIC_CAMERA := true

TARGET_NEEDS_PLATFORM_TEXT_RELOCATIONS:= true

# Media
TARGET_USES_MEDIA_EXTENSIONS := true

# HIDL
DEVICE_MANIFEST_FILE := $(COMMON_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(COMMON_PATH)/compatibility_matrix.xml

# Ril class
BOARD_RIL_CLASS := ../../../device/pantech/msm8960-common/ril/

# Preload Boot Animation
TARGET_BOOTANIMATION_PRELOAD 		:= true

# Shipping API
PRODUCT_SHIPPING_API_LEVEL := 19

# GPS
BOARD_VENDOR_QCOM_LOC_PDK_FEATURE_SET := true
TARGET_NO_RPC := true
TARGET_PROVIDES_GPS_LOC_API := true

# Power
TARGET_HAS_LEGACY_POWER_STATS := true
TARGET_HAS_NO_WIFI_STATS := true
TARGET_USES_INTERACTION_BOOST := true

# Properties
TARGET_SYSTEM_PROP += $(COMMON_PATH)/system.prop

# Dexpreopt
ifeq ($(HOST_OS),linux)
  ifneq ($(TARGET_BUILD_VARIANT),eng)
    ifeq ($(WITH_DEXPREOPT),)
      WITH_DEXPREOPT := true
      WITH_DEXPREOPT_BOOT_IMG_AND_SYSTEM_SERVER_ONLY := true
    endif
  endif
endif

# SDClang
TARGET_USE_SDCLANG := true

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

# Encryption
TARGET_HW_DISK_ENCRYPTION := false

TARGET_NO_SD_ADOPT_ENCRYPTION := true

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
PRODUCT_VENDOR_MOVE_ENABLED      		:= true
WIFI_DRIVER_MODULE_NAME          		:= "wlan"
WIFI_DRIVER_FW_PATH_STA          		:= "sta"
WIFI_DRIVER_FW_PATH_AP           		:= "ap"
