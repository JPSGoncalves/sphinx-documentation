Mastering The Silicon - Baremetal on Modern ARM SOC from Reset to SMP
=====================================================================

This a road for me to learn more deeply low level programming on a modern ARM SOC including arm 
assemby programming, boot, multi processors, mmu, interrupts, uboot, linux and rust.


=======================================
Enviroment Setup 
=======================================

Create a virtual enviroment for python3 (**\>=v3.8**). After that,
use pip to install project dependencies from the **requirements.txt** file located
on root folder of the project.

.. code-block: console 
(.venv) $ pip install requirements.txt

=======================================
Building Documentation 
=======================================

To create book documentation in HTML execute:
.. code-block: console 
(.venv) $ sphinx-build -b html docs/source/ docs/build/html