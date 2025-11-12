FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://sl1620_emmc.pt \
    file://sl1640_emmc.pt \
    file://sl1680_emmc.pt \
"

python __anonymous() {
    machine = d.getVar("MACHINE")
    mapping = {
        "sl1620": "sl1620_emmc.pt",
        "sl1640": "sl1640_emmc.pt",
        "sl1680": "sl1680_emmc.pt",
        "grinn-astra-1680-ada": "sl1680_emmc.pt",
        "grinn-astra-1680-evb": "sl1680_emmc.pt",
        "grinn-astra-1680-sbc": "sl1680_emmc.pt",
    }

    pt_file = mapping.get(machine, "")
    d.setVar("EMMC_PT_FILE", pt_file)
}

do_install:append() {
    if [ "${ENABLE_RESCUE_MODE}" = "1" ]; then
        if [ -z "${EMMC_PT_FILE}" ]; then
            bbfatal "No .pt file mapping found for MACHINE=${MACHINE}"
        fi

        install -d ${D}${datadir}/syna/build
        install -m 0644 ${WORKDIR}/${EMMC_PT_FILE} ${D}${datadir}/syna/build/emmc.pt
    fi
}
