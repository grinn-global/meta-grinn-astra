#!/bin/bash

FLASH_TOOL_ROOT="${1}"
FLASH_TOOL_PATH="${FLASH_TOOL_ROOT}/bin/linux/x86_64"
FLASH_TOOL_NAME="astra-update"
FLASH_TOOL="${FLASH_TOOL_PATH}/${FLASH_TOOL_NAME}"

BOOT_IMAGE_COLLECTION="${FLASH_TOOL_ROOT}/astra-usbboot-images"
BOOT_IMAGE_NAME="sl1680_suboot"
BOOT_IMAGE="${BOOT_IMAGE_COLLECTION}/${BOOT_IMAGE_NAME}"

THIS_SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

show_usage() {
	echo ""
	echo "Usage:"
	echo "	${0} <usb_tool_root_path> <machine_selector> [image_path]"
	echo ""
	echo "machine_selector:"
	echo "	ada	grinn-astra-1680-ada"
	echo "	evb	grinn-astra-1680-evb"
	echo "	sbc	grinn-astra-1680-sbc"
	echo ""
	echo "image_path:"
	echo "	optional path to pre-built image"
}

if [ -z ${1} ] || [ -z ${2} ]; then
	show_usage
	exit 1
fi

if [ ! -x ${FLASH_TOOL} ]; then
	echo "Invalid usb-tool root path!"
	show_usage
	exit 1
fi

case "${2}" in
	ada)
		echo "ADA machine selected"
		MACHINE_NAME="grinn-astra-1680-ada"
		;;
	evb)
		echo "EVB machine selected"
		MACHINE_NAME="grinn-astra-1680-evb"
		;;
	sbc)
		echo "SBC machine selected"
		MACHINE_NAME="grinn-astra-1680-sbc"
		;;
	*)
		echo "Invalid machine selected!"
		show_usage
		exit 1
		;;
esac

if [ -z ${3} ]; then
	IMAGE_PATH="${THIS_SCRIPT_DIR}/../../../../build/tmp/deploy/images/${MACHINE_NAME}/SYNAIMG/"

	if [ ! -d ${IMAGE_PATH} ]; then
		echo "Image for ${MACHINE_NAME} is not built!"
		exit 1
	fi
else
    IMAGE_PATH=${3}
fi

sudo ${FLASH_TOOL} -B ${BOOT_IMAGE_COLLECTION} -M ${BOOT_IMAGE}/manifest.yaml --flash ${IMAGE_PATH}
