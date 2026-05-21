FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://0001-fastlogo-ta-guard-validator-against-zero-sized-buffe.patch;patchdir=${WORKDIR}/${SYNA_SOURCE_PREFIX}/tee/optee_dev"
