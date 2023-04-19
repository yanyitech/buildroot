Rockchip Cool pi board
---------------------

To build a minimal weston support for this board:

$ make coolpi4_defconfig
$ make -j 8

Buildroot prepares a bootable "coolpi-sdcard.img" image in the output/images/
directory, ready to be flashed into the SD card:

$ sudo dd if=output/images/coolpi-sdcard.img of=/dev/<sd-card-device>; sync

Then insert the SD card into the coolpi 4b and boot the board.
