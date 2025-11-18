FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
	file://09-swupdate-args \
	file://astra-swupdate.cfg \
	file://demo.cert.pem \
	file://swupdate.cfg.dual.copy \
	file://swupdate.cfg.single.copy \
"

do_install:append() {
	if [ "${ENABLE_RESCUE_MODE}" = "0" ]; then
		install -m 0644 ${WORKDIR}/09-swupdate-args ${D}${libdir}/swupdate/conf.d/
		install -m 0644 ${WORKDIR}/swupdate.cfg.dual.copy ${D}${sysconfdir}/swupdate.cfg
	else
		install -m 0644 ${WORKDIR}/swupdate.cfg.single.copy ${D}${sysconfdir}/swupdate.cfg
	fi

	install -m 0644 ${WORKDIR}/demo.cert.pem ${D}${sysconfdir}
}
