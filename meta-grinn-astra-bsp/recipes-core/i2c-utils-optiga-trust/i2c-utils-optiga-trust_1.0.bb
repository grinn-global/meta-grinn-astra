SUMMARY = "I2C Utilities for OPTIGA™ Trust secure IC"
DESCRIPTION = "This is a simple test tools for OPTIGA™ Trust I2C interface on Linux platform"
HOMEPAGE = "https://github.com/Infineon/i2c-utils-optiga-trust"
LICENSE = "MIT"

PACKAGE_ARCH = "${MACHINE_ARCH}"

LIC_FILES_CHKSUM = "file://LICENSE;md5=ad5eaf5293969bc516d1059db0e35101"

SRCBRANCH ?= "master"
SRCREV = "e9beb4eeb40c298180fdefc37fff896b2f64a53a"
SRC_URI = "git://github.com/Infineon/i2c-utils-optiga-trust.git;protocol=https;branch=${SRCBRANCH}"

S = "${WORKDIR}/git"

EXTRA_OEMAKE = "CC='${CC}'"

do_compile() {
	oe_runmake
}

do_install() {
	install -d ${D}${bindir}
	install -m 755 ${S}/sample/trustx_reg ${D}${bindir}
	install -m 755 ${S}/sample/trustx_scan ${D}${bindir}
	install -m 755 ${S}/sample/trustx_softreset ${D}${bindir}
	install -m 755 ${S}/sample/trustx_w_addr ${D}${bindir}
}
