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