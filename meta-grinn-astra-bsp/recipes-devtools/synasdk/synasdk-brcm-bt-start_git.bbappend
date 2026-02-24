1680-ADA_FILES = "grinn-astra-1680-ada"
1680-EVB_FILES = "grinn-astra-1680-evb"
1680-SBC_FILES = "grinn-astra-1680-sbc"
2619-CORAL_FILES = "grinn-astra-2619-coral"

FILESEXTRAPATHS:prepend:grinn-astra-1680-ada := "${THISDIR}/${1680-ADA_FILES}:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-evb := "${THISDIR}/${1680-EVB_FILES}:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-sbc := "${THISDIR}/${1680-SBC_FILES}:"
FILESEXTRAPATHS:prepend:grinn-astra-2619-coral := "${THISDIR}/${2619-CORAL_FILES}:"

SRC_URI:append = " \
	file://brcm_bt_start.service \
"
