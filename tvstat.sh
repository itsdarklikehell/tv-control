#!/bin/bash
set -euo pipefail

# tvstat.sh - Get TV status via HDMI-CEC
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
exec "$SCRIPT_DIR/tv-control.sh" status
