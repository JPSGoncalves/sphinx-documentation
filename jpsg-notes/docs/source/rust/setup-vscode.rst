Configuring VSCode for Rust Development
=======================================

Useful links for vscode configuration:
https://code.visualstudio.com/docs/languages/rust
https://users.rust-lang.org/t/setting-up-rust-with-vs-code/76907
https://users.rust-lang.org/t/vscode-gdb-rust-analyzer-pretty-printing/73705

Steps:

1. Install Rust on System 

Use link https://www.rust-lang.org/tools/install

2. Install VSCode Extensions

* Rust Analyzer
* Code Runner 
* Better TOML
* Code LLDB 
* Crates

3. Configure VSCode Settings

* Enable/Disable Inlay Hints in **Settings** \> **Editor** \> **Inlay Hints**
* Disable Auto Importer in **Settings** \> **Rust Analyzer** \> **Completition** \> **Autoimport**
* Configure to save file after delay in **Settings** \> **Files** \> **AutoSave**
* Use Clippy as linter in **Settings** \> **Rust Analyzer** \> **Check on Save**
* Enable formatter on save on **Settings** \> **Editor** \> **Format on Save**
* Configure Code Runner to Call Cargo so set **Settings** \> **Code Runner** \> **Executor Map** to **"rust":"cargo run # $fileName"**



4. Debugging 

* Enable Breakpoints Anywhere in **Settings** \> **Debug**
* Create a **launch-json**


Example workspace **settings.json**

.. code-block:: json 

    {
        "rust-analyzer.completion.autoimport.enable": false,
        "rust-analyzer.check.command": "clippy",
        "code-runner.executorMap": {
            "rust": "cargo run $fileName",
        },
        "editor.formatOnSave": true,
        "files.autoSave": "afterDelay",
        "files.autoSaveDelay": 5000,
        "debug.allowBreakpointsEverywhere": true
    }

Example workspace **launch.json** for a project called samples using LLDB

.. code-block:: json 

    {
        // Use IntelliSense to learn about possible attributes.
        // Hover to view descriptions of existing attributes.
        // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
        "version": "0.2.0",
        "configurations": [
            {
                "type": "lldb",
                "request": "launch",
                "name": "samples - binary debug",
                "cargo": {
                    "args": [
                        "build",
                        "--bin=samples",
                        "--package=samples"
                    ],
                    "filter": {
                        "name": "samples",
                        "kind": "bin"
                    }
                },
                "args": [],
                "cwd": "${workspaceFolder}"
            },
            {
                "type": "lldb",
                "request": "launch",
                "name": "samples - unit tests debug",
                "cargo": {
                    "args": [
                        "test",
                        "--no-run",
                        "--bin=samples",
                        "--package=samples"
                    ],
                    "filter": {
                        "name": "samples",
                        "kind": "bin"
                    }
                },
                "args": [],
                "cwd": "${workspaceFolder}"
            }
        ]
        }