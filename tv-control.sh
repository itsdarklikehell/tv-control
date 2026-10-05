#!/bin/bash
set -euo pipefail

# tv-control.sh - Control TV over HDMI-CEC
# Usage: ./tv-control.sh [on|off|status|source|menu]

SCRIPT_NAME="$(basename "$0")"
DRY_RUN="${DRY_RUN:-false}"
LOG_FILE="${LOG_FILE:-/tmp/tv-control.log}"

# CEC device: RPI = Raspberry Pi, use -s for single device, -d 1 for debug level
CEC_CLIENT="${CEC_CLIENT:-cec-client RPI -s -d 1}"

log() {
    local level="$1"
    shift
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$level] $*" | tee -a "$LOG_FILE"
}

run_cec() {
    local cmd="$1"
    if [[ "$DRY_RUN" == "true" ]]; then
        log "DRY-RUN" "Would run: echo '$cmd' | $CEC_CLIENT"
        return 0
    fi
    log "INFO" "Running: echo '$cmd' | $CEC_CLIENT"
    echo "$cmd" | $CEC_CLIENT 2>&1 | tee -a "$LOG_FILE"
}

tv_on() {
    log "INFO" "Turning TV on"
    run_cec "on 0"
}

tv_off() {
    log "INFO" "Turning TV off"
    run_cec "standby 0"
}

tv_status() {
    log "INFO" "Getting TV status"
    run_cec "pow 0"
}

tv_source() {
    log "INFO" "Switching TV source"
    run_cec "as"
}

show_menu() {
    while true; do
        local choice
        choice=$(whiptail --title "TV Control" --menu "Choose an option" 20 60 10 \
            "On" "Turn TV on" \
            "Off" "Turn TV off" \
            "Status" "Check TV status" \
            "Source" "Switch to RPI source" \
            "Exit" "Exit" 3>&2 2>&1 1>&3)

        case "$choice" in
            On) tv_on ;;
            Off) tv_off ;;
            Status) tv_status ;;
            Source) tv_source ;;
            Exit|"") break ;;
            *) echo "Invalid choice" ;;
        esac
    done
}

main() {
    local action="${1:-menu}"

    case "$action" in
        on) tv_on ;;
        off) tv_off ;;
        status) tv_status ;;
        source) tv_source ;;
        menu) show_menu ;;
        *)
            echo "Usage: $SCRIPT_NAME [on|off|status|source|menu]"
            echo ""
            echo "Environment variables:"
            echo "  DRY_RUN=true    - Simulate commands without executing"
            echo "  LOG_FILE=path   - Custom log file (default: /tmp/tv-control.log)"
            echo "  CEC_CLIENT=cmd  - Custom cec-client command"
            exit 1
            ;;
    esac
}

main "$@"
