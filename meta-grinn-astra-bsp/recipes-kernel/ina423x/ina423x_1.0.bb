SUMMARY = "Texas Instruments INA423x power-monitor kernel module"
DESCRIPTION = "Out-of-tree hwmon driver for the TI INA4230 and INA4235 quad-channel power monitors"
HOMEPAGE = "https://www.ti.com/product/INA4230"

LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"

inherit module

# Driver archive obtained from:
# https://www.ti.com/tool/INA423X-LINUX-DRIVER
# It is intentionally stored locally instead of downloaded during the build
# because TI serves it without version control. Vendoring the archive prevents
# upstream changes from silently affecting build reproducibility.
SRC_URI = " \
    file://Makefile;subdir=source \
    file://INA423X-LINUX-DRIVER.zip;subdir=source \
    file://0001-fix-per-channel-shunt-gain-configuration.patch \
"

S = "${WORKDIR}/source"

# TI ships ina423x.c with CRLF line endings. Normalize it before do_patch so
# BitBake's default patch tooling can apply conventional LF patches reliably.
do_normalize_source_line_endings() {
    sed -i 's/\r$//' ${S}/ina423x.c
}
addtask normalize_source_line_endings after do_unpack before do_patch

KERNEL_MODULE_AUTOLOAD += "ina423x"
RPROVIDES:${PN} += "kernel-module-ina423x"
