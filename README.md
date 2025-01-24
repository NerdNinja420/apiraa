
# Virtual Environment Path Copier

A Rust program that automatically finds the `activate` script of a virtual environment and copies its path to the system clipboard. This makes it easy to activate your virtual environment by simply pasting the command into your terminal.

## Features

- **Automatic Virtual Environment Detection**: Scans directories for the `bin` folder and searches for the `activate` script in your virtual environments.
- **Clipboard Integration**: Copies the full path of the `activate` script to your system clipboard, ready to be pasted into the terminal.
- **Cross-Platform**: Uses `wl-copy` for clipboard manipulation, designed for Wayland systems (make sure `wl-copy` is installed).

## How It Works

1. The program recursively searches for `bin` directories.
2. It then looks for the `activate` script in those directories.
3. Once the script is found, its path is copied to the system clipboard.
4. The program outputs the command `source <path-to-activate>` for easy usage.

## Installation

To compile and run this program, you need Rust installed on your system.

### 1. Install Rust

If you don't have Rust installed yet, you can install it from [https://rust-lang.org/](https://rust-lang.org/).

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

