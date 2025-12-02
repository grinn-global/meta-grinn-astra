ASTRA_ADA = "grinn-astra-1680-ada"
ASTRA_EVB = "grinn-astra-1680-evb"
ASTRA_SBC = "grinn-astra-1680-sbc"
ASTRA_COMMON = "grinn-astra-1680-common"

FILESEXTRAPATHS:prepend := "${THISDIR}/${ASTRA_ADA}:"
FILESEXTRAPATHS:prepend := "${THISDIR}/${ASTRA_EVB}:"
FILESEXTRAPATHS:prepend := "${THISDIR}/${ASTRA_SBC}:"
FILESEXTRAPATHS:prepend := "${THISDIR}/${ASTRA_COMMON}:"

DT_DIR = "${S}/boot/u-boot/arch/arm/dts"
CFG_DIR = "${S}/boot/u-boot/configs"

SRC_URI:append = " \
	file://${ASTRA_ADA}.dts \
	file://${ASTRA_ADA}_defconfig \
	file://${ASTRA_EVB}.dts \
	file://${ASTRA_EVB}_defconfig \
	file://${ASTRA_SBC}.dts \
	file://${ASTRA_SBC}_defconfig \
	file://0001-uboot-mac-add-support-for-TXC-90-degree-shift.patch;patchdir=boot/u-boot \
"

do_configure:append:grinn-astra-1680-ada() {
	cp ${WORKDIR}/${ASTRA_ADA}.dts ${DT_DIR}/dolphin-rdk.dts
	cp ${WORKDIR}/${ASTRA_ADA}_defconfig ${CFG_DIR}/dolphin_suboot_defconfig
}

do_configure:append:grinn-astra-1680-evb() {
	cp ${WORKDIR}/${ASTRA_EVB}.dts ${DT_DIR}/dolphin-rdk.dts
	cp ${WORKDIR}/${ASTRA_EVB}_defconfig ${CFG_DIR}/dolphin_suboot_defconfig
}

do_configure:append:grinn-astra-1680-sbc() {
	cp ${WORKDIR}/${ASTRA_SBC}.dts ${DT_DIR}/dolphin-rdk.dts
	cp ${WORKDIR}/${ASTRA_SBC}_defconfig ${CFG_DIR}/dolphin_suboot_defconfig
}
