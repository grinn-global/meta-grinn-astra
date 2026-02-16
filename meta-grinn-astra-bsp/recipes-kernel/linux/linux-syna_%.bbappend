FILESEXTRAPATHS:prepend:grinn-astra-platform := "${THISDIR}/common:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-som := "${THISDIR}/grinn-astra-1680/som:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-ada := "${THISDIR}/grinn-astra-1680/ada:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-evb := "${THISDIR}/grinn-astra-1680/evb:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-sbc := "${THISDIR}/grinn-astra-1680/sbc:"
FILESEXTRAPATHS:prepend:grinn-astra-261x-som := "${THISDIR}/grinn-astra-261x/som:"
FILESEXTRAPATHS:prepend:grinn-astra-261x-coral := "${THISDIR}/grinn-astra-261x/coral:"
FILESEXTRAPATHS:prepend:grinn-astra-261x-sbc := "${THISDIR}/grinn-astra-261x/sbc:"

DT_DIR = "${S}/arch/arm64/boot/dts/synaptics"

SRC_URI:append:grinn-astra-platform = " \
	file://${MACHINE}.dts;subdir=${DT_DIR} \
	file://0001-linux-add-dwmac-support-for-TXC-90-degree-phase-shif.patch \
	file://gpiolib.cfg \
"

SRC_URI:append:grinn-astra-1680-platform = " \
	file://modem.cfg \
	file://nfs.cfg \
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
	file://nvme.cfg \
	${@bb.utils.contains('MACHINE_FEATURES', 'deepx', 'file://deepx.cfg', '', d)} \
"

SRC_URI:append:grinn-astra-261x-som = " \
	file://grinn-astra-261x-som.dtsi;subdir=${DT_DIR} \
"

SRC_URI:append:grinn-astra-261x-coral = " \
	file://grinn-astra-261x-coral.dtsi;subdir=${DT_DIR} \
"

SRC_URI:append:grinn-astra-261x-sbc = " \
	file://grinn-astra-261x-sbc.dtsi;subdir=${DT_DIR} \
"
