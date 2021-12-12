#!/bin/bash

## Apply patch to NVIDIA driver

# Check if git & OBS is installed.

if [ ! -x /usr/bin/git ] ; then
        command -v wget >/dev/null 2>&1 || { echo >&2 "Please install 'git' with your package manager. Aborting..."; exit 1; }
    else
        echo -e "\n'git' is installed."
fi

if [ ! -x /usr/bin/obs ] ; then
        command -v wget >/dev/null 2>&1 || { echo >&2 "Please install 'OBS' with your package manager. Aborting..."; exit 1; }
    else
        echo -e "\n'OBS' is installed"
fi

# Clone the nvidia-patch

git clone https://github.com/keylase/nvidia-patch

cd nvidia-patch

sudo ./patch-fbc.sh

cd ..

# Build the NvFBC plugin

git clone https://gitlab.com/fzwoch/obs-nvfbc

cd obs-nvfbc

meson build
ninja -C build

# Create the path to install plugin to

sudo mkdir -p /.config/obs-studio/plugins/nvfbc/bin/64bit/

# Copy the compiled .so file to the just-created path.

cd build
cp nvfbc.so /.config/obs-studio/plugins/nvfbc/bin/64bit/