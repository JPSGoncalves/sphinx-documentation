Verdin-IMX8MM
-------------

Specifications 
~~~~~~~~~~~~~~


~~~~~~~~~~~~~~~~
* CPU
  
    Cortex A53 (1 to 4 Cores) and Cortex M4 (1)

* RAM
  
    TCM (Tigh Coupled memory for M4 only) - 256Kb  
    DDR4 (Toradex) - 1GB to 2GB 
    OCRAM - 256Kb

* ROM

    eMMC - 4GB to 16GB
    EEPROM - 2Kb 

* Power
    3.1V to 5V 

Hardware Details
~~~~~~~~~~~~~~~~


Versions 
~~~~~~~~


SPL 
~~~

**v2022.07_toradex_downstream**

Summary:
    SPL run from TCML starting at 0x7E1000. The BSS section is put 
    on OCRAM (0x910000) limited on 8KB and also the STACK(0x920000).    
    Malloc is also put on OCRAM (0x930000) limited to 65KB (0x10000) before relocation (?).
    Dynamic memory allocation is put DDR4 (0x42200000) after it is initialized/relocated with 512KB (0x2000000).

* SPL BASE ADDRES: where it will start running
    Uboot Config - CONFIG_SPL_TEXT_BASE
    Value  - 0x7E1000
    Memory - TCML (max 128KB)

* SPL MAX SIZE: the binary size of spl in memory 
   Uboot Config - CONFIG_SPL_MAX_SIZE (**include/configs/verdin-imx8mm.h**)
   Value        - 148Kb
   Notes: It seems the linker script is using this variable as size of SRAM section where SPL is put.
   
   Uboot Config - CONFIG_SPL_SIZE_LIMIT
   Value - 0 
   Notes: This seems to be the real binary size of SPL. If this value is 0, it is ignored.
          Maybe this is the real size of SPL.    



* SPL MALLOC CONFIGURATION: how malloc is organiz on SPL 
    Before Relocation 
    Uboot Configs - CONFIG_MALLOC_F_ADDR, CCONFIG_SPL_SYS_MALLOC_F_LEN, CONFIG_SYS_SPL_MALLOC_START, CONFIG_SYS_SPL_MALLOC_SIZE




U-boot 
~~~~~~

**v2022.07_toradex_downstream**


Linux 
~~~~~