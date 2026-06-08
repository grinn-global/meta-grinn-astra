FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
	file://0001-bootctrl-point-misc-device-to-mmcblk0p15.patch \
	file://0002-bootctrl-resolve-misc-device-by-gpt-label.patch \
"
