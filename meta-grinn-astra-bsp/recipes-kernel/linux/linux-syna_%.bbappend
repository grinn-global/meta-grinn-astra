DTSI_SOM = "grinn-astra-1680-som"
DTS_ADA = "grinn-astra-1680-ada"
DTS_EVB = "grinn-astra-1680-evb"
DTS_SBC = "grinn-astra-1680-sbc"

FILESEXTRAPATHS:prepend := "${THISDIR}/${DTSI_SOM}:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-ada := "${THISDIR}/${DTS_ADA}:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-evb := "${THISDIR}/${DTS_EVB}:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-sbc := "${THISDIR}/${DTS_SBC}:"

DT_DIR = "${S}/arch/arm64/boot/dts/synaptics"

SRC_URI:append = " \
	file://${DTSI_SOM}.dtsi \
	file://regulator.cfg \
	file://0001-Add-sy20257-regulator.patch \
"

SRC_URI:append:grinn-astra-1680-ada = " \
	file://${DTS_ADA}.dts \
"

SRC_URI:append:grinn-astra-1680-evb = " \
	file://${DTS_EVB}.dts \
	file://gpio-led.cfg \
	file://eth.cfg \
"

SRC_URI:append:grinn-astra-1680-sbc = " \
	file://${DTS_SBC}.dts \
"

do_compile:prepend() {
	cp ${WORKDIR}/${DTSI_SOM}.dtsi ${DT_DIR}/
}

do_compile:prepend:grinn-astra-1680-ada() {
	cp ${WORKDIR}/${DTS_ADA}.dts ${DT_DIR}/
}

do_compile:prepend:grinn-astra-1680-evb() {
	cp ${WORKDIR}/${DTS_EVB}.dts ${DT_DIR}/
}

do_compile:prepend:grinn-astra-1680-sbc() {
	cp ${WORKDIR}/${DTS_SBC}.dts ${DT_DIR}/
}
