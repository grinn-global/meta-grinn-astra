SUMMARY = "Terrasat modem PPP configuration"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI:append = " \
	file://catm.chat \
	file://catm.peer \
	file://terrasat-modem.rules \
"

RDEPENDS:${PN} = "ppp"

S = "${WORKDIR}"

do_install() {
	install -d ${D}${sysconfdir}/chatscripts
	install -d ${D}${sysconfdir}/ppp/peers
	install -d ${D}${sysconfdir}/udev/rules.d

	install -m 0755 ${WORKDIR}/catm.chat ${D}${sysconfdir}/chatscripts/catm
	install -m 0755 ${WORKDIR}/catm.peer ${D}${sysconfdir}/ppp/peers/catm
	install -m 0644 ${WORKDIR}/terrasat-modem.rules ${D}${sysconfdir}/udev/rules.d/99-terrasat-modem.rules
}
