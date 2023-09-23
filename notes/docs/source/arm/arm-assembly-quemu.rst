QUEMU Arm Use and Setup
=======================


Useful links 

https://gist.github.com/luk6xff/9f8d2520530a823944355e59343eadc1
https://azeria-labs.com/arm-on-x86-qemu-user/
https://hackmd.io/@MarconiJiang/qemu_beginner
https://www.prosysopc.com/blog/qemu-arm-test-setup/
https://jasonblog.github.io/note/arm_emulation/hello_world_for_bare_metal_arm_using_qemu.html
https://jasonblog.github.io/note/arm_emulation/index.html
https://github.com/cirosantilli/aarch64-bare-metal-qemu/tree/27537fb1dd0c27d6d91516bf4fc7e1d9564f5a40
https://github.com/umanovskis/baremetal-arm/tree/master
https://balau82.wordpress.com/2010/02/28/hello-world-for-bare-metal-arm-using-qemu/
https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/821854273/Running+Bare+Metal+Applications+on+QEMU
https://stackoverflow.com/questions/38914019/how-to-make-bare-metal-arm-programs-and-run-them-on-qemu
https://github.com/freedomtan/aarch64-bare-metal-qemu/tree/2ae937a2b106b43bfca49eec49359b3e30eac1b1
https://rechtzeit.wordpress.com/2012/06/16/a-simple-bare-metal-program-arm/
https://www.peterelst.com/configuring-gdb-for-debugging-arm-applications/
https://surma.dev/postits/arm64/

Do not forget to compile the binaries for the ARM Arch.

Ubuntu
-------

Necessary packages:
* **quemu-user** 

Enable running code from diferent arch on arm-on-x86 for user space process

* **qemu-user-static**

Run static linked binaries for user space process

* **qemu-aarch64** 

Run aarch64 dynamic linked binaries for user space process

* **qemu-arm** 

Run aarch32 dynamic linked binaries for user space process

* **qemu-system-arm** 

For emulating any arm system : baremetal, bootloader etc.

Running Binaries with Quemu
---------------------------

**-L** option is for passing compiler dynamic linker absolute path for quemu

.. code-block:: console 

   qemu-aarch64 -L /usr/aarch64-linux-gnu ./hello_bin_dynamic_link
   qemu-arm -L /usr/arm-linux-gnueabihf ./hello32_bin_dynamic_link

Baremetal with Quemu
--------------------

Using quemu virtual machine **virt**: 

.. code-block:: console 

   qemu-system-aarch64 -M virt -cpu cortex-a57 -nographic -kernel test64.elf -serial mon:stdio

Using machine **vexpress-a9**

.. code-block:: console 

   qemu-system-arm -M vexpress-a9 -m 32M -no-reboot -nographic -monitor telnet:127.0.0.1:1234,server,nowait -kernel first-hang.bin


Examples 
--------

Simple armv7 run whre **CROSS_CC_ARMV7** is the compiler folder path 
(eg. **/home/jpaulosg/opt/toolchains/armv7-eabihf--glibc--stable-2022.08-1**).

.. code-block:: console
   
   qemu-arm -L $CROSS_CC_ARMV7/arm-buildroot-linux-gnueabihf/sysroot  hello-arm

Debug
-----

* Install **gdb-multiarch**.
* Compile code with Debug Symbols **-g**, **-g3**
* Run quemu on a process exporting a PORT to GDB to connect 
* Run GDB connect to QUEMU Port 

.. code-block:: console
   
   sudo apt install gdb-multiarch
   arm-linux-gnueabihf-gcc -ggdb3 -o hello32 hello32.c
   qemu-arm -L /usr/arm-linux-gnueabihf -g 1234 ./hello32-static
   gdb-multiarch -q --nh -ex 'set architecture arm' -ex 'file hello32-static' -ex 'target remote localhost:1234' -ex 'layout split' -ex 'layout regs'


