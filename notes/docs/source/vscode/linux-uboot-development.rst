Configuring VSCode for Linux or U-Boot Development
==================================================

Useful links for vscode configuration:
https://github.com/amezin/vscode-linux-kernel
https://github.com/neilchennc/vscode-linux-kernel


The **compile_commands.json** can be generate with **bear** or other generator.

* Generate DB for host with make 

.. code-block:: console 

    bear make all

* Generate DB for target using C **cross-compiler** with make 

.. code-block:: console 

    bear --use-cc $CROSS_CC_ABSOLUTE_PATH make all


Example workspace **settings.json**

.. code-block:: json 

    {
        "files.exclude": {
            "**/.*.*.cmd": true,
            "**/.*.d": true,
            "**/.*.S": true
        },
        "[c]": {
            "editor.detectIndentation": false,
            "editor.tabSize": 8,
            "editor.insertSpaces": false,
            "editor.rulers": [80,100]
        },
        "files.associations": {
            "*.h": "c"
        }
    }


Example workspace **c_cpp_properties.json**:

.. code-block:: json 

    {
        "configurations": [
            {
                "name": "Linux or U-Boot ARM",
                "cStandard": "c11",
                "intelliSenseMode": "gcc-arm",
                "compileCommands": "${workspaceFolder}/compile_commands.json"
                "compilerPath": "Must Define",
            },

            {
                "name": "Linux or U-Boot ARM64",
                "cStandard": "c11",
                "intelliSenseMode": "gcc-arm64",
                "compileCommands": "${workspaceFolder}/compile_commands.json"
                "compilerPath": "Must Define",
            },

            {
                "name": "Linux x86",
                "cStandard": "c11",
                "intelliSenseMode": "gcc-x86",
                "compileCommands": "${workspaceFolder}/compile_commands.json"
                "compilerPath": "Must Define",
            },
        ],
        "version": 4
    }