FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
	file://09-swupdate-args \
	file://astra-swupdate.cfg \
	file://demo.cert.pem \
	file://swupdate.cfg.dual.copy \
	file://swupdate.cfg.single.copy \
"

# Certificate installed on the target device for verifying incoming .swu packages.
# Defaults to the demo cert — safe for development only.
# For production set this to an absolute path of your certificate in local.conf, e.g.:
#   SWUPDATE_CERT_FILE = "/path/to/production.cert.pem"
# The cert must match the signing cert used for SWUPDATE_CMS_CERT in the image recipe.
SWUPDATE_CERT_FILE ?= "${WORKDIR}/demo.cert.pem"

do_install:append() {
	if [ "${ENABLE_RESCUE_MODE}" = "0" ]; then
		install -m 0644 ${WORKDIR}/09-swupdate-args ${D}${libdir}/swupdate/conf.d/
		install -m 0644 ${WORKDIR}/swupdate.cfg.dual.copy ${D}${sysconfdir}/swupdate.cfg
	else
		install -m 0644 ${WORKDIR}/swupdate.cfg.single.copy ${D}${sysconfdir}/swupdate.cfg
	fi

	install -m 0644 ${SWUPDATE_CERT_FILE} ${D}${sysconfdir}/swupdate.cert.pem
}
