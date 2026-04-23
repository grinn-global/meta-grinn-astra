do_install:append:grinn-astra-1680-platform() {
	cp ${S}/videos/h264/sl1680/* ${D}${rootdir}/demos/videos/h264/
	cp ${S}/videos/mp4/1080p/* ${D}${rootdir}/demos/videos/mp4/
	cp ${S}/config_files/syna_capability_demo_sl1680_config.txt ${D}${rootdir}/demos/configs/
}

do_install:append:grinn-astra-2619-platform() {
	cp ${S}/videos/h264/sl261x/* ${D}${rootdir}/demos/videos/h264/
	cp ${S}/videos/mp4/720p/* ${D}${rootdir}/demos/videos/mp4/
	cp ${S}/config_files/syna_capability_demo_sl2619_config.txt ${D}${rootdir}/demos/configs/

	install -d ${D}/usr/share/synap/models
	cp -r ${S}/models/sl261x/* ${D}/usr/share/synap/models/
}

FILES:${PN}:grinn-astra-2619-platform = " \
	${sysconfdir} \
	${rootdir}/demos/* \
	${datadir}/synap/models/* \
"
