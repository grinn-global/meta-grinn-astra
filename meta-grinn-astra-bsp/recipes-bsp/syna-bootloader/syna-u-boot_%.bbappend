FILESEXTRAPATHS:prepend:grinn-astra-platform := "${THISDIR}/common:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-platform := "${THISDIR}/grinn-astra-1680/common:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-som := "${THISDIR}/grinn-astra-1680/som:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-ada := "${THISDIR}/grinn-astra-1680/ada:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-sbc := "${THISDIR}/grinn-astra-1680/sbc:"
FILESEXTRAPATHS:prepend:grinn-astra-261x-platform := "${THISDIR}/grinn-astra-261x/common:"
FILESEXTRAPATHS:prepend:grinn-astra-261x-som := "${THISDIR}/grinn-astra-261x/som:"
FILESEXTRAPATHS:prepend:grinn-astra-2619-sbc := "${THISDIR}/grinn-astra-261x/sbc:"

DT_DIR = "${S}/arch/arm/dts"
CFG_DIR = "${S}/configs"

SRC_URI:append:grinn-astra-platform = " \
	file://0001-uboot-add-mac-support-for-TXC-90-degree-phase-shift.patch \
	file://eth.cfg \
	file://misc.cfg \
	file://${MACHINE}.dts \
"

SRC_URI:append:grinn-astra-1680-som = " \
        file://grinn-astra-1680-som.dtsi \
"

SRC_URI:append:grinn-astra-1680-sbc = " \
	file://display_disable.cfg \
"

SRC_URI:append:grinn-astra-2619-som = " \
	file://grinn-astra-2619-som.dtsi \
	file://memory_1gb.cfg \
"

SRC_URI:append:grinn-astra-2619-som-usb = " \
	file://0001-arm-mach-synaptics-keep-20-MiB-free-for-small-heaps.patch \
	file://grinn-astra-2619-som.dtsi \
	file://memory_512mb.cfg \
"

SRC_URI:append:grinn-astra-2619-som-xspi-usb = " \
	file://0001-arm-mach-synaptics-keep-20-MiB-free-for-small-heaps.patch \
	file://grinn-astra-2619-som-usb.dts \
	file://grinn-astra-2619-som.dtsi \
	file://memory_512mb.cfg \
"

SRC_URI:append:grinn-astra-2619-sbc = " \
	file://0001-board-synaptics-klamath-klamath_boardinit-use-default.patch \
	file://hdmi_disable.cfg \
	file://overlay.cfg \
"

do_configure:append:grinn-astra-1680-platform() {
	cp ${WORKDIR}/${MACHINE}.dts ${DT_DIR}/dolphin-rdk.dts
	cp ${WORKDIR}/grinn-astra-1680-som.dtsi ${DT_DIR}
}

do_configure:append:grinn-astra-261x-platform() {
	cp ${WORKDIR}/${MACHINE}.dts ${DT_DIR}/klamath-rdk.dts
	cp ${WORKDIR}/grinn-astra-2619-som.dtsi ${DT_DIR}
}

do_configure:append:grinn-astra-2619-som-xspi-usb() {
	cp ${WORKDIR}/grinn-astra-2619-som-usb.dts ${DT_DIR}
}

# astra-update selects the USB boot image by the manifest memory_layout. All
# 261x images are flashed with the 2619 SOM USB boot images, which use the
# 512 MB layout, so the manifests of all 261x images use the 512mb layout,
# also for boards with more RAM. The USB boot images use the sl2610 series
# chip name, so astra-update can select them for all SL261x chips.
GRINN_BOOT_MANIFEST_ARGS = "--memory_layout 512mb"
GRINN_BOOT_MANIFEST_ARGS:append:grinn-astra-2619-som-usb = " --chip sl2610"
GRINN_BOOT_MANIFEST_ARGS:append:grinn-astra-2619-som-xspi-usb = " --chip sl2610"

# The manifest board name describes the hardware, like in the upstream
# manifests, so the USB boot images use the SOM name without the -usb suffix.
# The -xspi suffix shows in the astra-update log which USB boot image is used.
GRINN_BOOT_MANIFEST_BOARD = "${MACHINE}"
GRINN_BOOT_MANIFEST_BOARD:grinn-astra-2619-som-usb = "grinn-astra-2619-som"
GRINN_BOOT_MANIFEST_BOARD:grinn-astra-2619-som-xspi-usb = "grinn-astra-2619-som-xspi"

# Both USB boot images match the manifests of the 261x flash images, so the
# image to use is given by its id in the boot_image field of the flash image
# manifest. The USB boot images use the machine name as the id, and the 261x
# flash images use the USB boot image without XSPI. An XSPI flash image has to
# set boot_image to grinn-astra-2619-som-xspi-usb.
GRINN_BOOT_MANIFEST_ID = ""
GRINN_BOOT_MANIFEST_ID:grinn-astra-2619-som-usb = "${MACHINE}"
GRINN_BOOT_MANIFEST_ID:grinn-astra-2619-som-xspi-usb = "${MACHINE}"
GRINN_BOOT_MANIFEST_BOOT_IMAGE = "grinn-astra-2619-som-usb"
GRINN_BOOT_MANIFEST_BOOT_IMAGE:grinn-astra-2619-som-usb = ""
GRINN_BOOT_MANIFEST_BOOT_IMAGE:grinn-astra-2619-som-xspi-usb = ""

# Generate the manifest for non-USB machines and regenerate the upstream USB
# manifest with Grinn board name. Manifest is used by astra-update tool.
do_deploy:append:grinn-astra-261x-platform() {
	python3 ${WORKDIR}/generate_boot_manifest.py \
		--uboot_binary ${B}/../../uboot_en.bin \
		--sdk_config ${STAGING_DATADIR_NATIVE}/syna/build/.config \
		--uboot_config ${B}/.config \
		--board ${GRINN_BOOT_MANIFEST_BOARD} \
		${GRINN_BOOT_MANIFEST_ARGS} \
		--output ${WORKDIR}/manifest.yaml
	if [ -n "${GRINN_BOOT_MANIFEST_ID}" ]; then
		sed -i "s/^id: .*/id: ${GRINN_BOOT_MANIFEST_ID}/" ${WORKDIR}/manifest.yaml
	fi
	if [ -n "${GRINN_BOOT_MANIFEST_BOOT_IMAGE}" ]; then
		echo "boot_image: ${GRINN_BOOT_MANIFEST_BOOT_IMAGE}" >> ${WORKDIR}/manifest.yaml
	fi
	install -m 0644 ${WORKDIR}/manifest.yaml ${DEPLOYDIR}/manifest.yaml
}
