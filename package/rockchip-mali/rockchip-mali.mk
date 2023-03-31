################################################################################
#
# rockchip-mali
#
################################################################################

#ROCKCHIP_MALI_SITE = https://github.com/sz-jack-01/libmali-g610.git
ROCKCHIP_MALI_SITE = https://gitee.com/sz_jack/libmali-g610.git
ROCKCHIP_MALI_SITE_METHOD = git
ROCKCHIP_MALI_VERSION = 3eda4a882f7482c80cf632b6581c9050d2cc7b21
ROCKCHIP_MALI_LICENSE = ARM
ROCKCHIP_MALI_LICENSE_FILES = END_USER_LICENCE_AGREEMENT.txt
ROCKCHIP_MALI_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_ROCKCHIP_MALI_HAS_EGL),y)
ROCKCHIP_MALI_PROVIDES += libegl
endif

ifeq ($(BR2_PACKAGE_ROCKCHIP_MALI_HAS_GBM),y)
ROCKCHIP_MALI_PROVIDES += libgbm
endif

ifeq ($(BR2_PACKAGE_ROCKCHIP_MALI_HAS_GLES),y)
ROCKCHIP_MALI_PROVIDES += libgles
endif

ifeq ($(BR2_PACKAGE_ROCKCHIP_MALI_HAS_OPENCL),y)
ROCKCHIP_MALI_PROVIDES += libopencl
endif

ROCKCHIP_MALI_DEPENDENCIES = libdrm

ifeq ($(BR2_PACKAGE_ROCKCHIP_MALI_HAS_X11),y)
ROCKCHIP_MALI_DEPENDENCIES += libxcb xlib_libX11
endif

ifeq ($(BR2_PACKAGE_ROCKCHIP_MALI_HAS_WAYLAND),y)
ROCKCHIP_MALI_DEPENDENCIES += wayland
endif

ROCKCHIP_MALI_GPU = valhall-g610
ROCKCHIP_MALI_VER = g6p0

ifneq ($(BR2_PACKAGE_ROCKCHIP_MALI_CUSTOM_PLATFORM),"")
ROCKCHIP_MALI_PLATFORM = $(BR2_PACKAGE_ROCKCHIP_MALI_CUSTOM_PLATFORM)
else

# OpenCL is enabled by default for DDK newer than utgard.
ifeq ($(findstring utgard,$(ROCKCHIP_MALI_PLATFORM)),)
ifeq ($(BR2_PACKAGE_ROCKCHIP_MALI_HAS_OPENCL),)
ROCKCHIP_MALI_PLATFORM += without-cl
endif
endif

ifeq ($(BR2_PACKAGE_ROCKCHIP_MALI_HAS_VULKAN),y)
ROCKCHIP_MALI_PLATFORM += vulkan
endif

ifeq ($(BR2_PACKAGE_ROCKCHIP_MALI_HAS_DUMMY),y)
ROCKCHIP_MALI_PLATFORM += dummy
endif

ifeq ($(BR2_PACKAGE_ROCKCHIP_MALI_HAS_X11),y)
ROCKCHIP_MALI_PLATFORM += x11
endif

ifeq ($(BR2_PACKAGE_ROCKCHIP_MALI_HAS_WAYLAND),y)
ROCKCHIP_MALI_PLATFORM += wayland
endif

ifeq ($(BR2_PACKAGE_ROCKCHIP_MALI_HAS_GBM),y)
ROCKCHIP_MALI_PLATFORM += gbm
endif

# Minimal library only for OpenCL.
ifeq ($(ROCKCHIP_MALI_PLATFORM)|$(BR2_PACKAGE_ROCKCHIP_MALI_HAS_OPENCL),|y)
ROCKCHIP_MALI_PLATFORM = only-cl
endif

endif

ROCKCHIP_MALI_CONF_OPTS += \
	-Dwith-overlay=true -Dopencl-icd=false -Dkhr-header=true \
	-Dgpu=$(ROCKCHIP_MALI_GPU) -Dversion=$(ROCKCHIP_MALI_VER) \
	-Dsubversion=$(subst $(eval) $(eval),-,$(ROCKCHIP_MALI_SUBVER)) \
	-Dplatform=$(subst $(eval) $(eval),-,$(ROCKCHIP_MALI_PLATFORM))

ifeq ($(BR2_PACKAGE_ROCKCHIP_MALI_OPTIMIZE_s),y)
ROCKCHIP_MALI_CONF_OPTS += -Doptimize-level=Os
endif

$(eval $(meson-package))
