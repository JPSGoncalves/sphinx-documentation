SOC TEMPLATE 
------------


This file describes the basic info that is needed to know to work with a 
new System on Chip or System on Module.

 

CPU
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
* IRQS



Memory
--------------
* Cache Info: Size, Line
* RAM: Internal SRAM, Max Size, DDRAM Controller, DDRRAM Firmware, Address Space
* FLASH: Size, Internal Flash, Interface, Address Space

Power 
-----

Boot
----------
* Boot Flow : Boot ROM --> SPL --> Bootloader --> Linux
* Boot Devices : NAND, MMC, NOR, USB 
* Boot Devices Selection : Boot Pins, Fuses
* Necessary Software for Booting: Boot Rom, ATF, OP-TEE, U-boot SPL, U-boot
* Formating Boot Devices for Booting: FAT, RAW 


Interfaces 
----------


BSP Software 
------------
* Needed Firmware: DDDR, WiFi, HDMI 
* Non Open Drivers: GPU, NPU
* Linux and U-boot Support
* Yocto Support
* Tools: Factory Programing, Boot Image Creation, Debugging 
* Factory Progammig Tools: USB, UART, DFU, SDP, FASTBOOT
* Boot Container Generation


Firmwares 
---------


BSP - Audio 
-----------



BSP - Display 
-------


BSP - Video 
-----


BSP - USB 
---


BSP - Wireless 
--------


BSP - Ethernet 
--------






