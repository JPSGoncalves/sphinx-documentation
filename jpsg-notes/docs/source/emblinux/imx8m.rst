IMX8M SOC
=========


Boot Container 
--------------

Need to boot the SOC. The files for it are: 

* **Arm Trusted Firmware (ATF)**: 
    * bl31 
* **SPL and U-boot**: 
    * u-boot-spl.bin: u-boot SPL binary
    * u-boot-nodtb.bin: u-boot binary without device tree
    * <board-device-tree>.dtb: u-boot device tree for the board 
* **DDR Training Fimrware** 
    * lpddr4_pmu_train_1d_imem.bin 
    * lpddr4_pmu_train_1d_dmem.bin 
    * lpddr4_pmu_train_2d_imem.bin
    * lpddr4_pmu_train_2d_dmem.bin

To create the boot container use nxp the **imx-mkimage** tool (https://github.com/nxp-imx/imx-mkimage.git).

Example: 

.. code-block:: console 

    make SOC=IMX8MM flash-evk


For Toradex Modules

.. code-block:: console 

    
    make SOC=IMX8MM dtbs=imx8mm-verdin-wifi-dev.dtb flash_evk_emmc_fastboot




Flashing Tool - UUU 
-------------------


U-Boot USB Support 
------------------

* USB device controller for IMX8M is the **ci_udc**.

* For USB Gadget function in SPL we need to enable USB Host too for **usb_lowlevel_init**. This function
is implemented in the usb controller driver and not on the usb device controller driver.

* For USB Controller driver in SPL the ehci controller need the DM (Driver Model) support with config **CONFIG_SPL_DM_USB** set. 