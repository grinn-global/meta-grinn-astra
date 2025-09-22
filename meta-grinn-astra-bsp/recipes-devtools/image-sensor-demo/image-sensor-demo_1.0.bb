SUMMARY = "Simple demonstration script showing usage of image sensors"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

RDEPENDS:${PN} = " \
	libgpiod \
	libgpiod-tools \
"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
	file://image-sensor-start.sh \
"

do_install() {
	install -d ${D}${bindir}
	install -m 0755 ${WORKDIR}/image-sensor-start.sh ${D}${bindir}
}
