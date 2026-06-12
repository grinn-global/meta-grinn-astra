#
# Copyright 2026 Grinn sp. z o.o.
#
# SPDX-License-Identifier: MIT
#
# This class creates a bootloader-only image archive from SYNAIMG outputs.
# The archive contains a subset of subimages and a custom emmc_image_list
# suitable for bootloader flashing (e.g. via LAVA testing infrastructure).
#
# Archive compression is determined automatically by the IMAGE_FSTYPES
# extension (e.g. synaimg_bootloader.tar.zst, synaimg_bootloader.tar.xz).
#
# Enable by adding to your machine conf or local.conf:
#   IMAGE_CLASSES += "image_synaimg_bootloader_tar"
#   IMAGE_FSTYPES += "synaimg_bootloader.tar.zst"
#

inherit image_types synaimg_common

IMAGE_TYPES:append = " synaimg_bootloader.tar"
IMAGE_TYPEDEP:synaimg_bootloader.tar = "synaimg"

# Files to include in the bootloader archive (space-separated list)
SYNAIMG_BOOTLOADER_FILES ?= "bl.subimg.gz key.subimg.gz tzk.subimg.gz preboot.subimg.gz fastlogo.subimg.gz emmc_part_list"

# Custom emmc_image_list content for bootloader flashing
# This defines the partition layout used for flashing
SYNAIMG_BOOTLOADER_EMMC_IMAGE_LIST ?= "\
preboot.subimg.gz,b1\n\
preboot.subimg.gz,b2\n\
format,sd1\n\
key.subimg.gz,sd2\n\
tzk.subimg.gz,sd3\n\
key.subimg.gz,sd4\n\
tzk.subimg.gz,sd5\n\
bl.subimg.gz,sd6\n\
bl.subimg.gz,sd7\n\
fastlogo.subimg.gz,sd12\n\
fastlogo.subimg.gz,sd13\
"

IMAGE_CMD:synaimg_bootloader.tar () {
    synaimg_dir="${DEPLOY_DIR_IMAGE}/${SYNAIMG_DEPLOY_SUBDIR}"
    bootloader_dir="${WORKDIR}/synaimg_bootloader"

    if [ ! -d "${synaimg_dir}" ]; then
        bberror "SYNAIMG directory not found: ${synaimg_dir}"
        exit 1
    fi

    rm -rf "${bootloader_dir}"
    mkdir -p "${bootloader_dir}"

    # Copy required files from SYNAIMG
    for file in ${SYNAIMG_BOOTLOADER_FILES}; do
        src="${synaimg_dir}/${file}"
        if [ -f "${src}" ]; then
            cp -L "${src}" "${bootloader_dir}/"
        else
            bberror "Required file not found in SYNAIMG: ${file}"
            exit 1
        fi
    done

    # Copy TAG files
    for tag_file in ${synaimg_dir}/TAG--*--TAG; do
        if [ -f "${tag_file}" ]; then
            cp -L "${tag_file}" "${bootloader_dir}/"
        fi
    done

    # Create custom emmc_image_list for bootloader flashing
    printf '%b\n' "${SYNAIMG_BOOTLOADER_EMMC_IMAGE_LIST}" > "${bootloader_dir}/emmc_image_list"

    ${IMAGE_CMD_TAR} --sort=name --format=posix \
        -cf ${IMGDEPLOYDIR}/${IMAGE_NAME}.synaimg_bootloader.tar \
        -C ${bootloader_dir} .
}
