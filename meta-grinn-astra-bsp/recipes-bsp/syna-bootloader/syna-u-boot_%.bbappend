FILESEXTRAPATHS:prepend:grinn-astra-platform := "${THISDIR}/common:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-platform := "${THISDIR}/grinn-astra-1680/common:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-som := "${THISDIR}/grinn-astra-1680/som:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-ada := "${THISDIR}/grinn-astra-1680/ada:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-sbc := "${THISDIR}/grinn-astra-1680/sbc:"
FILESEXTRAPATHS:prepend:grinn-astra-2619-sbc := "${THISDIR}/grinn-astra-261x/sbc:"

DT_DIR = "${S}/arch/arm/dts"
CFG_DIR = "${S}/configs"

SRC_URI:append:grinn-astra-platform = " \
	file://0001-uboot-add-mac-support-for-TXC-90-degree-phase-shift.patch \
	file://${MACHINE}.dts \
"

SRC_URI:append:grinn-astra-1680-som = " \
        file://grinn-astra-1680-som.dtsi \
"

SRC_URI:append:grinn-astra-1680-platform = " \
	file://eth.cfg \
	file://misc.cfg \
"

SRC_URI:append:grinn-astra-1680-sbc = " \
	file://0001-board-dolphin-disable-rescue-mode-gpio-trigger.patch \
	file://display_disable.cfg \
"

do_configure:append:grinn-astra-1680-platform() {
	cp ${WORKDIR}/${MACHINE}.dts ${DT_DIR}/dolphin-rdk.dts
	cp ${WORKDIR}/grinn-astra-1680-som.dtsi ${DT_DIR}
}

do_configure:append:grinn-astra-261x-platform() {
	cp ${WORKDIR}/${MACHINE}.dts ${DT_DIR}/klamath-rdk.dts
}
