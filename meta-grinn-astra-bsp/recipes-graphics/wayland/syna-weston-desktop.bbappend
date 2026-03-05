do_install:prepend:grinn-astra-1680-platform() {
	cp ${S}/weston-sl1680.ini ${S}/weston-${MACHINE}.ini
}

do_install:prepend:grinn-astra-2619-platform() {
	cp ${S}/weston-sl2619.ini ${S}/weston-${MACHINE}.ini
}
