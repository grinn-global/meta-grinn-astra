#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
CONFIG_FILE="${SCRIPT_DIR}/config.sh"

if [ ! -f "${CONFIG_FILE}" ]; then
    echo "Error: ${CONFIG_FILE} not found."
    exit 1
fi

source "${CONFIG_FILE}"

NETBOOT_CFG_NAME="net_conf.cfg"
NETBOOT_CFG_BASE_DIR="${SCRIPT_DIR}/../recipes-bsp/syna-bootloader"

if [ ! -d "${TFTP_PATH}/${NETBOOT_USR}" ]; then
    echo "${TFTP_PATH}/${NETBOOT_USR} doesn't exist! Creating directory.."
    sudo mkdir -p "${TFTP_PATH}/${NETBOOT_USR}"
fi

if [ ! -d ${NFS_ROOTFS_PATH} ]; then
    echo "${NFS_ROOTFS_PATH} doesn't exist! Creating directory.."
    sudo mkdir -p ${NFS_ROOTFS_PATH}
fi

PREBOOT_ENV="show_logo"
SRV_IP_ENV="env exists srv_ip || setenv srv_ip ${NETBOOT_SERVER_IP}"
TFTP_IMAGE_ENV="env exists tftp_image_path || setenv tftp_image_path ${TFTP_IMAGE_PATH}"
TFTP_KERNEL_ENV="env exists tftp_kernel || setenv tftp_kernel ${TFTP_KERNEL_BIN_PATH}"
TFTP_DTB_ENV="env exists tftp_dtb || setenv tftp_dtb ${TFTP_DTB_BIN_PATH}"
NFS_ENV="env exists nfs_rootfs || setenv nfs_rootfs ${NFS_ROOTFS_PATH}"

TFTP_FLASH_ENV='env exists tftp_flash || setenv tftp_flash '"'"'net_init;dhcp;setenv serverip \${srv_ip};tftp2emmc \${tftp_image_path}'"'"''
NETBOOT_ENV='env exists boot_net || setenv boot_net '"'"'net_init;dhcp;setenv serverip \${srv_ip};setenv skip_fdt_update 2;setenv loadaddr 0x7c00000;setenv dtbaddr 0x47f1000;tftpboot \${loadaddr} \${tftp_kernel};tftpboot \${dtbaddr} \${tftp_dtb};booti \${loadaddr} - \${dtbaddr}'"'"''
NETBOOT_BOOT_ENV='env exists netboot_boot || setenv netboot_boot '"'"'setenv bootargs \${bootargs_net}; run boot_net'"'"''
NETBOOT_DEFAULT_ENV='env exists netboot || setenv netboot 1'

BOOTCOMMAND='if test \"\${netboot}\" = \"1\"; then run netboot_boot; else env delete skip_fdt_update; env delete bootargs; bootmmc; fi'

generate_netboot_config() {
    local platform="$1"
    local bootargs_extra="$2"
    local output_dir="${NETBOOT_CFG_BASE_DIR}/${platform}/common"
    local output="${output_dir}/${NETBOOT_CFG_NAME}"

    BOOTARGS_ENV="setenv bootargs_net console=ttyS0,115200 root=/dev/nfs rw nfsroot=\\\${srv_ip}:\\\${nfs_rootfs},v3,tcp ip=dhcp rootwait ${bootargs_extra}"
    PREBOOT="${PREBOOT_ENV};${SRV_IP_ENV};${TFTP_IMAGE_ENV};${TFTP_KERNEL_ENV};${TFTP_DTB_ENV};${TFTP_FLASH_ENV};${NFS_ENV};${BOOTARGS_ENV};${NETBOOT_ENV};${NETBOOT_BOOT_ENV};${NETBOOT_DEFAULT_ENV};"

    mkdir -p "${output_dir}"

    printf '%s\n' \
        "CONFIG_BOOTCOMMAND=\"${BOOTCOMMAND}\"" \
        "CONFIG_USE_PREBOOT=y" \
        "CONFIG_PREBOOT=\"${PREBOOT}\"" \
        > "${output}"

    echo "${platform}/${NETBOOT_CFG_NAME} generated successfully."
}

generate_netboot_config "grinn-astra-1680" "avio.fastlogo_status=25025 syna_drm.logo_info=c3f91000@780x438-f00 cma=524288000@3166699520 "
generate_netboot_config "grinn-astra-261x" ""
