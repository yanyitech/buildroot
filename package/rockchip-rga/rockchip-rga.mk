################################################################################
#
# rockchip-rga
#
################################################################################

#ROCKCHIP_RGA_SITE = https://github.com/sz-jack-01/linux-rga.git
ROCKCHIP_RGA_SITE = https://gitee.com/sz_jack/linux-rga.git
ROCKCHIP_RGA_VERSION = d6af1bbd037861de7b07f5d7f2cfd98e66ed6718
ROCKCHIP_RGA_SITE_METHOD = git

ROCKCHIP_RGA_LICENSE = Apache-2.0
ROCKCHIP_RGA_LICENSE_FILES = COPYING

ROCKCHIP_RGA_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_LIBDRM),y)
ROCKCHIP_RGA_DEPENDENCIES += libdrm
ROCKCHIP_RGA_CONF_OPTS += -Dlibdrm=true
endif

$(eval $(meson-package))
