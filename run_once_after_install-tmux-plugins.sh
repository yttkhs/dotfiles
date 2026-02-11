#!/bin/bash

set -e

echo "==================================="
echo "   tmux Plugin Manager Setup"
echo "==================================="

TPM_DIR="$HOME/.tmux/plugins/tpm"

if [[ ! -d "$TPM_DIR" ]]; then
    echo "Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
    echo "TPM installed"
else
    echo "TPM already installed"
fi

# Install plugins if tmux is available
if command -v tmux &> /dev/null && [[ -f "$TPM_DIR/bin/install_plugins" ]]; then
    echo "Installing tmux plugins..."
    "$TPM_DIR/bin/install_plugins"
    echo "tmux plugins installed"
fi

echo "tmux plugin setup complete!"
