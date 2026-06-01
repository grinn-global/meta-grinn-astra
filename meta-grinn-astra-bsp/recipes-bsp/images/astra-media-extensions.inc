IMAGE_INSTALL:append = " \
	gstreamer1.0-python \
	python3-modules \
	python3-pip \
	python3-venv \
"

IMAGE_INSTALL:append:grinn-astra-1680-platform = " \
	image-sensor-demo \
	networkmanager-nmtui \
	terrasat-modem \
"

IMAGE_INSTALL:append:grinn-astra-1680-ada = " \
	hdmi-rx-demo \
"

IMAGE_INSTALL:append:grinn-astra-1680-sbc = " \
	i2c-utils-optiga-trust \
"
