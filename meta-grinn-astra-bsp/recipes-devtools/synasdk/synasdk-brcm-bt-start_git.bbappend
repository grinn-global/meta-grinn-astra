ADA_FILES = "grinn-astra-1680-ada"
SBC_FILES = "grinn-astra-1680-sbc"

FILESEXTRAPATHS:prepend:grinn-astra-1680-ada := "${THISDIR}/${ADA_FILES}:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-sbc := "${THISDIR}/${SBC_FILES}:"

SRC_URI:append = " \
	file://brcm_bt_start.service \
"
