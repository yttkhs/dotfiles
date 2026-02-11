#!/bin/bash

set -e

echo "==================================="
echo "   Prezto Setup"
echo "==================================="

if [[ ! -d ~/.zprezto ]]; then
    echo "Installing Prezto..."
    git clone --recursive https://github.com/sorin-ionescu/prezto.git ~/.zprezto
    echo "Prezto installed"
else
    echo "Prezto already installed, updating..."
    cd ~/.zprezto
    git pull && git submodule sync --recursive && git submodule update --init --recursive
    echo "Prezto updated"
fi

echo "Prezto setup complete!"
