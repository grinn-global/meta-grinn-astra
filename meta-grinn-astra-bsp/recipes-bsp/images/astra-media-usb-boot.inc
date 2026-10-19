# The USB image packs the initramfs file, so make sure it is built first.
python () {
    if d.getVar("MACHINE") not in ("grinn-astra-2619-som-usb",
                                   "grinn-astra-2619-som-xspi-usb"):
        return

    d.appendVarFlag("do_image_synausbimg", "depends", " core-image-initramfs-boot:do_image_complete")
}
