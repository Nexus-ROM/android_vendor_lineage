PRODUCT_VERSION_MAJOR = 23
PRODUCT_VERSION_MINOR = 0

ifeq ($(LINEAGE_VERSION_APPEND_TIME_OF_DAY),true)
    LINEAGE_BUILD_DATE := $(shell date -u +%Y%m%d_%H%M%S)
else
    LINEAGE_BUILD_DATE := $(shell date -u +%Y%m%d)
endif

# Default to UNOFFICIAL
LINEAGE_BUILDTYPE := UNOFFICIAL

# Check for Nexus official builds
DEVICE_NEXUS_OVERLAY := $(wildcard device/*/$(LINEAGE_BUILD)/overlay/packages/apps/Settings/res/values/strings.xml)

ifneq ($(DEVICE_NEXUS_OVERLAY),)
    DT_OFFICIAL := $(shell grep 'nexus_official_build">true<' $(DEVICE_NEXUS_OVERLAY) 2>/dev/null)
    
    ifneq ($(DT_OFFICIAL),)
        NEXUS_DEVICES_XML := $(wildcard vendor/nexusOTA/devices.xml)
        ifneq ($(NEXUS_DEVICES_XML),)
            IS_OFFICIAL := $(shell grep '<device>$(LINEAGE_BUILD)</device>' $(NEXUS_DEVICES_XML) 2>/dev/null)
            ifneq ($(IS_OFFICIAL),)
                LINEAGE_BUILDTYPE := OFFICIAL
            endif
        endif
    endif
endif

# Set version suffix
LINEAGE_VERSION_SUFFIX := $(LINEAGE_BUILD_DATE)-$(LINEAGE_BUILDTYPE)-$(LINEAGE_BUILD)

# Internal version
LINEAGE_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(LINEAGE_VERSION_SUFFIX)

# Display version
LINEAGE_DISPLAY_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) | $(LINEAGE_BUILDTYPE) | $(shell echo $(LINEAGE_BUILD) | tr a-z A-Z)

# LineageOS version properties
PRODUCT_SYSTEM_PROPERTIES += \
    ro.lineage.version=$(LINEAGE_VERSION) \
    ro.lineage.display.version=$(LINEAGE_DISPLAY_VERSION) \
    ro.lineage.build.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.lineage.releasetype=$(LINEAGE_BUILDTYPE)
