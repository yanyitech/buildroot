#!/bin/bash

set -e

LINUX_DIR=${BINARIES_DIR}/../build/linux-origin_develop

linux_image()
{
	if [ -f ${LINUX_DIR}/arch/arm64/boot/Image.gz ]; then
		cp ${LINUX_DIR}/arch/arm64/boot/Image.gz ${BINARIES_DIR}/vmlinuz
	fi
	if [ -f ${LINUX_DIR}/arch/arm64/boot/Image ]; then
		cp ${LINUX_DIR}/arch/arm64/boot/Image ${BINARIES_DIR}/Image
	fi
	if [ -f ${LINUX_DIR}/demo-cfgs/extlinux_cpcm5_evb_v11.conf ]; then
		mkdir -p ${BINARIES_DIR}/extlinux
		cp ${LINUX_DIR}/demo-cfgs/extlinux_cpcm5_evb_v11.conf ${BINARIES_DIR}/extlinux/extlinux.conf
	fi
	if [ -f ${LINUX_DIR}/demo-cfgs/config_cpcm5_evb_v11.txt ]; then
		cp ${LINUX_DIR}/demo-cfgs/config_cpcm5_evb_v11.txt ${BINARIES_DIR}/config.txt
	fi
	if [ -f ${LINUX_DIR}/boot/initrd.img ]; then
		cp ${LINUX_DIR}/boot/initrd.img ${BINARIES_DIR}
	fi
	if [ -f ${LINUX_DIR}/boot/cmdline.txt ]; then
		cp ${LINUX_DIR}/boot/cmdline.txt ${BINARIES_DIR}
	fi
}


BOARD_DIR="$(dirname $0)"
BOARD_NAME="$(basename ${BOARD_DIR})"
GENIMAGE_CFG="${BOARD_DIR}/genimage-${BOARD_NAME}.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

# Pass an empty rootpath. genimage makes a full copy of the given rootpath to
# ${GENIMAGE_TMP}/root so passing TARGET_DIR would be a waste of time and disk
# space. We don't rely on genimage to build the rootfs image, just to insert a
# pre-built one in the disk image.

trap 'rm -rf "${ROOTPATH_TMP}"' EXIT
ROOTPATH_TMP="$(mktemp -d)"

rm -rf "${GENIMAGE_TMP}"

linux_image

genimage \
	--loglevel 0 \
	--rootpath "${ROOTPATH_TMP}"   \
	--tmppath "${GENIMAGE_TMP}"    \
	--inputpath "${BINARIES_DIR}"  \
	--outputpath "${BINARIES_DIR}" \
	--config "${GENIMAGE_CFG}"

exit $?
