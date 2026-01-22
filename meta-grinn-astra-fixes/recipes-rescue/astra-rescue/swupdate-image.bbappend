ROOTFS_POSTPROCESS_COMMAND:remove = " remove_swupdate_init_script; "

IMAGE_INSTALL += " \
	swupdate-client \
"

IMAGE_INSTALL:remove = " \
	initscripts \
	sysvinit \
"
