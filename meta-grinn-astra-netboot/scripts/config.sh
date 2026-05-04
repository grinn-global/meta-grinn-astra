#!/usr/bin/env bash
# Netboot configuration sourced by setup.sh and sync.sh.
# Modify values below to match your environment.

NETBOOT_USR="$(whoami)"
NETBOOT_SERVER_IP="$(ip -4 route get 1 2>/dev/null | sed -n 's/^.*src \([^ ]*\).*$/\1/p;q')"

if [ -z "${NETBOOT_SERVER_IP}" ]; then
	echo "Error: could not determine NETBOOT_SERVER_IP"
	exit 1
else
	echo "Server IP: ${NETBOOT_SERVER_IP}"
fi

TFTP_PATH="/srv/tftp"
NFS_ROOTFS_PATH="/srv/nfs/${NETBOOT_USR}/rootfs"
TFTP_KERNEL_BIN_PATH="${NETBOOT_USR}/image.bin"
TFTP_DTB_BIN_PATH="${NETBOOT_USR}/dtb.dtb"
TFTP_IMAGE_PATH="${NETBOOT_USR}/SYNAIMG"
