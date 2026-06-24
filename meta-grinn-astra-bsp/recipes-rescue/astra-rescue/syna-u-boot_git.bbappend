MACHINE_NAME:grinn-astra-1680-platform = "dolphin"
MACHINE_NAME:grinn-astra-261x-platform = "klamath"
MACHINE_NAME:sl2619-coralboard = "klamath"

do_configure:prepend() {
    UBOOT_DEFCONFIG="${S}/configs/${MACHINE_NAME}_suboot_defconfig"
    if [ ! -f "${UBOOT_DEFCONFIG}" ]; then
        bbfatal "UBOOT_DEFCONFIG file not found: ${UBOOT_DEFCONFIG}"
    fi

    sed -i '/^CONFIG_SYNA_RESCUE_MODE[ =]/d' "${UBOOT_DEFCONFIG}"
    sed -i '/^CONFIG_ENV_OFFSET=/d' "${UBOOT_DEFCONFIG}"

    if [ "${ENABLE_RESCUE_MODE}" = "1" ]; then
        bbnote "Enabling rescue mode"
        echo 'CONFIG_SYNA_RESCUE_MODE=y' >> "${UBOOT_DEFCONFIG}"
        echo "CONFIG_ENV_OFFSET=0x9BF0000" >> "${UBOOT_DEFCONFIG}"
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
