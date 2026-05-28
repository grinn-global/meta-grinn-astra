FILESEXTRAPATHS:prepend := "${THISDIR}/grinn-astra-2619-som:"

SRC_URI:append = " \
	file://sl2619_poky_aarch64_1gb_defconfig \
"

do_compile:prepend() {
	if [ "${GRINN_ASTRA_SOM}" = "grinn-astra-2619-som" ]; then
		cp ${WORKDIR}/sl2619_poky_aarch64_1gb_defconfig \
			${S}/configs/product/${SYNA_SDK_CONFIG_NAME}/sl2619_poky_aarch64_rdk_defconfig
	fi
}
