FILESEXTRAPATHS:prepend:grinn-astra-platform := "${THISDIR}/common:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-platform := "${THISDIR}/grinn-astra-1680/common:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-som := "${THISDIR}/grinn-astra-1680/som:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-ada := "${THISDIR}/grinn-astra-1680/ada:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-evb := "${THISDIR}/grinn-astra-1680/evb:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-sbc := "${THISDIR}/grinn-astra-1680/sbc:"
FILESEXTRAPATHS:prepend:grinn-astra-2619-sbc := "${THISDIR}/grinn-astra-261x/sbc:"

DT_DIR = "${S}/boot/u-boot/arch/arm/dts"
CFG_DIR = "${S}/boot/u-boot/configs"
CM3_CFG_FILE:grinn-astra-1680-sbc = "${STAGING_DIR_NATIVE}/usr/share/syna/build/.config"
CONFIG_FILE:grinn-astra-1680-sbc = "${WORKDIR}/.config"

SRC_URI:append:grinn-astra-platform = " \
	file://0001-uboot-add-mac-support-for-TXC-90-degree-phase-shift.patch;patchdir=boot/u-boot \
	file://0002-uboot-Add-Yocto-config-fragment-support.patch;patchdir=build \
	file://${MACHINE}.dts \
"

SRC_URI:append:grinn-astra-1680-som = " \
        file://grinn-astra-1680-som.dtsi \
"

SRC_URI:append:grinn-astra-1680-platform = " \
	file://eth.cfg \
	file://misc.cfg \
"

SRC_URI:append:grinn-astra-1680-evb = " \
	file://display_disable.cfg \
"

SRC_URI:append:grinn-astra-1680-sbc = " \
	file://0001-MCU-Add-grinn-astra-1680-sbc-configuartion.patch;patchdir=boot \
	file://0002-MCU-Remove-wifibt-related-code.patch;patchdir=boot \
	file://0003-MCU-Fix-build-when-IR-protocol-is-disabled.patch;patchdir=boot \
	file://cm3-bootloader.config \
	file://display_disable.cfg \
"

do_configure:append:grinn-astra-1680-platform() {
	cp ${WORKDIR}/${MACHINE}.dts ${DT_DIR}/dolphin-rdk.dts
	cp ${WORKDIR}/grinn-astra-1680-som.dtsi ${DT_DIR}
}

do_configure:append:grinn-astra-1680-sbc() {
	# set config for cm3 mcu
	${S}/boot/u-boot/scripts/kconfig/merge_config.sh -m -O ${WORKDIR} \
		${CM3_CFG_FILE} \
		${WORKDIR}/cm3-bootloader.config
}

do_configure:append:grinn-astra-261x-platform() {
	cp ${WORKDIR}/${MACHINE}.dts ${DT_DIR}/klamath-rdk.dts
}

do_compile:prepend() {
	UBOOT_SRC="${S}/boot/u-boot"
	COMBINED_FRAGMENT="${UBOOT_SRC}/configs/yocto_fragment.cfg"

	rm -f ${COMBINED_FRAGMENT}
	touch ${COMBINED_FRAGMENT}

	for fragment in ${WORKDIR}/*.cfg; do
		if [ -f "${fragment}" ]; then
			bbnote "Adding U-Boot config fragment: $(basename ${fragment})"
			cat "${fragment}" >> ${COMBINED_FRAGMENT}
		fi
	done
}
