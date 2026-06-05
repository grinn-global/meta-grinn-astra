do_install:append:grinn-astra-1680-platform () {
    install -d ${D}${dedir}
    install -m 0755 ${S}/sl1680_od_cam.py ${D}${dedir}/
}
