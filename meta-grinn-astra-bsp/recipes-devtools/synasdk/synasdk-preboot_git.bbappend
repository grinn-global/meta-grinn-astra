FILESEXTRAPATHS:prepend:grinn-astra-2619-sbc := "${THISDIR}/grinn-astra-2619-sbc:"
FILESEXTRAPATHS:prepend:grinn-astra-2619-sbc-usb := "${THISDIR}/grinn-astra-2619-sbc:"

BIN_FILES_DIR = "${S}/boot/mcu/cm52/image/chip/klamath/klamath_rdk/ddr4x16/"

SRC_URI:append:grinn-astra-2619-platform = " \
	file://apbl_extras.bin;subdir=${BIN_FILES_DIR} \
	file://apbl_output.bin;subdir=${BIN_FILES_DIR} \
	file://fw_extras.bin;subdir=${BIN_FILES_DIR} \
	file://fw_output.bin;subdir=${BIN_FILES_DIR} \
"

# Upstream synasdk-preboot_git.bb gates the SL2619 USB deploy branch on
# a literal shell check: [ "${MACHINE}" = "sl2619usb" ]. Grinn machine name
# differs, so the check would fail and the eMMC branch would run, leaving
# key.bin/spk.bin/m52bl.bin out of DEPLOYDIR and breaking the hostgit
# usb_boot_tool.py flash later. Rewrite the literal at parse time so the
# gate trips for grinn-astra-2619-sbc-usb. bb.fatal guards against silent
# breakage if the sl2619usb literal is ever renamed or removed upstream.
python () {
    if d.getVar("MACHINE") != "grinn-astra-2619-sbc-usb":
        return

    deploy_body = d.getVar("do_deploy", False)
    if not deploy_body or "sl2619usb" not in deploy_body:
        bb.fatal(
            "synasdk-preboot: upstream do_deploy no longer contains the "
            "'sl2619usb' machine gate — refactor this bbappend."
        )
    d.setVar("do_deploy", deploy_body.replace("sl2619usb", "grinn-astra-2619-sbc-usb"))
}
