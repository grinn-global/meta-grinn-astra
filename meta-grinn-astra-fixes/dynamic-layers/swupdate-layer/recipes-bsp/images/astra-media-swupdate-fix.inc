IMAGE_INSTALL:append = " \
	swupdate-www \
"

OVERRIDES .= ":${@'rescue' if d.getVar('ENABLE_RESCUE_MODE') == '1' else ''}"
IMAGE_INSTALL:remove:rescue = " \
	${SWUPDATE_INSTALL} \
	swupdate-www \
"
