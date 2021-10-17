include vendor/aosap/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/aosap/config/BoardConfigQcom.mk
endif

include vendor/aosap/config/BoardConfigSoong.mk
