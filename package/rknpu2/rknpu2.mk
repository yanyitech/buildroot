################################################################################
#
# rknpu2
#
################################################################################
RKNPU2_SITE = https://gitee.com/yanyitech/rknpu2.git
RKNPU2_SITE_METHOD = git
RKNPU2_VERSION = c06d3be6f876e9abaff4d748ec54b2851d9fadba
RKNPU2_INSTALL_STAGING = YES

RKNPU2_LICENSE = ROCKCHIP
RKNPU2_LICENSE_FILES = LICENSE

GCC_TYPE = $(subst aarch64-coolpi-linux-gnu-,aarch64-coolpi-linux-gnu,$(TARGET_CROSS))
NPU_PLATFORM_ARCH = aarch64

NPU_PLATFORM_INFO = RK3588
NPU_DEMO_BUILD = build-linux_RK3588.sh

define RKNPU2_BUILD_CMDS
	cd $(@D)/examples/rknn_common_test && export GCC_COMPILER=$(GCC_TYPE)  && ./$(NPU_DEMO_BUILD)
endef

define RKNPU2_INSTALL_STAGING_CMDS
	mkdir -p $(STAGING_DIR)/usr/include/rknn
	$(INSTALL) -D -m 0644 $(@D)/runtime/$(NPU_PLATFORM_INFO)/Linux/librknn_api/include/rknn_api.h ${TARGET_DIR}/usr/include/rknn/rknn_api.h
endef

define RKNPU2_INSTALL_TARGET_CMDS
	cp -r $(@D)/runtime/$(NPU_PLATFORM_INFO)/Linux/rknn_server/${NPU_PLATFORM_ARCH}/usr/bin/* ${TARGET_DIR}/usr/bin/
	cp -r $(@D)/runtime/$(NPU_PLATFORM_INFO)/Linux/librknn_api/${NPU_PLATFORM_ARCH}/* ${TARGET_DIR}/usr/lib/
	$(INSTALL) -D -m 0755 $(@D)/examples/rknn_common_test/install/rknn_common_test_Linux/rknn_common_test ${TARGET_DIR}/usr/bin/
	cp -r $(@D)/examples/rknn_common_test/install/rknn_common_test_Linux/lib/* ${TARGET_DIR}/usr/lib/
	cp -r $(@D)/examples/rknn_common_test/install/rknn_common_test_Linux/model/ ${TARGET_DIR}/usr/share/
endef

$(eval $(generic-package))
