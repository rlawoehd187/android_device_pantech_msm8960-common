# Do not use graphite on host modules or the clang compiler.
# Also do not bother using on darwin.
ifeq ($(HOST_OS),linux)
  ifneq ($(strip $(LOCAL_IS_HOST_MODULE)),true)
    ifneq ($(strip $(LOCAL_CLANG)),true)

      # If it gets this far enable graphite by default from here on out.
      ifneq (1,$(words $(filter $(LOCAL_DISABLE_GRAPHITE),$(LOCAL_MODULE))))
        ifdef LOCAL_CFLAGS
          LOCAL_CFLAGS += $(GRAPHITE_FLAGS)
        else
          LOCAL_CFLAGS := $(GRAPHITE_FLAGS)
        endif
        ifdef LOCAL_LDFLAGS
          LOCAL_LDFLAGS += $(GRAPHITE_FLAGS)
        else
          LOCAL_LDFLAGS := $(GRAPHITE_FLAGS)
        endif
      endif
    endif
  endif
endif

# General flags for gcc 4.9+ to allow compilation to complete.
# Many of these are device specific and should be set in device make files.
# See vendor/sm.  Add more sections below, and also to vendor/sm/device/sm_device.mk if need be.

# modules that need -Wno-error=maybe-uninitialized
ifdef MAYBE_UNINITIALIZED
  ifeq (1,$(words $(filter $(MAYBE_UNINITIALIZED),$(LOCAL_MODULE))))
    ifdef LOCAL_CFLAGS
      LOCAL_CFLAGS += -Wno-error=maybe-uninitialized
    else
      LOCAL_CFLAGS := -Wno-error=maybe-uninitialized
    endif
  endif
endif

#ifneq ($(filter 5.1% 6.0%,$(SM_AND_NAME)),)
  ifdef WARN_NO_ERROR
    ifeq (1,$(words $(filter $(WARN_NO_ERROR),$(LOCAL_MODULE))))
      ifdef LOCAL_CFLAGS
        LOCAL_CFLAGS += -Wno-error
      else
        LOCAL_CFLAGS := -Wno-error
      endif
    endif
  endif
#endif

#ifneq ($(filter 5.1% 6.0%,$(SM_AND_NAME)),)
  ifeq ($(strip $(LOCAL_IS_HOST_MODULE)),true)
    ifeq (1,$(words $(filter libcutils, $(LOCAL_MODULE))))
      ifdef LOCAL_CFLAGS
        LOCAL_CFLAGS += -pthread
      else
        LOCAL_CFLAGS := -pthread
      endif
      ifeq ($(strip $(HOST_OS)),linux)
        ifdef LOCAL_LDLIBS
          LOCAL_LDLIBS += -ldl -lpthread
        else
          LOCAL_LDLIBS := -ldl -lpthread
        endif
      endif
    endif
  endif
#endif

# Allow modules to be compiled with different gcc versions.  Currently only for arm.
ifeq ($(strip $(TARGET_ARCH)),arm)
  ifneq ($(filter 4.9%,$(SM_AND_NAME)),)
    ifeq (1,$(words $(filter $(GCC_4_8_MODULES), $(LOCAL_MODULE))))
      LOCAL_CC := prebuilts/gcc/$(HOST_PREBUILT_TAG)/arm/arm-linux-androideabi-4.8/bin/arm-linux-androideabi-gcc$(HOST_EXECUTABLE_SUFFIX)
      LOCAL_CXX := prebuilts/gcc/$(HOST_PREBUILT_TAG)/arm/arm-linux-androideabi-4.8/bin/arm-linux-androideabi-g++
    endif
  endif
endif

#end SaberMod
