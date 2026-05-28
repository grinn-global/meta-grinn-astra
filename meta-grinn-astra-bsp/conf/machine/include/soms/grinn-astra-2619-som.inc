#@TYPE: Machine
#@NAME: Grinn Astra 2619 SOM
#@DESCRIPTION: Machine configuration for the Grinn Astra 2619

require conf/machine/sl2619.conf

MACHINEOVERRIDES =. "sl2619:grinn-astra-261x-som:grinn-astra-2619-som:"

# SoM marker for native recipes — MACHINEOVERRIDES is cleared by native.bbclass.
GRINN_ASTRA_SOM = "grinn-astra-2619-som"
