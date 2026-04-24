python __anonymous() {
    machine = d.getVar("MACHINE")
    mapping = {
        "grinn-astra-1680-ada": "dolphin",
        "grinn-astra-1680-sbc": "dolphin",
        "grinn-astra-2619-sbc": "klamath",
    }

    name = mapping.get(machine, "")
    d.setVar("MACHINE_NAME", name)
}

do_compile:prepend() {
    UBOOT_DEFCONFIG="${S}/configs/${MACHINE_NAME}_suboot_defconfig"
    if [ ! -f "${UBOOT_DEFCONFIG}" ]; then
        bbfatal "UBOOT_DEFCONFIG file not found: ${UBOOT_DEFCONFIG}"
    fi

    sed -i '/^CONFIG_SYNA_RESCUE_MODE[ =]/d' "${UBOOT_DEFCONFIG}"
    sed -i '/^CONFIG_ENV_OFFSET=/d' "${UBOOT_DEFCONFIG}"

    if [ "${ENABLE_RESCUE_MODE}" = "1" ]; then
        bbnote "Enabling rescue mode"
        echo 'CONFIG_SYNA_RESCUE_MODE=y' >> "${UBOOT_DEFCONFIG}"
        echo "CONFIG_ENV_OFFSET=0x77f0000" >> "${UBOOT_DEFCONFIG}"
        sed -i '/^CONFIG_SYS_REDUNDAND_ENVIRONMENT/d' "${UBOOT_DEFCONFIG}"
        echo "#CONFIG_SYS_REDUNDAND_ENVIRONMENT is not set" >> "${UBOOT_DEFCONFIG}"
    else
        bbnote "Not enabling rescue mode"
        echo "CONFIG_ENV_OFFSET=0x3ff0000" >> "${UBOOT_DEFCONFIG}"
        sed -i '/^# CONFIG_SYS_REDUNDAND_ENVIRONMENT is not set/d' "${UBOOT_DEFCONFIG}"
        grep -q '^CONFIG_SYS_REDUNDAND_ENVIRONMENT=' "${UBOOT_DEFCONFIG}" || \
            echo "CONFIG_SYS_REDUNDAND_ENVIRONMENT=y" >> "${UBOOT_DEFCONFIG}"
    fi
}
