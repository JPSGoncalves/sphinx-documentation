All notes
=========



Linux Ubuntu
------------

* Change Swap Size 

    1. Turn off all running swap processes
    2. Resize swap
    3. CHMOD swap
    4. Make file usable as swap 
    5. Active the swap file

.. code-block:: console 

    swapoff -a
    fallocate -l 16G /swapfile
    chmod 600 /swapfile
    swap mkswap /swapfile
    swapon /swapfile