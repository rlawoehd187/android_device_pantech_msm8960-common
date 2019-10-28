# QCOM
PRODUCT_PROPERTY_OVERRIDES += \
    com.qc.hardware=true

PRODUCT_PROPERTY_OVERRIDES += \
	ro.opengles.version=196608

# IO Scheduler
PRODUCT_PROPERTY_OVERRIDES += \
	sys.io.scheduler=cfq

# Do not power down SIM card when modem is sent to Low Power Mode.
PRODUCT_PROPERTY_OVERRIDES += \
	persist.radio.apm_sim_not_pwdn=1 \

# Ril sends only one RIL_UNSOL_CALL_RING, so set call_ring.multiple to false
PRODUCT_PROPERTY_OVERRIDES += \
	ro.telephony.call_ring.multiple=0

PRODUCT_PROPERTY_OVERRIDES += \
	ro.telephony.default_network=9 \
	ro.product.locale.language=ko \
	ro.product.locale.region=KR \
	ro.qualcomm.bt.hci_transport=smd \
	persist.sys.dalvik.multithread=true \

# Camera
PRODUCT_PROPERTY_OVERRIDES += \
    media.stagefright.legacyencoder=true \
    media.stagefright.less-secure=true

# Navigation Bar
PRODUCT_PROPERTY_OVERRIDES += \
	qemu.hw.mainkeys=0

# Perfd
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.extension_library=libqti-perfd-client.so

PRODUCT_PROPERTY_OVERRIDES += \
	drm.service.enabled=true

PRODUCT_PROPERTY_OVERRIDES += \
	wifi.interface=wlan0 \
	wifi.supplicant_scan_interval=180

PRODUCT_PROPERTY_OVERRIDES += \
        debug.egl.recordable.rgba8888=1

# Sensors
PRODUCT_PROPERTY_OVERRIDES += \
	ro.qc.sensors.wl_dis=true \
	ro.qualcomm.sensors.smd=true \

# Enable multiwindow mode by default
PRODUCT_PROPERTY_OVERRIDES += \
        persist.sys.debug.multi_window=true

ADDITIONAL_DEFAULT_PROPERTIES += \
	ro.adb.secure=0 \
	ro.secure=0 \
	ro.allow.mock.location=1

PRODUCT_PROPERTY_OVERRIDES += \
	ro.com.google.clientidbase=android-pantech \
	ro.com.google.clientidbase.ms=android-pantech \
	ro.com.google.clientidbase.am=android-pantech \
	ro.com.google.clientidbase.gmm=android-pantech \
	ro.com.google.clientidbase.yt=android-pantech
	
# Configure libhwui
PRODUCT_PROPERTY_OVERRIDES += \
	ro.hwui.texture_cache_size=48 \
	ro.hwui.layer_cache_size=32 \
	ro.hwui.r_buffer_cache_size=4 \
	ro.hwui.path_cache_size=24 \
	ro.hwui.gradient_cache_size=1 \
	ro.hwui.drop_shadow_cache_size=5 \
	ro.hwui.texture_cache_flushrate=0.5 \
	ro.hwui.text_small_cache_width=1024 \
	ro.hwui.text_small_cache_height=1024 \
	ro.hwui.text_large_cache_width=2048 \
	ro.hwui.text_large_cache_height=1024

 PRODUCT_PROPERTY_OVERRIDES += \
    persist.data.qmi.adb_logmask=0

#Sound config
PRODUCT_PROPERTY_OVERRIDES += \
    dump.audio_hal=false \
    ro.qc.sdk.audio.ssr=false \
    af.resampler.quality=255 \
    persist.audio.vr.enable=false \
    persist.audio.handset.mic=analog \
    persist.audio.lowlatency.rec=false \
    ro.qc.sdk.audio.fluencetype=none \
    persist.audio.handset.mic=analog \
    audio.deep_buffer.media=false

# media
PRODUCT_PROPERTY_OVERRIDES += \
    qcom.hw.aac.encoder=true \
    mm.enable.smoothstreaming=true

# gps
#PRODUCT_PROPERTY_OVERRIDES += \
    ro.gps.agps_provider=1 \
    ro.qc.sdk.izat.premium_enabled=0 \
    ro.qc.sdk.izat.service_mask=0x0 \
    persist.gps.qc_nlp_in_use=0

# Art
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.dex2oat-swap=false    

PRODUCT_PROPERTY_OVERRIDES += \
	ro.config.ringtone=Orion.ogg

PRODUCT_PROPERTY_OVERRIDES += \
      qcom.bluetooth.soc=smd \
      ro.qualcomm.bt.hci_transport=smd \
      ro.bt.bdaddr_path=/data/misc/bluetooth/bdaddr
