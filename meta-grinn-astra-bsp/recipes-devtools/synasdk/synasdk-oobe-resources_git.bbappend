do_install:append() {
	cp ${S}/videos/h264/sl1680/* ${D}${rootdir}/demos/videos/h264/
	cp ${S}/videos/mp4/1080p/* ${D}${rootdir}/demos/videos/mp4/
	cp ${S}/config_files/syna_capability_demo_sl1680_config.txt ${D}${rootdir}/demos/configs/
}
