IMAGE_INSTALL:append = " \
	image-sensor-demo \
	swupdate-www \
"

IMAGE_INSTALL:append:grinn-astra-1680-ada = " \
	hdmi-rx-demo \
"

IMAGE_INSTALL:append:grinn-astra-1680-evb = " \
	dmic-demo \
"

deltask do_swuimage
