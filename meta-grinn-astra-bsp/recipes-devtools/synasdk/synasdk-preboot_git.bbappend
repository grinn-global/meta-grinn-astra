FILESEXTRAPATHS:prepend:grinn-astra-261x-platform := "${THISDIR}/grinn-astra-261x-platform:"

BIN_FILES_DIR = "${S}/boot/mcu/cm52/image/chip/klamath/klamath_rdk/ddr4/"

SRC_URI:append:grinn-astra-261x-platform = " \
	file://apbl_extras.bin;subdir=${BIN_FILES_DIR} \
	file://apbl_output.bin;subdir=${BIN_FILES_DIR} \
	file://fw_extras.bin;subdir=${BIN_FILES_DIR} \
	file://fw_output.bin;subdir=${BIN_FILES_DIR} \
"
