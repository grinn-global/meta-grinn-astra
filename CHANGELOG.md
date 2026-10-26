# [4.3.0]

## Added
- Waveshare 10.1" DSI panel overlay on `grinn-astra-2619-sbc`

## Fixed
- Corrupted rootfs after USB flashing of `grinn-astra-1680-platform` images with
  more than 4 GiB of rootfs data

# [4.2.0]

## Added
- 2 GB RAM variant of `grinn-astra-2619-sbc` (`kas/ram-2gb.yml`)
- AP12612X M.2 Wi-Fi card on `grinn-astra-1680-sbc` and `grinn-astra-2619-sbc`
- `grinn-astra-2619-som-usb` and `grinn-astra-2619-som-xspi-usb` USB boot
  images for all AstraSOM-261x boards

## Changed
- USB flashing of `grinn-astra-2619-sbc` images requires `grinn-astra-update` v4.2.0
  or newer; use `grinn-astra-update` v4.0.0 for 4.1.0 and older images

## Removed
- `grinn-astra-2619-sbc-usb`, replaced by `grinn-astra-2619-som-usb`
- SWUpdate integration and rescue mode

# [4.1.0]

## Added
- `grinn-astra-2619-sbc` revision C support
- CAN0 on `grinn-astra-2619-sbc`
- PWM6 and PWM7 on the `grinn-astra-2619-sbc` 40-pin header
- SD card image generation for `sl2619-coralboard`

## Changed
- Update `grinn-astra-2619-sbc` preboot binaries: runtime DDR4 topology
  detection, user button as the wakeup source
- Rename 40-pin header GPIO lines to `40PIN_GPIOx` (BCM numbering) on
  `grinn-astra-1680-sbc` and `grinn-astra-2619-sbc`

## Removed
- `grinn-astra-2619-sbc` revision A support

## Fixed
- XSPI pinmux conflicting with 40-pin header GPIOs on `grinn-astra-2619-sbc`
- `astra-update` failure caused by missing `manifest.yml` in
  `grinn-astra-261x` bootloader images

# [4.0.0]

## Changed
- Bump `meta-synaptics` to v2.5.0

# [3.2.0]

## Added
- Kas configuration for building demos

## Changed
- Move camera power and LED GPIO control into the kernel drivers

## Fixed
- Bluetooth HCI UART configuration on `grinn-astra-2619-sbc`

# [3.1.0]

## Added
- Support for `grinn-astra-2619-sbc-usb`
- USB flashing of `grinn-astra-2619-sbc` images through the `astra-update` tool

## Changed
- Bump `meta-deepx-m1`: dx-rt v3.3.2, dx-driver v2.4.1, dx-stream v3.0.1
- Take netboot configuration from `meta-grinn-common-netboot`
- Update `grinn-astra-2619-sbc` preboot to v1.5.0
- Switch to latest `libgpiod` version
- Move OV5647 CSI camera device-tree configuration on `grinn-astra-2619-sbc`
  into a separate overlay and apply it by default

## Fixed
- `image-sensor-start.sh` demo pipeline on `grinn-astra-2619-sbc`
- `/proc/vsi` TOCTOU race between vvcam modules on `grinn-astra-1680-platform`

# [3.0.0]

## Added
- Support for `sl2619-coralboard`
- I2C0, I2S3, SPI3 and UART5 on the `grinn-astra-2619-sbc` 40-pin header

## Changed
- Bump `meta-synaptics` to v2.4.0
- Switch Qt to version 6
- Move netboot support to an external repository

## Fixed
- Mirrored CSI camera image on SL1680
- NetworkManager sysvinit script conflict on systemd

# [2.1.0]

## Added
- Support for `grinn-astra-2619-sbc`
- Python tools for out-of-the-box application development

## Changed
- Enable virtualization for OOBE builds only (via kas yml)

## Fixed
- Inability to enter sleep on `grinn-astra-1680-sbc`

# [2.0.0]

## Changed
- Bump `meta-synaptics` to v2.3.0

# [1.0.1]

## Fixed
- Inability to generate SWUpdate bundle

# [1.0.0]

Initial, SDK v2.2.0 based release.

## Added
- Support for `grinn-astra-1680-ada`, `grinn-astra-1680-sbc`
- Netboot support (`meta-grinn-astra-netboot`)
