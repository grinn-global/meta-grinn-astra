FILESEXTRAPATHS:prepend:grinn-astra-1680-platform := "${THISDIR}/grinn-astra-1680/common:"
FILESEXTRAPATHS:prepend:grinn-astra-261x-platform := "${THISDIR}/grinn-astra-261x/common:"

SRC_URI:append:grinn-astra-1680-platform = " \
	file://net_conf.cfg \
"

SRC_URI:append:grinn-astra-261x-platform = " \
	file://net_conf.cfg \
"
