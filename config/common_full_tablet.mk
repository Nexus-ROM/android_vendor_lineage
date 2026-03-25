# Inherit mobile full common Lineage stuff
$(call inherit-product, vendor/aospa/config/common_mobile_full.mk)

# Inherit tablet common Lineage stuff
$(call inherit-product, vendor/aospa/config/tablet.mk)

$(call inherit-product, vendor/aospa/config/telephony.mk)
