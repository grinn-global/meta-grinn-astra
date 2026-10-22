# The meta-synaptics append selects the touch mapping rule by the MACHINE
# name prefix (sl1620, sl1680), so it installs none for GRINN machines.
do_install:append:grinn-astra-1680-platform() {
	install -Dm0644 ${WORKDIR}/99-touch-mapping-sl1680.rules \
		${D}${sysconfdir}/udev/rules.d/99-touch-mapping.rules
}
