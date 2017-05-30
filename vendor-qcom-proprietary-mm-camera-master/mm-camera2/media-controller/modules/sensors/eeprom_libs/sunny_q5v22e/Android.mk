OFILM_OTY5F03_EEPROM_LIBS_PATH := $(call my-dir)

# ---------------------------------------------------------------------------
#        Make the shared library (libmmcamera_sunny_q5v22e_eeprom.so)
# ---------------------------------------------------------------------------

include $(CLEAR_VARS)
LOCAL_PATH := $(OFILM_OTY5F03_EEPROM_LIBS_PATH)
LOCAL_MODULE_TAGS := optional

LOCAL_CFLAGS:= \
        -DAMSS_VERSION=$(AMSS_VERSION) \
        $(mmcamera_debug_defines) \
        $(mmcamera_debug_cflags)

ifeq ($(VFE_VERS),vfe40)
  LOCAL_CFLAGS += -DVFE_40
else ifeq ($(VFE_VERS),vfe32)
  LOCAL_CFLAGS += -DVFE_32
  ifeq ($(FEATURE_GYRO), true)
    LOCAL_CFLAGS += -DFEATURE_GYRO
  endif
else ifeq ($(VFE_VERS),vfe31)
  LOCAL_CFLAGS += -DVFE_31
  ifeq ($(MSM_VERSION), 7x30)
    LOCAL_CFLAGS += -DVFE_31_7x30
  else
    LOCAL_CFLAGS += -DVFE_31_8x60
  endif
else ifeq ($(VFE_VERS),vfe2x)
  LOCAL_CFLAGS += -DVFE_2X
endif

LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../includes
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../chromatix/0301
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../actuator_libs/
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../actuators/0301
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../eeprom
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../module
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../../../mct/bus
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../../../mct/controller
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../../../mct/event
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../../../mct/module
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../../../mct/object
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../../../mct/pipeline
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../../../mct/port
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../../../mct/stream
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../../../mct/tools
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../../../includes
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../../../../../includes
LOCAL_C_INCLUDES += \
 $(TARGET_OUT_INTERMEDIATES)/include/mm-camera-interface
LOCAL_C_INCLUDES += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
LOCAL_ADDITIONAL_DEPENDENCIES := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr

LOCAL_SRC_FILES:= sunny_q5v22e_eeprom.c
LOCAL_MODULE           := libmmcamera_sunny_q5v22e_eeprom
LOCAL_SHARED_LIBRARIES := libcutils libmmcamera2_sensor_modules

ifeq ($(MM_DEBUG),true)
LOCAL_SHARED_LIBRARIES += liblog
endif

LOCAL_MODULE_OWNER := qcom 
LOCAL_32_BIT_ONLY := true
LOCAL_PROPRIETARY_MODULE := true

include $(BUILD_SHARED_LIBRARY)
