do_install() {
	install -d ${D}/rescue

	KERNEL_FILE="${DEPLOY_DIR_IMAGE}/Image-${MACHINE}.bin"
	INITRAMFS_FILE=$(find ${DEPLOY_DIR_IMAGE} -name "swupdate-image-${MACHINE}.rootfs-*.cpio.gz" | head -n 1)
	DTB_FILE=$(find ${DEPLOY_DIR_IMAGE} -type f -name "*.dtb" \
		 | grep -E "(-rdk-|grinn-astra-1680-(ada|sbc))")

	# Compress and install files
	gzip -c -1 "$KERNEL_FILE" > ${D}/rescue/Image-${MACHINE}.gz
	install -m 0644 "$DTB_FILE" ${D}/rescue/rescue-${MACHINE}.dtb
	install -m 0644 "$INITRAMFS_FILE" ${D}/rescue/rescue-${MACHINE}.rootfs.cpio.gz

	# Install the script into /etc
	install -d ${D}${sysconfdir}
	install -m 0755 ${WORKDIR}/rescue-handler ${D}${sysconfdir}/rescue-handler

	# Install systemd service
	install -d ${D}${systemd_system_unitdir}
	install -m 0644 ${WORKDIR}/astra-rescue.service ${D}${systemd_system_unitdir}/
}
