Arm 32 bit Assembly
=================================

Compiling and Linking Assembly
------------------------------

.. code-block:: console

    arm-buildroot-linux-gnueabihf-gcc  -c hello.s -o hello.o
    arm-buildroot-linux-gnueabihf-gcc  -c globalvar.s -o globalvar.o
    arm-buildroot-linux-gnueabihf-gcc  hello.o globalvar.o -o test


To build without linking to C std lib by default use **-nostdlib** option 

.. code-block:: console

    arm-none-linux-gnueabihf-gcc -nostdlib gdb_training.s -o gdb_training

For debugging, build with **-g**, **-g3** options 

.. code-block:: console

    arm-none-linux-gnueabihf-gcc -g3 gdb_training.s -o gdb_training

Binarie Utilities 
-----------------

Get basic info on binary file 


.. code-block:: console

    file /path/to/file


Debug with GDB 
--------------

https://www.youtube.com/watch?v=mm0b_H0KIRw
https://www.youtube.com/watch?v=m4agpY_w2y8

GEF - GDB Enchanced https://hugsy.github.io/gef/

To debug arm code on **x86**, use **gdb-multiarch**.


Using **GEF** GDB to debug with quemu using arm 

.. code-block:: console
    
    gdb-multiarch gdb_training
    #inside gef prompt 
    gef > set arch arm 
    gef > gef-remote --qemu-user localhost 1234 
    #on other terminal 
    qemu-arm -L ~/workspace/toolchain/gcc-arm-none-linux/ -g 1234 gdb_training


Syntax
------

.. code-block::console

        .data 
    str: .asciz "Hello World %d\n" @ Define a null-terminated string 
        .text 
        .global main 
    main: 
        stmfd sp!,{lr} @ push return address onto stack 
        ldr r0, =str @ load pointer to format string 
        ldr r2, =my_global @ load pointer to global variable
        ldr r1, [r2] @ load value to r1  
        bl printf @ printf("Hello World\n"); 
        mov r0, @ move return code into r0 
        ldmfd sp!,{lr} @ pop return address from stack 
        mov pc, lr @ return from main

Declaring Variables
-------------------


Pointers
--------



Calling Functions
-------------------


Bulding with GCC
----------------

To build whithout GCC linking to the C std lib, use **-nostdlib** option

   

