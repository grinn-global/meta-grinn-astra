# Upstream Synaptics image tasks gates the SL2619 USB image flow on literal
# shell checks for sl2619usb. Grinn machine name differs, so the checks would
# fail and the SL2619-specific USB image handling would be skipped. Rewrite the
# literal at parse time so the gates trip for grinn-astra-2619-sbc-usb.
# bb.fatal guards against silent breakage if the sl2619usb literal is ever
# renamed or removed upstream.
python () {
    if d.getVar("MACHINE") != "grinn-astra-2619-sbc-usb":
        return

    # The USB image needs the initramfs file, so make sure it is built first.
    d.appendVarFlag("do_image_synausbimg", "depends", " core-image-initramfs-boot:do_image_complete")

    # This machine only packages already deployed files into the USB image.
    # It does not need the regular rootfs and generic image tasks.
    bb.build.deltask("do_rootfs", d)
    bb.build.deltask("do_image", d)

    # Use the SL2619 USB branches in Synaptics image tasks for the Grinn USB
    # machine too. do_image_synausbimg is generated later from IMAGE_CMD:synausbimg.
    for var in ("IMAGE_CMD:synausbimg", "do_swuimage", "do_rescueota"):
        deploy_body = d.getVar(var, False)
        if not deploy_body:
            # do_swuimage and do_rescueota come from optional SWUpdate layers,
            # so builds without those layers do not have to define them.
            if var == "IMAGE_CMD:synausbimg":
                bb.fatal(
                    "astra-media: expected %s to exist for USB image flow - "
                    "refactor astra-media-usb-boot.inc." % var
                )
            continue

        if "sl2619usb" not in deploy_body:
            bb.fatal(
                "astra-media: upstream %s no longer contains the "
                "'sl2619usb' machine gate - refactor astra-media-usb-boot.inc." % var
            )

        d.setVar(var, deploy_body.replace("sl2619usb", "grinn-astra-2619-sbc-usb"))
}
