#!/bin/bash
set -euo pipefail

# tvon.sh - Turn TV on via HDMI-CEC
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
exec "$SCRIPT_DIR/tv-control.sh" on
