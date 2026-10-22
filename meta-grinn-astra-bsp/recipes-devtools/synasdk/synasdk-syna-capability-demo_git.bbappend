# The base recipe selects the QML by exact MACHINE name (sl1680, sl2619),
# so it installs none of them for GRINN machines.
do_install:append:grinn-astra-1680-platform() {
	install -m 0644 ${S}/qmls/sl1680-capability-demo.qml ${D}${qmldir}/
}

do_install:append:grinn-astra-261x-platform() {
	install -m 0644 ${S}/qmls/sl2619-capability-demo.qml ${D}${qmldir}/
}
