ifneq ($(filter ef51 ef52l ef50l,$(TARGET_DEVICE)),)
$(warning $(TARGET_DEVICE) device found for msm8960-common)
LOCAL_PATH := $(call my-dir)

include $(call all-makefiles-under,$(LOCAL_PATH))

endif
