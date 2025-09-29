DTSI_SOM = "grinn-astra-1680-som"
DTS_ADA = "grinn-astra-1680-ada"
DTS_EVB = "grinn-astra-1680-evb"

FILESEXTRAPATHS:prepend := "${THISDIR}/${DTSI_SOM}:"
FILESEXTRAPATHS:prepend := "${THISDIR}/${DTS_ADA}:"
FILESEXTRAPATHS:prepend := "${THISDIR}/${DTS_EVB}:"

DT_DIR = "${S}/arch/arm64/boot/dts/synaptics"

SRC_URI:append = " \
	file://${DTSI_SOM}.dtsi \
	file://${DTS_ADA}.dts \
	file://${DTS_EVB}.dts \
	file://regulator.cfg \
	file://0001-Add-sy20257-regulator.patch \
"

SRC_URI:append:grinn-astra-1680-ada = " \
"

SRC_URI:append:grinn-astra-1680-evb = " \
	file://gpio-led.cfg \
	file://eth.cfg \
"

do_compile:prepend() {
	cp ${WORKDIR}/${DTSI_SOM}.dtsi ${DT_DIR}/
	cp ${WORKDIR}/${DTS_ADA}.dts ${DT_DIR}/
	cp ${WORKDIR}/${DTS_EVB}.dts ${DT_DIR}/
}
