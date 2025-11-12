BOARD_PREFIX = "grinn-astra-1680"
FILES_SOM = "${BOARD_PREFIX}-som"
FILES_COMMON = "${BOARD_PREFIX}-common"
FILES_ADA = "${BOARD_PREFIX}-ada"
FILES_EVB = "${BOARD_PREFIX}-evb"
FILES_SBC = "${BOARD_PREFIX}-sbc"

FILESEXTRAPATHS:prepend := "${THISDIR}/${FILES_SOM}:"
FILESEXTRAPATHS:prepend := "${THISDIR}/${FILES_COMMON}:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-ada := "${THISDIR}/${FILES_ADA}:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-evb := "${THISDIR}/${FILES_EVB}:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-sbc := "${THISDIR}/${FILES_SBC}:"

DT_DIR = "${S}/arch/arm64/boot/dts/synaptics"

SRC_URI:append = " \
	file://${BOARD_PREFIX}-som.dtsi \
	file://modem.cfg \
	file://regulator.cfg \
	file://0001-Add-sy20257-regulator.patch \
	file://0002-drivers-regulator-sy8824x-remove-supply-name.patch \
"

SRC_URI:append:grinn-astra-1680-ada = " \
	file://${BOARD_PREFIX}-ada.dts \
"

SRC_URI:append:grinn-astra-1680-evb = " \
	file://${BOARD_PREFIX}-evb.dts \
	file://gpio-led.cfg \
	file://eth.cfg \
"

SRC_URI:append:grinn-astra-1680-sbc = " \
	file://${BOARD_PREFIX}-sbc.dts \
	file://gpio-led.cfg \
	file://eth.cfg \
"

do_compile:prepend() {
	cp ${WORKDIR}/${BOARD_PREFIX}-som.dtsi ${DT_DIR}/
}

do_compile:prepend:grinn-astra-1680-ada() {
	cp ${WORKDIR}/${BOARD_PREFIX}-ada.dts ${DT_DIR}/
}

do_compile:prepend:grinn-astra-1680-evb() {
	cp ${WORKDIR}/${BOARD_PREFIX}-evb.dts ${DT_DIR}/
}

do_compile:prepend:grinn-astra-1680-sbc() {
	cp ${WORKDIR}/${BOARD_PREFIX}-sbc.dts ${DT_DIR}/
}
