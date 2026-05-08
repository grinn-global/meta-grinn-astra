FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI += "file://sl1680_emmc.pt"

do_install:append() {
	if [ "${ENABLE_RESCUE_MODE}" = "1" ]; then
		case "${MACHINE}" in
			grinn-astra-1680-*)
				install -m 0644 ${WORKDIR}/sl1680_emmc.pt ${D}${datadir}/syna/build/emmc.pt
				;;
		esac
	fi
}
