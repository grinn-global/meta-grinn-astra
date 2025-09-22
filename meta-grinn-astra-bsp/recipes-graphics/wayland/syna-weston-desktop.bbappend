ASTRA_ADA = "grinn-astra-1680-ada"
ASTRA_EVB = "grinn-astra-1680-evb"

FILESEXTRAPATHS:prepend := "${THISDIR}/${ASTRA_ADA}:"
FILESEXTRAPATHS:prepend := "${THISDIR}/${ASTRA_EVB}:"

SRC_URI:append = " \
	file://weston-${MACHINE}.ini \
"

do_install:prepend() {
	cp -r ${WORKDIR}/weston-${MACHINE}.ini ${S}/
}
