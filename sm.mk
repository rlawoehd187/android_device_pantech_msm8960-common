# Clear SaberMod variables
$(shell unset EXTRA_SABERMOD_GCC_VECTORIZE_CFLAGS)
$(shell unset GRAPHITE_KERNEL_FLAGS)
$(shell unset KERNEL_STRICT_FLAGS)
$(shell unset LOCAL_O3)
$(shell unset EXTRA_SABERMOD_GCC)
$(shell unset GRAPHITE_UNROLL_AND_JAM)
$(shell unset LD_LIBRARY_PATH)
$(shell unset LIBRARY_PATH)
$(shell unset TARGET_SM_AND)
$(shell unset TARGET_ARCH_LIB_PATH)
$(shell unset TARGET_SM_KERNEL)
$(shell unset SM_KERNEL_NAME)
$(shell unset CROSS_COMPILE_NAME)
$(shell unset LOCAL_DISABLE_KERNEL_GRAPHITE)

#Config for sabermod
LOCAL_ARCH := arm
TARGET_SM_AND := SM-4.8
TARGET_SM_KERNEL := 4.9
HOST_TOOLCHAIN_PREFIX := prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.11-4.8/bin/x86_64-linux-
#kernel Strict Aliasing
LOCAL_STRICT_ALIASING := true
export CONFIG_MACH_MSM8960_EF52_STRICT_ALIASING := y


# Sabermod Makfefile, do not edit
include device/pantech/msm8960-common/sabermod/sabermod.mk
