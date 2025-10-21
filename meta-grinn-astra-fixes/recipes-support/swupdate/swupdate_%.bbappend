FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
	file://09-swupdate-args \
	file://astra-swupdate.cfg \
	file://demo.cert.pem \
	file://swupdate.cfg.custom \
"

do_install:append() {
	install -m 0644 ${WORKDIR}/09-swupdate-args ${D}${libdir}/swupdate/conf.d/
	install -m 0644 ${WORKDIR}/demo.cert.pem ${D}${sysconfdir}
	install -m 0644 ${WORKDIR}/swupdate.cfg.custom ${D}${sysconfdir}/swupdate.cfg
}
