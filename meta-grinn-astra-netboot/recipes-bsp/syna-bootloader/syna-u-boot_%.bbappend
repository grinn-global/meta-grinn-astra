FILESEXTRAPATHS:prepend:grinn-astra-1680-platform := "${THISDIR}/grinn-astra-1680/common:"

SRC_URI:append:grinn-astra-1680-platform = " \
	file://net_conf.cfg \
"
