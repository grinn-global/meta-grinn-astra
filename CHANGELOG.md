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
