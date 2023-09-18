U-boot Bootloader
=================


Builidng U-boot and Makefile Control 
-------------------------------------

The steps to build u-boot are:

1. Get a cross compiler

Many at:
https://toolchains.bootlin.com/

2. Export the cross compiler prefix in **CROSS-COMPILE** env variable

.. code-block:: console

    export CROSS-COMPILE=arm-none-linux-

3. Set U-boot output build directory in **KBUILD_OUTPUT**

.. code-block:: console

    export KBUILD_OUTPUT=build/$BOARD_NAME


4. Configure U-boot 

Configure U-boot for a board. Use **mrproper** to clean all configs. 

.. code-block:: console

   make stm32mp15_defconfig 
   make stm32mp15_trusted_defconfig
   make stm32mp15_basic_defconfig 
     

5. Build

.. code-block:: console

   make all


6. Creating a Defconfig File

.. code-block:: console

   make savedefconfig 

6. Porting an OLD config to a NEW version

.. code-block:: console

   make oldconfig  # will prompt for new values
   make olddefconfig # will set all new values to default 

7. Generate U-boot Initial Env 

.. code-block:: console

   make u-boot-initial-env


Configure Networking
--------------------

* STATIC 

.. code-block:: console 

    setenv ipaddr <EMBEDDED TARGET IP>
    setenv serverip <HOST IP> 
    ping $serverip


Commands Examples 
-----------------

* **tftpboot**

* **ping** 

* **ums (usb mas storage)**


* **printenv**

* **setenv**

* **ls**


Tips and Helpers 
----------------

* To test USB Gadget, use **ums** (Usb Mass Storage). It can mount MMC in PC Host. 


Device Tree 
-----------

U-boot device tree is the same as with linux and need to be synced with linux most of the time. 
However, U-boot can also add its own things. The pattern to add a new dts or dtsi file for u-boot only is: 
<SOC>-u-boot.dtsi 
<SOM>-u-boot.dtsi
<BOARD>-u-boot.dtsi 

The names must be the same as linux dtsi/dts file.

U-boot can modify the device tree on runtime - **Live Device Tree**. This is useful for 
dynamic hardware reconfiguration. Example: Add a new sensor with an eeprom that has its overlay 
on the eeprom. U-boot can read this overlay from the eeprom and apply it to device tree before 
boot linux.

Source Code Info  
----------------

The banner is printed on function **preloader_console_init**. Generally, this function seems 
to be called on board initialization of SPL.

Functions with **_f** suffix are pre rellocation or before DDRAM init. The ones with **_r** are after 
rellocation.

For device tree support in SPL  **u-boot,dm-spl** or **boot-pre-ram** in nodes.

After assembly initialization, the first function called is **low_level_init** or **board_init_f**. 
After the functions that come are **arch_init**, **board_init**, **spl_init**, ddram init and them **board_init_r**.

The function **spl_init** call **spl_common_init**. It is also responsible for device  tree initialization, so bind and probing devices
also after that finding and loading bootables devices.

In **common/boarf_f.c** there is a table of all the initialization routines U-boot call before 
relocation. 

In **common/boarf_r.c** there is a table of all the initialization routines U-boot call after
relocation. 

In SPL, most board implement their own **boarf_f.c**.


Facotry Programming - SPD and FASTBOOT
-------------------------------------


This are protocol to talk to SPL/U-BOOT to download files for booting. 
SDP is the protocol used by IMX BootROM. FASTBOOT is the protocol used by android. 
There tools from a PC that can talk to them, one of them is uuu and also imx_usb_loader.

SDP has support in SPL, so you can download data with even if SOC is not an IMX using an USB PORT.

For USB, you need usb gaget support and also SDP USB function support.



Creating Boot Script for Distro Boot 
------------------------------------

To get the text from a **boot.src** that is a binary script, do:

.. code-block:: console
   dd if=boot.scr of=boot.script bs=72 skip=1


To create a **boot.src** from a boot text script, do:

.. code-block:: console
   mkimage -c none -A arm -T script -d boot.script boot.scr

