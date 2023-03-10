################################################################################
#
# qt5quickcontrols2
#
################################################################################

QT5QUICKCONTROLS2_VERSION = 0d3d39e821ea7634c174a29910c18d7101bce6f7
QT5QUICKCONTROLS2_SITE = $(QT5_SITE)/qtquickcontrols2/-/archive/$(QT5QUICKCONTROLS2_VERSION)
QT5QUICKCONTROLS2_SOURCE = qtquickcontrols2-$(QT5QUICKCONTROLS2_VERSION).tar.bz2
QT5QUICKCONTROLS2_DEPENDENCIES = qt5declarative
QT5QUICKCONTROLS2_INSTALL_STAGING = YES
QT5QUICKCONTROLS2_SYNC_QT_HEADERS = YES

QT5QUICKCONTROLS2_LICENSE = GPL-3.0 or LGPL-3.0, GFDL-1.3 (docs)
QT5QUICKCONTROLS2_LICENSE_FILES = LICENSE.GPLv3 LICENSE.LGPLv3 LICENSE.FDL

# Hack: Workaround version missmatched
define QT5QUICKCONTROLS2_LINK_HEADERS
	mkdir -p $(@D)/include/QtQuickControls2
	ln -sf 5.15.8 $(@D)/include/QtQuickControls2/5.15.3
	mkdir -p $(@D)/include/QtQuickTemplates2
	ln -sf 5.15.8 $(@D)/include/QtQuickTemplates2/5.15.3
endef
QT5QUICKCONTROLS2_POST_CONFIGURE_HOOKS += QT5QUICKCONTROLS2_LINK_HEADERS

$(eval $(qmake-package))
