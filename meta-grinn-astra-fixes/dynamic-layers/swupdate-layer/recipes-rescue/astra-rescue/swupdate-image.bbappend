ROOTFS_POSTPROCESS_COMMAND:remove = " remove_swupdate_init_script; "

IMAGE_INSTALL += " \
	swupdate-client \
"

IMAGE_INSTALL:remove = " \
	initscripts \
	sysvinit \
"

IMAGE_INSTALL:remove = " \
	kernel-module-stmmac \
	kernel-module-stmmac-platform \
	kernel-module-dwmac-generic \
"
