Development
============



VSCode  
------

* For linux indexing, install **compiledb** to generate **compile-commands-json**

.. code-block:: console 

    pip install compiledb


Build From Source 
-----------------

* Define the variables for compilation 

.. code-block:: console 

    export ARCH=arm64
    export DTC_FLAGS="-@"
    export PATH=~/toradex/toolchain/gcc-aarch64-toradex/bin/:$PATH
    export CROSS_COMPILE=aarch64-none-linux-gnu-

* Use a defconfig and configure the Kernel 


.. code-block:: console 

    make <defconfig>
    make menuconfig 


* Build 

.. code-block:: console 

    make -j4 Image.gz 2>&1 | tee build.log
    make <device-tree-path>.dtb




Kernel Modules
--------------