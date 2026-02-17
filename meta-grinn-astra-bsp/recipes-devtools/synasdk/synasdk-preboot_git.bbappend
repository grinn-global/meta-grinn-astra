2619_CORAL_FILES = "grinn-astra-2619-coral"

FILESEXTRAPATHS:prepend:grinn-astra-2619-coral := "${THISDIR}/${2619_CORAL_FILES}:"

BIN_FILES_DIR = "${S}/boot/mcu/cm52/image/chip/klamath/klamath_rdk/ddr4/"

SRC_URI:append:grinn-astra-2619-coral = " \
	file://apbl_extras.bin;subdir=${BIN_FILES_DIR} \
	file://apbl_output.bin;subdir=${BIN_FILES_DIR} \
	file://fw_extras.bin;subdir=${BIN_FILES_DIR} \
	file://fw_output.bin;subdir=${BIN_FILES_DIR} \
"
