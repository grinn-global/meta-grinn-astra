do_install:append() {
	install -m 0644 ${S}/qmls/sl1680-capability-demo.qml ${D}${qmldir}/
}
