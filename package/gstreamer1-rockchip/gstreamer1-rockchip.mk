################################################################################
#
# gstreamer1-rockchip
#
################################################################################

GSTREAMER1_ROCKCHIP_SITE = https://gitee.com/sz_jack/gstreamer-rockchip.git
GSTREAMER1_ROCKCHIP_VERSION = 71900e3e0c47f6191b44be9ecd37ffc194af6687
GSTREAMER1_ROCKCHIP_SITE_METHOD = git

GSTREAMER1_ROCKCHIP_LICENSE_FILES = COPYING
GSTREAMER1_ROCKCHIP_LICENSE = LGPL-2.1
GSTREAMER1_ROCKCHIP_DEPENDENCIES = gst1-plugins-base

GSTREAMER1_ROCKCHIP_DEPENDENCIES += rockchip-mpp
GSTREAMER1_ROCKCHIP_CONF_OPTS += -Drockchipmpp=enabled

ifeq ($(BR2_PREFER_ROCKCHIP_RGA),y)
GSTREAMER1_ROCKCHIP_DEPENDENCIES += rockchip-rga
GSTREAMER1_ROCKCHIP_CONF_OPTS += -Drga=enabled
else
GSTREAMER1_ROCKCHIP_CONF_OPTS += -Drga=disabled
endif

ifeq ($(BR2_PACKAGE_XORG7),y)
GSTREAMER1_ROCKCHIP_DEPENDENCIES += xlib_libX11 libdrm
GSTREAMER1_ROCKCHIP_CONF_OPTS += -Drkximage=enabled
endif

$(eval $(meson-package))
