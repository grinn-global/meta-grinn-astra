FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PACKAGECONFIG:append = " nmtui"

# Drop the SysV init script on systemd images, so there is only a single
# NetworkManager daemon running. systemd-sysv-generator would otherwise turn
# /etc/init.d/network-manager into a generated network-manager.service that
# races NetworkManager.service for the org.freedesktop.NetworkManager bus
# name. INHIBIT_UPDATERCD_BBCLASS additionally suppresses the update-rc.d
# postinst that would fail at rootfs time because the script has been
# removed.
INHIBIT_UPDATERCD_BBCLASS = "${@bb.utils.contains('VIRTUAL-RUNTIME_init_manager', 'systemd', '1', '', d)}"
FILES:${PN}-daemon:remove = "${@bb.utils.contains('VIRTUAL-RUNTIME_init_manager', 'systemd', '${sysconfdir}/init.d/network-manager', '', d)}"

do_install:append() {
    ${@bb.utils.contains('VIRTUAL-RUNTIME_init_manager', 'systemd', 'rm -f ${D}${sysconfdir}/init.d/network-manager', ':', d)}
}
