SUMMARY = "Simple script demonstrating digital microphones functionality"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

COMPATIBLE_MACHINE = "grinn-astra-1680-evb"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
	file://dmic-start.sh \
"

do_install() {
	install -d ${D}${bindir}
	install -m 0755 ${WORKDIR}/dmic-start.sh ${D}${bindir}
}
