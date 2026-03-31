inherit image_types synaimg_common

IMAGE_TYPES:append = " synaimg.tar"
IMAGE_TYPEDEP:synaimg.tar = "synaimg"

IMAGE_CMD:synaimg.tar () {
    synaimg_dir="${DEPLOY_DIR_IMAGE}/${SYNAIMG_DEPLOY_SUBDIR}"
    excludes=""

    # Exclude rootfs.subimg.gz when sparse rootfs files are present,
    # as it becomes a redundant copy not referenced by emmc_image_list.
    if ls "$synaimg_dir"/rootfs_s.subimg* >/dev/null 2>&1; then
        excludes="--exclude=rootfs.subimg.gz"
    fi

    ${IMAGE_CMD_TAR} --sort=name --format=posix $excludes \
        -cf ${IMGDEPLOYDIR}/${IMAGE_NAME}.synaimg.tar \
        -C ${DEPLOY_DIR_IMAGE} ${SYNAIMG_DEPLOY_SUBDIR}
}
