SUMMARY = "SWUpdate image for astra-media-oobe"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SYNA_SDK_VERSION = "1.8.0"
SYNA_IMAGE_NAME = "astra-media-oobe"
SWU_IMAGE_GENERATION_COMMON = "swupdate-image-generation-common"

python __anonymous() {
    mode = {
        "0": "swupdate-image-generation-dual-copy",
        "1": "swupdate-image-generation-single-copy",
    }.get(d.getVar("ENABLE_RESCUE_MODE"), "")

    d.setVar("SWU_IMAGE_GENERATION", mode)
}

FILESEXTRAPATHS:prepend := "${THISDIR}/${SWU_IMAGE_GENERATION}:"

SRC_URI = " \
	file://sw-description \
	file://post.sh \
"

IMAGE_DEPENDS = "${SYNA_IMAGE_NAME}"

SWUPDATE_SIGNING = "CMS"
SWUPDATE_CMS_KEY = "${THISDIR}/${SWU_IMAGE_GENERATION_COMMON}/demo.key.pem"
SWUPDATE_CMS_CERT = "${THISDIR}/${SWU_IMAGE_GENERATION_COMMON}/demo.cert.pem"

SWUPDATE_IMAGES = " \
	preboot \
	key \
	tzk \
	bl \
	boot \
	firmware \
	${SYNA_IMAGE_NAME}-${MACHINE} \
	fastlogo \
"

SWUPDATE_IMAGES_FSTYPES[preboot] = ".subimg"
SWUPDATE_IMAGES_FSTYPES[key] = ".subimg"
SWUPDATE_IMAGES_FSTYPES[tzk] = ".subimg"
SWUPDATE_IMAGES_FSTYPES[bl] = ".subimg"
SWUPDATE_IMAGES_FSTYPES[boot] = ".subimg"
SWUPDATE_IMAGES_FSTYPES[firmware] = ".subimg"
SWUPDATE_IMAGES_FSTYPES[fastlogo] = ".subimg"

python () {
    image = d.expand('${SYNA_IMAGE_NAME}-${MACHINE}')
    d.setVarFlag('SWUPDATE_IMAGES_FSTYPES', image, '.ext4.gz')
}

inherit swupdate
