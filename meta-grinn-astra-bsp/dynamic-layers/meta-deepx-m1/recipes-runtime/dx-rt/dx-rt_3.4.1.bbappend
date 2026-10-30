inherit systemd

SRC_URI += "file://dxrt.service"

SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE:${PN} = "dxrt.service"
SYSTEMD_AUTO_ENABLE:${PN} = "enable"

do_install:append() {
    if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
        install -d ${D}${systemd_system_unitdir}
        install -m 0644 ${WORKDIR}/dxrt.service ${D}${systemd_system_unitdir}
    fi
}
