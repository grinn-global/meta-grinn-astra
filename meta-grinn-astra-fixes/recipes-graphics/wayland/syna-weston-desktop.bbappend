do_install:prepend:sl2619-coralboard() {
    cp -r ${S}/weston-sl2619_coral.ini ${S}/weston-${MACHINE}.ini
}
