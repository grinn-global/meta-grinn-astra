#
# Copyright 2026 Grinn sp. z o.o.
#
# SPDX-License-Identifier: MIT
#
# This class builds an SD card image from the SYNAIMG outputs by invoking
# gen_sd.sh (shipped by synasdk-tools-native). The SYNAIMG contents are
# copied to a private work directory before invocation, as gen_sd.sh
# mutates its CWD.
#
# Archive compression is determined automatically by the IMAGE_FSTYPES
# extension (e.g. synaimg.sd.zst, synaimg.sd.xz).
#
# Enable by adding to your machine conf or local.conf:
#   IMAGE_CLASSES += "image_synaimg_sd"
#   IMAGE_FSTYPES += "synaimg.sd.zst"
#

inherit image_types synaimg_common

IMAGE_TYPES:append = " synaimg.sd"
IMAGE_TYPEDEP:synaimg.sd = "synaimg"

do_image_synaimg_sd[depends] += " \
    synasdk-tools-native:do_populate_sysroot \
    e2fsprogs-native:do_populate_sysroot \
    gzip-native:do_populate_sysroot \
    gptfdisk-native:do_populate_sysroot \
"

IMAGE_CMD:synaimg.sd () {
    workdir="${WORKDIR}/synaimg.sd"
    rm -rf "$workdir"
    mkdir -p "$workdir"

    # gen_sd.sh mutates its CWD: sparse files are moved aside, .gz
    # files are decompressed in place, and *.subimg are then removed.
    # To keep SYNAIMG/ in DEPLOY_DIR_IMAGE untouched, the contents are
    # copied into a private work directory and gen_sd.sh is invoked there.
    cp -a "${DEPLOY_DIR_IMAGE}/${SYNAIMG_DEPLOY_SUBDIR}/." "$workdir/"
    (cd "$workdir" && gen_sd.sh)

    mv "$workdir/SD.img" "${IMGDEPLOYDIR}/${IMAGE_NAME}.synaimg.sd"
    rm -rf "$workdir"
}
