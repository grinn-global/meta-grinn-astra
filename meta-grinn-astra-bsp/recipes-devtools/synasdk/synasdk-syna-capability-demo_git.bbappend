do_install:append:grinn-astra-1680-platform() {
	install -m 0644 ${S}/qmls/sl1680-capability-demo.qml ${D}${qmldir}/
}

do_install:append:grinn-astra-2619-platform() {
	install -m 0644 ${S}/qmls/sl2619-capability-demo.qml ${D}${qmldir}/
}
