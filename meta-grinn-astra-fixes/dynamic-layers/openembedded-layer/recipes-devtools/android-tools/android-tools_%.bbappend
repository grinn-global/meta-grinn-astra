FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
	file://0006-change-pthread_kill-for-glibc.patch \
"
