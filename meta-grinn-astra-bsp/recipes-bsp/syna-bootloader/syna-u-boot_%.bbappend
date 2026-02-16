FILESEXTRAPATHS:prepend:grinn-astra-1680-platform := "${THISDIR}/common:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-ada := "${THISDIR}/grinn-astra-1680/ada:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-evb := "${THISDIR}/grinn-astra-1680/evb:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-sbc := "${THISDIR}/grinn-astra-1680/sbc:"

DT_DIR = "${S}/boot/u-boot/arch/arm/dts"
CFG_DIR = "${S}/boot/u-boot/configs"

SRC_URI:append:grinn-astra-1680-platform = " \
	file://0001-uboot-mac-add-support-for-TXC-90-degree-shift.patch;patchdir=boot/u-boot \
	file://${MACHINE}.dts \
	file://${MACHINE}_defconfig \
"

do_configure:append:grinn-astra-1680-platform() {
	cp ${WORKDIR}/${MACHINE}.dts ${DT_DIR}/dolphin-rdk.dts
	cp ${WORKDIR}/${MACHINE}_defconfig ${CFG_DIR}/dolphin_suboot_defconfig
}
