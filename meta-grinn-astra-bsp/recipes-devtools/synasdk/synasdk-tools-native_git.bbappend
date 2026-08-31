do_install:append() {
	install -m 0755 ${S}/build/tools/bin/gen_sd.sh ${D}${bindir}/gen_sd.sh
}
