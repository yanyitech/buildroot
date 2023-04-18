# Buildroot for Rockchip Cool Pi 4B & CM5 Board



## Forum

https://forum.cool-pi.com



## Wiki

https://wiki.cool-pi.com



## How to compile buildroot

`make coolpi4_defconfig`

`make -j 8`



## Create boot card for loading

Buildroot prepares a bootable "coolpi-sdcard.img" image in the output/images/
directory, ready to be flashed into the SD card:

`$ sudo dd if=output/images/coolpi-sdcard.img of=/dev/<sd-card-device>; sync`

Then insert the SD card into the coolpi 4b and boot the board.