#!/bin/bash
set -euo pipefail

# tvoff.sh - Turn TV off via HDMI-CEC
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
exec "$SCRIPT_DIR/tv-control.sh" off
