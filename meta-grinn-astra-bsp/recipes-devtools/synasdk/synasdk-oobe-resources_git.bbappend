# The base recipe selects SoC resources by exact MACHINE name (sl1680, sl2619),
# so it installs none of them for GRINN machines.
do_install:append:grinn-astra-1680-platform() {
	cp ${S}/videos/h264/sl1680/* ${D}${rootdir}/demos/videos/h264/
	cp ${S}/videos/mp4/1080p/* ${D}${rootdir}/demos/videos/mp4/
	cp ${S}/config_files/syna_capability_demo_sl1680_config.txt ${D}${rootdir}/demos/configs/
}

do_install:append:grinn-astra-261x-platform() {
	cp ${S}/videos/h264/sl261x/* ${D}${rootdir}/demos/videos/h264/
	cp ${S}/videos/mp4/480p/* ${D}${rootdir}/demos/videos/mp4/
	cp ${S}/videos/mp4/720p/* ${D}${rootdir}/demos/videos/mp4/
	install -d ${D}/usr/share/synap/models
	cp -r ${S}/models/sl261x/* ${D}/usr/share/synap/models/
	cp ${S}/config_files/syna_capability_demo_sl2619_config.txt ${D}${rootdir}/demos/configs/
}

FILES:${PN}:append:grinn-astra-261x-platform = " /usr/share/synap/models/*"
