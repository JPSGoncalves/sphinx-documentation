U-boot Bootloader
=================



Device Tree 
-----------

U-boot device tree is the same as with linux and need to be synced with linux most of the time. 
However, U-boot can also add its own things. The pattern to add a new dts or dtsi file for u-boot only is: 
<SOC>-u-boot.dtsi 
<SOM>-u-boot.dtsi
<BOARD>-u-boot.dtsi 

The names must be the same as linux dtsi/dts file.

U-boot can modify the device tree on runtime (Live Device Tree).

SPL 
---

The banner is printed on function **preloader_console_init**. Generally, this function seems 
to be called on board initialization of SPL.

Functions with **_f** suffix are pre rellocation or before DDRAM init. The ones with **_r** are after 
rellocation.

For device tree support, you need device tree support in spl and 
also enable devices node for spl using **u-boot,dm-spl** or **boot-pre-ram**.

After assembly initialization, the first function called is **low_level_init** or **board_init_f**. 
After the functions that come are **arch_init**, **board_init**, **spl_init**, ddram init and them **board_init_r**.

The function **spl_init** call **spl_common_init**. It is also responsible for device  tree initialization, so bind and probing devices
also after that finding and loading bootables devices.

SPD and FASTBOOT
----------------

This are protocol to talk to SPL/U-BOOT to download files for booting. 
SDP is the protocol used by IMX BootROM. FASTBOOT is the protocol used by android. 
There tools from a PC that can talk to them, one of them is uuu and also imx_usb_loader.

SDP has support in SPL, so you can download data with even if SOC is not an IMX using an USB PORT. For USB, you need usb gaget support and also SDP USB 
function support.

