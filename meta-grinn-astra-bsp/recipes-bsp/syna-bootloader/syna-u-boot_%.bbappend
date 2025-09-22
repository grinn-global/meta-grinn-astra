ASTRA_ADA = "grinn-astra-1680-ada"
ASTRA_EVB = "grinn-astra-1680-evb"

FILESEXTRAPATHS:prepend := "${THISDIR}/${ASTRA_ADA}:"
FILESEXTRAPATHS:prepend := "${THISDIR}/${ASTRA_EVB}:"

DT_DIR = "${S}/boot/u-boot_2019_10/arch/arm/dts"
CFG_DIR = "${S}/boot/u-boot_2019_10/configs"

SRC_URI:append = " \
	file://${ASTRA_ADA}.dts \
	file://${ASTRA_ADA}_defconfig \
	file://${ASTRA_EVB}.dts \
	file://${ASTRA_EVB}_defconfig \
"

do_compile:prepend:grinn-astra-1680-ada() {
	cp ${WORKDIR}/${ASTRA_ADA}.dts ${DT_DIR}/dolphin-rdk.dts
	cp ${WORKDIR}/${ASTRA_ADA}_defconfig ${CFG_DIR}/dolphin_suboot_defconfig
}

do_compile:prepend:grinn-astra-1680-evb() {
	cp ${WORKDIR}/${ASTRA_EVB}.dts ${DT_DIR}/dolphin-rdk.dts
	cp ${WORKDIR}/${ASTRA_EVB}_defconfig ${CFG_DIR}/dolphin_suboot_defconfig
}
