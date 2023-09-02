
First Projects for My Blog and Also Learn Linux Kernel/Device Driver Development 
--------------------------------------------------------------------------------

I want to create a blog to show my skills a kernel developer

GOALS
~~~~~~
**Initial Ideas**  

* Develop simple LED or GPIO Button Driver from Scratch to LED and INPUT Framework
* Develop I2C RTC driver from scratch to REGMAP and RTC Framework
* Develop I2C/SPI Sensor driver from scratch to REGMAP and IIO Framework
* Configure MAX9854 as a codec and play audio using tools and code
* Develop MAX9854 codec driver from scratch with ASOC (or buy another arduino code) 
* Configure OV7670 camera and use it to get images using tools and code
* Develop OV7670 camera driver from scratch V4L2 
* Develop a driver on host PC as usb audios class and STM32MP157 board as usb audio gadget (find how)
* Develop a driver on host PC as usb video class and STM32MP157 board as usb video gadget (find how)

**The Goals**
* Learn the basics of kernel programming: kernel api and patterns
    syncronization, io memory maping, delayed work, interrupts, dma, memory allocation, device tree use
    in drivers,

* Learn the basics of kernel frameworks: kernel api, device tree, userspace api and tools
    GPIO, I2C, SPI, INPUT, LED, RTC, REGMAP, IIO, ALSA, V4L2, REGULATOR, CLOCK, PINCTRL, IRQ

* Learn how audio works on Linux 

* Leanr how video works on Linux 

* Lean USB Protocol: usb host, usb otg, ehci , simple usb drivers on linux 
    HID, UVD, DFU 


STEPS
~~~~~~~~~~~~~~~~

* CURRENT: 
     Enviroment SETUP
     Estimation: Two months 
     Start Date: 02/09/2023


Enviroment SETUP 
~~~~~~~~~~~~~~~~


What i need? 
* An enviroment where i can boot a new linux kernel and also device tree easily. 
* An enviroment where i can boot u-boot configuration easy
* Compile the kernel from sources without Yocto 
* Compile U-boot from sources without Yocto 


How ? 

* Boot Container on SD CARD: TF, OPTEE, U-boot etc 
* Linux and Device Tree : TFTP.
* Rootfs: NFS or RAM
* U-boot with FIT image support for overlay
* Configuration on Yocto Layer


What to do ? 

* Get boot overview of STM32157
* Get boot images from diferent media 
* Learn STM32CubeProgrammer tool 
* Create SD card image from scracth 
* Learn how to update only kernel and device tree 

Time: 
* I want to take one to two months on this. 
* Start Date: 03/09/2023


https://wiki.st.com/stm32mpu/wiki/STM32CubeProgrammer
https://wiki.st.com/stm32mpu/wiki/How_to_populate_the_SD_card_with_dd_command
https://wiki.st.com/stm32mpu/wiki/STM32_MPU_Flash_mapping
https://wiki.st.com/stm32mpu/wiki/STM32CubeProgrammer_flashlayout
https://wiki.st.com/stm32mpu/wiki/Boot_chain_overview
https://wiki.st.com/stm32mpu/wiki/How_to_load_U-Boot_with_STM32CubeProgrammer
https://wiki.st.com/stm32mpu/wiki/How_to_manually_update_bootloaders
https://wiki.st.com/stm32mpu/wiki/How_to_compile_the_device_tree_with_the_Developer_Package
https://wiki.st.com/stm32mpu/wiki/How_to_cross-compile_with_the_Developer_Package
https://wiki.st.com/stm32mpu/wiki/How_to_boot_the_kernel_via_TFTP_from_U-Boot






PROJETC 1: Develop simple LED and GPIO Button Driver from Scratch to LED/INPUT Framework
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



PROJETC 2: ASOC with MAX9854 on Linux
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



PROJETC 3: V4L2 with OV7640 on Linux
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


PROJETC 3: RTC with I2C 
~~~~~~~~~~~~~~~~~~~~~~~~