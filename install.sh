#!/bin/bash
set -euo pipefail

# install.sh - Install tv-control scripts
# Usage: sudo ./install.sh [install_dir]

INSTALL_DIR="${1:-/usr/local/bin}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Validate install directory
if [[ -z "$INSTALL_DIR" ]]; then
    echo "Error: Install directory cannot be empty."
    exit 1
fi

# Check if running as root for system-wide install
if [[ "$INSTALL_DIR" == /usr* ]] && [[ $EUID -ne 0 ]]; then
    echo "Error: System-wide install requires root. Run with sudo."
    exit 1
fi

# Create install directory if it doesn't exist
if [[ ! -d "$INSTALL_DIR" ]]; then
    echo "Creating directory: $INSTALL_DIR"
    mkdir -p "$INSTALL_DIR"
fi

echo "Installing tv-control to $INSTALL_DIR..."

# Copy scripts with error handling
for script in tv-control.sh tvon.sh tvoff.sh tvsource.sh tvstat.sh; do
    if [[ ! -f "$SCRIPT_DIR/$script" ]]; then
        echo "Error: $script not found in $SCRIPT_DIR"
        exit 1
    fi
    cp "$SCRIPT_DIR/$script" "$INSTALL_DIR/$script"
    chmod +x "$INSTALL_DIR/$script"
    echo "  Installed: $INSTALL_DIR/$script"
done

echo ""
echo "Installation complete!"
echo ""
echo "Usage:"
echo "  tvon       - Turn TV on"
echo "  tvoff      - Turn TV off"
echo "  tvstat     - Check TV status"
echo "  tvsource   - Switch TV source"
echo "  tv-control - Interactive menu"
echo ""
echo "Requirements:"
echo "  - cec-client (install with: sudo apt-get install cec-utils)"
echo "  - whiptail (install with: sudo apt-get install whiptail)"
