Embedded Linux Development 
==========================

Linux Kernel Development Process 
Booting with U-boot (eMMC, TFTP, etc)
Kernel Boot Parameters
Initram Rootfs
NFS Rootfs 
Cross Compiling and Cross Canadian
Power Management
Over The Air Updates
Userspace Hardware Interface Tools List and How To
Tracing, Debug and Perfomance Tools List  and How To
System Resoruces Monitoring Tools  and How To


Compiling Out of Teee Kernel Module
====================================

**KERNEL_SRC** is the variable that point to an already build Kernel. This name 
is also used by yocto module recipes.

**M** says to KCONFIG that this is an out of tree module and **M** has the absolute 
path to iy.

Before build a kernel module, execute target modules_prepare. More important if 
the Kernel was compiled with a build difectory. 

.. code-block:: console
    make modules_prepare 
    make O=$BUILD_DIRECTORY_PATH modules_prepate


* Makefile for Simple Module 


.. code-block:: console 

    obj-m := hello.o

    SRC ?= $(shell pwd)

    all default: modules

    modules:
        $(MAKE) -C $(KERNEL_SRC) M=$(SRC)

    modules_install:
        $(MAKE) -C $(KERNEL_SRC) M=$(SRC) modules_install

    clean:
        $(MAKE) -C $(KERNEL_SRC) M=$(SRC) clean

    help:
        $(MAKE) -C $(KERNEL_SRC) M=$(SRC) clean



* Install Modules 

Default path for external modules is **/lib/modules/<kernel_release>/extra/**. 
A prefix can be prepend using **INSTALL_MOD_PATH** variable. 

.. code-block:: console
    make modules_install #default path  
    make INSTALL_MOD_PATH=/serv/nfs/rootfs modules_prepate # to /serv/nfs/rootfs/lib/modules/.. path


If is encessary to use **sudo**, remember to pass the enviroment. 

.. code-block:: console
    sudo -E make INSTALL_MOD_PATH=/serv/nfs/rootfs modules_prepate # to /serv/nfs/rootfs/lib/modules/.. path



* Using Yocto SDK to Compile Kernel Modules 

https://stackoverflow.com/questions/31256770/using-populate-sdk-to-include-kernel-headers
https://stackoverflow.com/questions/31256770/using-populate-sdk-to-include-kernel-headers


1. Add **kernel-devsrc** to SDK
.. code-block:: console 
    TOOLCHAIN_TARGET_TASK += "kernel-devsrc"

2. Go to kernel sources modules needed target

.. code-block:: console
    source path/to/sdk/environment-setup-aarch64-linux
        cd -P path/to/sdk/sysroots/aarch64-linux/usr/src/kernel
        # Note the -P argument: kernel is a symlink, in my case:
        # path/to/sdk/sysroots/aarch64-linux/lib/modules/5.4.0-xilinx-v2020.1/build
        make scripts
        make modules_prepare

3. Compile  

.. code-block:: console
    
    export KERNEL_SRC=path/to/sdk/sysroots/aarch64-linux/usr/src/kernel/
    make



Compiling and Applying Device Tree Overlays 
===========================================

For compiling, use **dtc** device tree compilar. Yocto will install 
it on SDK too.

If use **#include** inside dts, we need to use the cpreprocessor and pass the 
**#include** files path 

.. code-block:: console
    cpp -Ipath/to/1 -Ipath/to/2 BBORG_FAN-A000.dts -o BBORG_FAN-A000.preprocessed.dts.

.. code-block:: console
    dtc -@ -I dts -O dtb -o overlay-iniio-crazyjoy.dtb overlay-iniio-crazyjoy.dts

To load overlays we need U-boot. 


Console Log level
=================
https://wiki.st.com/stm32mpu/wiki/Dmesg_and_Linux_kernel_log


To see current loglevel 

.. code-block:: console
    cat /proc/sys/kernel/printk

To change loglevel in runtime 

.. code-block:: console
    echo <loglevel> > /proc/sys/kernel/printk


KCONFIG
=======

In a module MAKEFILE, to add cflags like DEBUG, do 
.. code-block:: console
    obj-m := input-iio-joystick.o
    CFLAGS_input-iio-joystick.o := -DDEBUG

Debug will enable **pr_debug** and **dev_debug** messages.

Device Files
============

To manually create device files, use **mknod** using MAJOR and MINOR of driver. 

.. code-block:: console
    mknod -m 666 /dev/<device_name> c 243 0

The files can be created dynamically by the kernel using **sysfs** api. After that
is possible to use **udev** to load a kernel module automatically for the driver.


Device Drivers
==============

* **Nerver forget to change struct <>_driver name.** 
* **MODULE_DEVICE_ID** will make the module be loaded automaticallyat boot if device is found.



TFTP Boot Setup 
===============

For TFTP boot is need to install and configure 
a TFTP server. If using U-boot as bootloader use
**tftpboot** for getting files over tftp and **ping** to 
check for netowrking setup. Often, the files that go 
on the TFTP server are the **kernel** and also **device tree 
binary (dtb)**. The common distro boot on U-boot also use 
**PXE** booting to boot over tftp.

https://www.systranbox.com/how-to-test-a-tftp-server-in-linux/


How to configure and test TFTP server on Ubuntu

https://elinux.org/TFTP_Boot_and_NFS_Root_Filesystems#NFS_Server

* Install TFTP Server 

.. code-block:: console 

    apt-get install tftpd-hpa tftp

* Getting Help and Debug 

.. code-block:: console 

    man tftpd 
    ps aux | grep tftp 

* Control TFTP Server 

.. code-block:: console 

    service tftpd-hpa start
    service tftpd-hpa restart
    service tftpd-hpa status 
    service tftpd-hpa stop

* TFTP Server Configutation File 
.. code-block:: console

    # /etc/default/tftpd-hpa

    TFTP_USERNAME="nodoby"
    TFTP_DIRECTORY="/srv/tftp"
    TFTP_ADDRESS=":69"
    TFTP_OPTIONS="--secure"

The best way to point multiple setups to point to to  **/srv/tftp** is 
creating a **symbolic** link to it based on another folder. The tftp directory 
must not exist;

.. code-block:: console
    sudo ln -f -s ~/workspace/net/tftp/stm32p1-tftpboot /srv/tftp

The tftp directory also must have the owner to be **nodoby:nogroup**. 

.. code-block:: console

    sudo chown nobody:nogroup /srv/tftp
    sudo chown -h nobody:nogroup /path/to/tftp #for simbolic link owenership




NFS Rootfs Setup 
================


STEPS:

* Enable NFS Rootfs on Kernel Configs  
* Create NFS Server on Host 
* Pass to kernel as boot args **root=/dev/nfs**


How to configure a NFS Server on Ubuntu

https://elinux.org/TFTP_Boot_and_NFS_Root_Filesystems#NFS_Server

* Install NFS Server 

.. code-block:: console 

    apt-get install nfs-kernel-server


* Getting Help 

.. code-block:: console 

    man nfs

* Control NFS Server

.. code-block:: console 

    service nfs-kernel-server start
    service nfs-kernel-server restart
    service nfs-kernel-server status 
    service nfs-kernel-server stop

* NFS Server Configutation File 

Change the **/etc/exports** file with the location and IP 
of the folder that must be exported with NFS.

.. code-block:: console 

    # /etc/exports

    # /etc/exports: the access control list for filesystems which may be exported
    #		to NFS clients.  See exports(5).
    #
    # Example for NFSv2 and NFSv3:
    # /srv/homes       hostname1(rw,sync,no_subtree_check) hostname2(ro,sync,no_subtree_check)
    #
    # Example for NFSv4:
    # /srv/nfs4        gss/krb5i(rw,sync,fsid=0,crossmnt,no_subtree_check)
    # /srv/nfs4/homes  gss/krb5i(rw,sync,no_subtree_check)
    # 
    path/to/share 192.168.1.0/24(rw,sync,no_root_squash,no_subtree_check)
    /srv/nfs4/stm32mp1-rootfs 192.168.1.0/24(rw,sync,no_root_squash,no_subtree_check)

The **/path/to/share** is the directory you want to share.
The IP **192.168.1.0/24** is the address range (CIDR notation) of the allowed clients.
The flags **(rw,sync,no_subtree_check)** specifies the permissions and options for the share.

Using something like **/srv/nfs4/stm32mp1-rootfs** is useful as is possible to create symlinks to it.
With NFS is possible to export many rootfs. 


The nfs directory must have the owner to be **nodoby:nogroup**. 

When booting the kernel with ROOTFS over NFS, does not use the symbolic link path in boot args, but 
use the real filesystem path. If not, the kernel panics.

* Export NFS Directory

.. code-block:: console 

    sudo exportfs -a

* Show Exported Directories

.. code-block:: console 

    showmount -e localhost

* Mouting NFS on clients

.. code-block:: console 

    sudo mount <server_ip>:<shared_directory> /mount/point