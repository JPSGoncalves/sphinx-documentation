JPSG Personal Notes
=====================================================================

This project is just a personal note taker to put everything i think 
is important or just to remember thing for development 
as embedded software developer. Also, i will use it to learn more about sphinx 
and how to write better documentation.


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

To create documentation in HTML execute:
.. code-block: console 
(.venv) $ sphinx-build -b html docs/source/ docs/build/html