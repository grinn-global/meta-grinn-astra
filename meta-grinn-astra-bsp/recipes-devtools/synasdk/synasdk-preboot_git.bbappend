FILESEXTRAPATHS:prepend:grinn-astra-2619-sbc := "${THISDIR}/grinn-astra-2619-sbc:"

BIN_FILES_DIR = "${S}/boot/mcu/cm52/image/chip/klamath/klamath_rdk/ddr4x16/"

SRC_URI:append:grinn-astra-2619-sbc = " \
	file://apbl_extras.bin;subdir=${BIN_FILES_DIR} \
	file://apbl_output.bin;subdir=${BIN_FILES_DIR} \
	file://fw_extras.bin;subdir=${BIN_FILES_DIR} \
	file://fw_output.bin;subdir=${BIN_FILES_DIR} \
"
