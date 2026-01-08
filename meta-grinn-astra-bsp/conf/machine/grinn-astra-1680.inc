#
# Modify the Yocto TAG filename by inserting "sl" before "1680",
# ensuring compatibility with the Synaptics astra-update tool
# for GRINN boards based on the sl1680 chip.
#
# NOTE: IMAGE_NAME ?= "${IMAGE_BASENAME}-${MACHINE}${IMAGE_VERSION_SUFFIX}"
#

MACHINEOVERRIDES =. "grinn-astra-1680:"
IMAGE_FSTYPES:append = " tar.xz"

IMAGE_CMD:synaimg:append () {
    rm ${DEPLOY_DIR_IMAGE}/${SYNAIMG_DEPLOY_SUBDIR}/TAG--${IMAGE_NAME}--TAG

    local regex="([^-]+-[^-]+-)([0-9]+)"
    local cpu_prefix="\1sl\2"
    local machine_fix=`echo ${MACHINE} | sed -E 's/'${regex}'/'${cpu_prefix}'/'`
    local image_name_fix=${IMAGE_BASENAME}-${machine_fix}${IMAGE_VERSION_SUFFIX}
    touch ${DEPLOY_DIR_IMAGE}/${SYNAIMG_DEPLOY_SUBDIR}/TAG--${image_name_fix}--TAG
}

