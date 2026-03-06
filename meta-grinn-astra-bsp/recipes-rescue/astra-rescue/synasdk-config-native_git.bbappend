FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI += "file://sl1680_emmc.pt"

do_install:append:grinn-astra-1680-platform() {
    if [ "${ENABLE_RESCUE_MODE}" = "1" ]; then
        install -m 0644 ${WORKDIR}/sl1680_emmc.pt ${D}${datadir}/syna/build/
    fi
}
