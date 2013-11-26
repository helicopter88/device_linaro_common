# stuff common to all Linaro LEB
include $(LOCAL_PATH)/ZeroXBenchmark.mk

ifneq ($(wildcard $(TOP)/packages/apps/AndroidTerm/Android.mk),)
# Include AndroidTerm only if it's part of the manifest
ANDROIDTERM := AndroidTerm libjackpal-androidterm4
endif
ifneq ($(wildcard $(TOP)/packages/inputmethods/hackerskeyboard/Android.mk),)
HACKERSKEYBOARD := PCKeyboard
endif

PRODUCT_PACKAGES := \
    AccountAndSyncSettings \
    AlarmClock \
    AlarmProvider \
    $(ANDROIDTERM) \
    Bluetooth \
    Calculator \
    Calendar \
    Camera \
    CertInstaller \
    DrmProvider \
    Email \
    Gallery3D \
    LatinIME \
    Launcher3 \
    linaro.android \
    Mms \
    Music \
    $(HACKERSKEYBOARD) \
    Provision \
    Settings \
    SystemUI \
    Sync \
    Updater \
    CalendarProvider \
    SyncProvider \
    ZeroXBenchmark \
    su \
    libmicro \
    powertop \
    powerdebug \
    $(ZEROXBENCHMARK_NATIVE_APPS) \
    LinaroWallpaper \
    LiveWallpapers \
    LiveWallpapersPicker \
    MagicSmokeWallpapers \
    VisualizationWallpapers \
    librs_jni \
    libtinyalsa \
    tinyplay \
    tinycap \
    tinymix \
    libaudioutils \
    iozone \
    memtester \
    stress \
    stressapptest \
    DisableSuspend \
    libncurses \
    htop \
    idlestat

#packages we are using for benchmarking
# d8 replaces v8shell -- we're leaving both packages in here for now so
# older builds still get v8shell.
PRODUCT_PACKAGES += \
    v8shell \
    d8


PRODUCT_PACKAGES += \
    lava-blackbox \
    ObjenesisTck \
    AudioInRecord \
    libembunit \
    android-mock-runtimelib \
    android-mock-generatorlib 

V8BENCHMARKS := $(foreach js,$(wildcard $(TOP)/external/v8/benchmarks/*.js),\
	$(js):data/benchmark/v8/$(notdir $(js)))

PRODUCT_COPY_FILES := \
	device/linaro/common/wallpaper_info.xml:data/system/wallpaper_info.xml \
	device/linaro/common/disablesuspend.sh:system/bin/disablesuspend.sh \
	$(V8BENCHMARKS)

define copy-howto
ifneq ($(wildcard $(TOP)/device/linaro/common/howto/$(LINARO_BUILD_SPEC)/$1),)
PRODUCT_COPY_FILES += \
	device/linaro/common/howto/$(LINARO_BUILD_SPEC)/$1:$1
else
ifneq ($(wildcard $(TOP)/device/linaro/common/howto/default/$1),)
PRODUCT_COPY_FILES += \
	device/linaro/common/howto/default/$1:$1
endif
endif
endef

HOWTOS := \
	HOWTO_install.txt \
	HOWTO_getsourceandbuild.txt \
	HOWTO_flashfirmware.txt \
	HOWTO_releasenotes.txt \
	HOWTO_rtsm.txt

PRODUCT_COPY_FILES += \
        device/linaro/common/media_codecs.xml:system/etc/media_codecs.xml

ifneq ($(wildcard $(TOP)/build-info),)
PRODUCT_COPY_FILES += \
	build-info/BUILD-INFO.txt:BUILD-INFO.txt
endif

$(foreach howto,$(HOWTOS),$(eval $(call copy-howto,$(howto))))

