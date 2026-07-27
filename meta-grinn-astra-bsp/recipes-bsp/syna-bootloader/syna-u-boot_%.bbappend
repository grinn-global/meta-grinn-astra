FILESEXTRAPATHS:prepend:grinn-astra-platform := "${THISDIR}/common:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-platform := "${THISDIR}/grinn-astra-1680/common:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-som := "${THISDIR}/grinn-astra-1680/som:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-ada := "${THISDIR}/grinn-astra-1680/ada:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-sbc := "${THISDIR}/grinn-astra-1680/sbc:"
FILESEXTRAPATHS:prepend:grinn-astra-261x-platform := "${THISDIR}/grinn-astra-261x/common:"
FILESEXTRAPATHS:prepend:grinn-astra-261x-som := "${THISDIR}/grinn-astra-261x/som:"
FILESEXTRAPATHS:prepend:grinn-astra-2619-sbc := "${THISDIR}/grinn-astra-261x/sbc:"
FILESEXTRAPATHS:prepend:grinn-astra-2619-sbc-usb := "${THISDIR}/grinn-astra-261x/sbc:"

DT_DIR = "${S}/arch/arm/dts"
CFG_DIR = "${S}/configs"

# USB machine share the base board device tree.
# Needed to provide ${MACHINE}.dts device tree for machines containing `-usb` suffix.
GRINN_MACHINE = "${@d.getVar('MACHINE').removesuffix('-usb')}"

SRC_URI:append:grinn-astra-platform = " \
	file://0001-uboot-add-mac-support-for-TXC-90-degree-phase-shift.patch \
	file://eth.cfg \
	file://misc.cfg \
	file://${GRINN_MACHINE}.dts \
"

SRC_URI:append:grinn-astra-1680-som = " \
        file://grinn-astra-1680-som.dtsi \
"

SRC_URI:append:grinn-astra-1680-sbc = " \
	file://0001-board-dolphin-disable-rescue-mode-gpio-trigger.patch \
	file://display_disable.cfg \
"

SRC_URI:append:grinn-astra-2619-som = " \
	file://memory_1gb.cfg \
"

SRC_URI:append:grinn-astra-2619-sbc = " \
	file://0001-board-synaptics-klamath-klamath_boardinit-use-default.patch \
	file://hdmi_disable.cfg \
	file://overlay.cfg \
"

do_configure:append:grinn-astra-1680-platform() {
	cp ${WORKDIR}/${MACHINE}.dts ${DT_DIR}/dolphin-rdk.dts
	cp ${WORKDIR}/grinn-astra-1680-som.dtsi ${DT_DIR}
}

do_configure:append:grinn-astra-261x-platform() {
	cp ${WORKDIR}/${GRINN_MACHINE}.dts ${DT_DIR}/klamath-rdk.dts
}

# Generate the manifest for non-USB machines and regenerate the upstream USB
# manifest with Grinn board name. Manifest is used by astra-update tool.
do_deploy:append:grinn-astra-261x-platform() {
	python3 ${WORKDIR}/generate_boot_manifest.py \
		--uboot_binary ${B}/../../uboot_en.bin \
		--sdk_config ${STAGING_DATADIR_NATIVE}/syna/build/.config \
		--uboot_config ${B}/.config \
		--board ${MACHINE} \
		--output ${WORKDIR}/manifest.yaml
	install -m 0644 ${WORKDIR}/manifest.yaml ${DEPLOYDIR}/manifest.yaml
}

# Upstream syna-u-boot_git.bb gates the SL2619 USB deploy branch on a
# literal shell check: [ "${MACHINE}" != "sl2619usb" ]. Grinn machine name
# differs, so the check would pass and the eMMC branch would run, breaking the
# USB deploy path and manifest generation. Rewrite the literal at parse time so 
# the gate trips for grinn-astra-2619-sbc-usb. bb.fatal guards against silent 
# breakage if the sl2619usb literal is ever renamed or removed upstream.
python () {
    if d.getVar("MACHINE") != "grinn-astra-2619-sbc-usb":
        return

    deploy_body = d.getVar("do_deploy", False)
    if not deploy_body or "sl2619usb" not in deploy_body:
        bb.fatal(
            "syna-u-boot: upstream do_deploy no longer contains the "
            "'sl2619usb' machine gate - refactor this bbappend."
        )

    d.setVar("do_deploy", deploy_body.replace("sl2619usb", "grinn-astra-2619-sbc-usb"))
}
