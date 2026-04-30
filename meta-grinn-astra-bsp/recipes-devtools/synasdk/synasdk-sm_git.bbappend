SBC_FILES = "grinn-astra-1680-sbc"

FILESEXTRAPATHS:prepend:grinn-astra-1680-sbc := "${THISDIR}/${SBC_FILES}:"

SRC_URI:append:grinn-astra-1680-sbc  = " \
	file://0001-Add-grinn-astra-1680-sbc-configuartion.patch;patchdir=boot \
	file://0002-MCU-Fix-build-when-IR-protocol-is-disabled.patch;patchdir=boot \
	file://cm3-bootloader.config \
"

CM3_CFG_FILE:grinn-astra-1680-sbc = "${STAGING_DIR_NATIVE}/usr/share/syna/build/.config"
CONFIG_FILE:grinn-astra-1680-sbc = "${WORKDIR}/.config"

do_configure:append:grinn-astra-1680-sbc() {
	# set config for cm3 mcu
	${S}/build/tools/src/kbuild/scripts/kconfig/merge_config.sh -m -O ${WORKDIR} \
		${CM3_CFG_FILE} \
		${WORKDIR}/cm3-bootloader.config
}
