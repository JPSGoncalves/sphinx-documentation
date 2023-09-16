Arm 32 bit Assembly
=================================

Compiling and Linking Assembly
------------------------------

.. code-block:: console

    arm-buildroot-linux-gnueabihf-gcc  -c hello.s -o hello.o
    arm-buildroot-linux-gnueabihf-gcc  -c globalvar.s -o globalvar.o
    arm-buildroot-linux-gnueabihf-gcc  hello.o globalvar.o -o test


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