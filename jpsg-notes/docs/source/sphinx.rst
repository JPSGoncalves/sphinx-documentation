Sphinx
============

Setup and Build
-----------------

To setup sphinx enviroment, do: 

1. Create a python virtual enviroment

.. code-block:: console

    $ python -m venv .venv
    $ source .venv/bin/activate

2. Install sphinx with pip  

.. code-block:: console

    (.venv) $ python -m pip install sphinx

3. Or install from requirements.txt

.. code-block:: console

    (.venv) $ python -m pip install -r requirements.txt

4. Execute **sphinx-quickstart** script for folder named **docs**  

.. code-block:: console

    (.venv) $sphinx-quickstart docs

To build for HTML, execute:

.. code-block:: console

    (.venv) $ sphinx-build -b html docs/source/ docs/build/html


Personal Standard
-----------------

My sphix standard follow close to linux kernel standard. 

1. Titles
::

    ==============
    Document title
    ==============

2. Chapters
::

    Chapters
    ========

3. Sections
::
    
    Section
    -------

4. Subscetions
::

    Subsection
    ~~~~~~~~~~



Documenting C code
------------------

