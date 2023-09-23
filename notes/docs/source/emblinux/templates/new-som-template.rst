SOM TEMPLATE 
------------


This file describes the basic info that is needed to know to work with a 
new System on Chip or System on Module.

 

SOC - CPU
--------
* Family 
* Clock: Clock Tree Diagram, Main Clock Value, Clock Controller
* Number of Cores 
* 32 bit or 64 bit 
* Power Supply 
* Power Management 
* Reset Management
* Addres Memory Map Diagram
* Asymetric Cores

SOC - MEMORIES
--------------
* Cache Info: Size, Line
* RAM: Internal SRAM, Max Size, DDRAM Controller, DDRRAM Firmware, Address Space
* FLASH: Size, Internal Flash, Interface, Address Space


SOC - BOOT 
----------
* Boot Flow : Boot ROM --> SPL --> Bootloader --> Linux
* Boot Devices : NAND, MMC, NOR, USB 
* Boot Devices Selection : Boot Pins, Fuses
* Necessary Software for Booting: Boot Rom, ATF, OP-TEE, U-boot SPL, U-boot
* Formating Boot Devices for Booting: FAT, RAW 


SOC - BSP Software 
------------------
* Needed FirmwareW: DDDR, WiFi, HDMI 
* Non Open Drivers: GPU, NPU
* Linux and U-boot Support
* Yocto Support
* Tools: Factory Programing, Boot Image Creation, Debugging 
* Factory Progammig: USB, UART, DFU, SDP, FASTBOOT
* Boot Container Generation

SOM - POWER 
------------
* Regulators 
* LDO
* Regulator Enable

SOM - RAM and FLASH 
-------------------
* Size 
* MMC, NAND 
* DDR4 2 bits 


SOM - HW INTERFACES
-------------------
* Pins , SDIO, PCI, I2C, SPI, GPIO, HDMI, DSI, CSI, Parallel, USB, Serial

SOM - Periphals 
----------------
* Sensors 
* Codecs 
* Buttons 
* Serial Debug 



SOM - BLOCK DIAGRAM 
-------------------
* Image