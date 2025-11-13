python __anonymous() {
    machine = d.getVar("MACHINE")
    mapping = {
        "sl1620": "myna2",
        "sl1640": "platypus",
        "sl1680": "dolphin",
        "grinn-astra-1680-ada": "dolphin",
        "grinn-astra-1680-evb": "dolphin",
        "grinn-astra-1680-sbc": "dolphin",
    }

    name = mapping.get(machine, "")
    d.setVar("MACHINE_NAME", name)
}

do_compile:prepend() {
    if [ "${ENABLE_RESCUE_MODE}" = "1" ]; then
        UBOOT_DEFCONFIG="${S}/boot/u-boot_2019_10/configs/${MACHINE_NAME}_suboot_defconfig"

        if [ ! -f "${UBOOT_DEFCONFIG}" ]; then
            bbfatal "UBOOT_DEFCONFIG file not found: ${UBOOT_DEFCONFIG}"
        fi

        sed -i '/^CONFIG_SYNA_RESCUE_MODE[ =]/d' "${UBOOT_DEFCONFIG}"
        bbnote "Appending CONFIG_SYNA_RESCUE_MODE=y to ${UBOOT_DEFCONFIG}"
        echo 'CONFIG_SYNA_RESCUE_MODE=y' >> "${UBOOT_DEFCONFIG}"
    fi
}
