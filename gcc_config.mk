
# add modules here
GCC_4_9_MODULES := \
	ip \
	tc \
	libnetutils \
	libjni_jpegutil \
	libgiftranscode \
	libart \
	libavcodec \
	

		


#=================================================================================
# This file must be included in build/core/multilib.mk
# Allow modules to be compiled with different gcc versions.  Currently only for arm.
ifneq ($(strip $(my_prefix)),HOST_)
    ifeq (1,$(words $(filter $(GCC_4_9_MODULES), $(LOCAL_MODULE))))
      LOCAL_CC := prebuilts/gcc/$(HOST_PREBUILT_TAG)/arm/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-gcc$(HOST_EXECUTABLE_SUFFIX)
      LOCAL_CXX := prebuilts/gcc/$(HOST_PREBUILT_TAG)/arm/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-g++
    endif
endif
