#
# SPDX-FileCopyrightText: 2017-2024 The LineageOS Project
# SPDX-FileCopyrightText: Paranoid Android
# SPDX-License-Identifier: Apache-2.0
#

# Dex2oat
ifeq ($(TARGET_CPU_VARIANT),cortex-a510)
    DEX2OAT_TARGET_CPU_VARIANT := cortex-a76
    DEX2OAT_TARGET_CPU_VARIANT_RUNTIME := cortex-a76
endif

# Recovery
BOARD_USES_FULL_RECOVERY_IMAGE ?= true

# Include our Qualcomm Board configuration.
ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
    include hardware/qcom-caf/common/BoardConfigQcom.mk
    include device/qcom/common/BoardConfigQcom.mk
endif

# Include our private configuration - optional.
-include vendor/aospa-priv/target/board/BoardConfigAOSPAPriv.mk

# Include kernel configuration
include vendor/aospa/config/BoardConfigKernel.mk

# Include soong configuration
include vendor/aospa/config/BoardConfigSoong.mk
