FILESEXTRAPATHS:prepend:grinn-astra-platform := "${THISDIR}/common:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-som := "${THISDIR}/grinn-astra-1680/som:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-ada := "${THISDIR}/grinn-astra-1680/ada:"
FILESEXTRAPATHS:prepend:grinn-astra-1680-sbc := "${THISDIR}/grinn-astra-1680/sbc:"
FILESEXTRAPATHS:prepend:grinn-astra-261x-platform := "${THISDIR}/grinn-astra-261x/common:"
FILESEXTRAPATHS:prepend:grinn-astra-261x-som := "${THISDIR}/grinn-astra-261x/som:"
FILESEXTRAPATHS:prepend:grinn-astra-261x-sbc := "${THISDIR}/grinn-astra-261x/sbc:"

DT_DIR = "${S}/arch/arm64/boot/dts/synaptics"

SRC_URI:append:grinn-astra-platform = " \
	file://${MACHINE}.dts;subdir=${DT_DIR} \
	file://0001-linux-add-dwmac-support-for-TXC-90-degree-phase-shif.patch \
	file://gpiolib.cfg \
	file://nfs.cfg \
"

SRC_URI:append:grinn-astra-1680-platform = " \
	file://0002-avio-dhub-rate-limit-spurious-interrupt-log.patch;apply=no \
	file://modem.cfg \
"

SRC_URI:append:grinn-astra-1680-som = " \
	file://grinn-astra-1680-som.dtsi;subdir=${DT_DIR} \
	file://regulator.cfg \
"

SRC_URI:append:grinn-astra-1680-ada = " \
	file://eth.cfg \
"

SRC_URI:append:grinn-astra-1680-sbc = " \
	file://0001-bcmdhd-stop-watchdog-on-suspend-to-release-SDIO-wake.patch;apply=no \
	file://0002-bcmdhd-disable-DHD_WOWL_IN_SUSPEND_SDIO.patch;apply=no \
	file://bcmdhd.cfg \
	file://gpio-led.cfg \
	file://eth.cfg \
	file://nvme.cfg \
	file://spi.cfg \
	${@bb.utils.contains('MACHINE_FEATURES', 'deepx', 'file://deepx.cfg', '', d)} \
"

SRC_URI:append:grinn-astra-2619-som = " \
	file://grinn-astra-2619-som.dtsi;subdir=${DT_DIR} \
"

SRC_URI:append:grinn-astra-261x-sbc = " \
	file://eth.cfg \
	file://gpio-led.cfg \
	file://grinn-astra-261x-sbc.dtsi;subdir=${DT_DIR} \
	file://waveshare-7inch-panel-overlay.dtso;subdir=${DT_DIR} \
"

# kernel-yocto applies patches via kgit-s2q on the main kernel index, which
# does not track drivers/synaptics/. Mark patches as apply=no so kgit skips
# them, and apply them manually here with plain patch.
do_patch:append:grinn-astra-1680-platform() {
	patch -d ${S} -p1 < ${WORKDIR}/0002-avio-dhub-rate-limit-spurious-interrupt-log.patch
}

do_patch:append:grinn-astra-1680-sbc() {
	patch -d ${S} -p1 < ${WORKDIR}/0001-bcmdhd-stop-watchdog-on-suspend-to-release-SDIO-wake.patch
	patch -d ${S} -p1 < ${WORKDIR}/0002-bcmdhd-disable-DHD_WOWL_IN_SUSPEND_SDIO.patch
}
