FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append:dolphin = " \
    file://0001-Revert-ipc-set-timeout-value-to-1.patch \
"
