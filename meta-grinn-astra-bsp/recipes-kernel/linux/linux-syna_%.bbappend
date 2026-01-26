FILESEXTRAPATHS:prepend:grinn-astra-1680-platform := "${THISDIR}/grinn-astra-1680/common:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-som := "${THISDIR}/grinn-astra-1680/som:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-ada := "${THISDIR}/grinn-astra-1680/ada:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-evb := "${THISDIR}/grinn-astra-1680/evb:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-sbc := "${THISDIR}/grinn-astra-1680/sbc:"

DT_DIR = "${S}/arch/arm64/boot/dts/synaptics"

SRC_URI:append:grinn-astra-platform = " \
	file://${MACHINE}.dts;subdir=${DT_DIR} \
"

SRC_URI:append:grinn-astra-1680-platform = " \
	file://modem.cfg \
	file://nfs.cfg \
	file://0001-linux-mac-add-support-for-TXC-90-degree-shift.patch \
"

SRC_URI:append:grinn-astra-1680-som = " \
	file://grinn-astra-1680-som.dtsi;subdir=${DT_DIR} \
	file://regulator.cfg \
"

SRC_URI:append:grinn-astra-1680-ada = " \
	file://eth.cfg \
"

SRC_URI:append:grinn-astra-1680-evb = " \
	file://gpio-led.cfg \
	file://eth.cfg \
"

SRC_URI:append:grinn-astra-1680-sbc = " \
	file://bcmdhd.cfg \
	file://gpio-led.cfg \
	file://eth.cfg \
	${@bb.utils.contains('MACHINE_FEATURES', 'deepx', 'file://deepx.cfg', '', d)} \
"
