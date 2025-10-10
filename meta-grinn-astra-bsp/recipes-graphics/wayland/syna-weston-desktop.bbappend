GRINN_ASTRA_1680 = "grinn-astra-1680-common"

FILESEXTRAPATHS:prepend := "${THISDIR}/${GRINN_ASTRA_1680}:"

SRC_URI:append = " \
	file://weston-${GRINN_ASTRA_1680}.ini \
"

do_install:prepend:grinn-astra-1680() {
	cp -r ${WORKDIR}/weston-${GRINN_ASTRA_1680}.ini ${S}/weston-${MACHINE}.ini
}
