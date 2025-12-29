IMAGE_INSTALL:append = " \
	image-sensor-demo \
	networkmanager-nmtui \
	terrasat-modem \
"

IMAGE_INSTALL:append:grinn-astra-1680-ada = " \
	hdmi-rx-demo \
"

IMAGE_INSTALL:append:grinn-astra-1680-evb = " \
	dmic-demo \
"

IMAGE_INSTALL:append:grinn-astra-1680-sbc = " \
	i2c-utils-optiga-trust \
"
