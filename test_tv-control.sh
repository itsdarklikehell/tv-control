#!/bin/bash
set -euo pipefail

# test_tv-control.sh - Test suite for tv-control scripts
# Run: ./test_tv-control.sh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PASS=0
FAIL=0

pass() { echo "  PASS: $1"; PASS=$((PASS + 1)); }
fail() { echo "  FAIL: $1"; FAIL=$((FAIL + 1)); }

echo "=== tv-control test suite ==="
echo ""

# Test 1: All scripts exist and are executable
echo "[Test 1] Script existence and permissions"
for script in tv-control.sh tvon.sh tvoff.sh tvsource.sh tvstat.sh install.sh; do
    if [[ -x "$SCRIPT_DIR/$script" ]]; then
        pass "$script exists and is executable"
    else
        fail "$script missing or not executable"
    fi
done
echo ""

# Test 2: Syntax check
echo "[Test 2] Syntax check (bash -n)"
for script in "$SCRIPT_DIR"/*.sh; do
    if bash -n "$script" 2>/dev/null; then
        pass "$(basename "$script") syntax OK"
    else
        fail "$(basename "$script") syntax error"
    fi
done
echo ""

# Test 3: Shellcheck
echo "[Test 3] Shellcheck"
if command -v shellcheck &>/dev/null; then
    for script in "$SCRIPT_DIR"/*.sh; do
        if shellcheck "$script" &>/dev/null; then
            pass "$(basename "$script") shellcheck clean"
        else
            fail "$(basename "$script") shellcheck warnings"
        fi
    done
else
    echo "  SKIP: shellcheck not installed"
fi
echo ""

# Test 4: DRY_RUN mode
echo "[Test 4] DRY_RUN mode"
if DRY_RUN=true "$SCRIPT_DIR/tv-control.sh" on &>/dev/null; then
    pass "tv-control.sh on (DRY_RUN)"
else
    fail "tv-control.sh on (DRY_RUN)"
fi

if DRY_RUN=true "$SCRIPT_DIR/tv-control.sh" off &>/dev/null; then
    pass "tv-control.sh off (DRY_RUN)"
else
    fail "tv-control.sh off (DRY_RUN)"
fi

if DRY_RUN=true "$SCRIPT_DIR/tv-control.sh" status &>/dev/null; then
    pass "tv-control.sh status (DRY_RUN)"
else
    fail "tv-control.sh status (DRY_RUN)"
fi

if DRY_RUN=true "$SCRIPT_DIR/tv-control.sh" source &>/dev/null; then
    pass "tv-control.sh source (DRY_RUN)"
else
    fail "tv-control.sh source (DRY_RUN)"
fi
echo ""

# Test 5: Wrapper scripts
echo "[Test 5] Wrapper scripts (DRY_RUN)"
if DRY_RUN=true "$SCRIPT_DIR/tvon.sh" &>/dev/null; then
    pass "tvon.sh"
else
    fail "tvon.sh"
fi

if DRY_RUN=true "$SCRIPT_DIR/tvoff.sh" &>/dev/null; then
    pass "tvoff.sh"
else
    fail "tvoff.sh"
fi

if DRY_RUN=true "$SCRIPT_DIR/tvstat.sh" &>/dev/null; then
    pass "tvstat.sh"
else
    fail "tvstat.sh"
fi

if DRY_RUN=true "$SCRIPT_DIR/tvsource.sh" &>/dev/null; then
    pass "tvsource.sh"
else
    fail "tvsource.sh"
fi
echo ""

# Test 6: Invalid argument handling
echo "[Test 6] Invalid argument handling"
if ! "$SCRIPT_DIR/tv-control.sh" invalid_arg &>/dev/null; then
    pass "Invalid argument exits with error"
else
    fail "Invalid argument should exit with error"
fi
echo ""

# Test 7: Help/usage output
echo "[Test 7] Usage output"
if "$SCRIPT_DIR/tv-control.sh" invalid_arg 2>&1 | grep -q "Usage:" || true; then
    pass "Usage message displayed"
else
    fail "Usage message not displayed"
fi
echo ""

# Test 8: install.sh syntax and help
echo "[Test 8] install.sh validation"
if bash -n "$SCRIPT_DIR/install.sh" 2>/dev/null; then
    pass "install.sh syntax OK"
else
    fail "install.sh syntax error"
fi

if "$SCRIPT_DIR/install.sh" 2>&1 | grep -q "Usage:" || true; then
    pass "install.sh shows usage on no args"
else
    fail "install.sh should show usage"
fi
echo ""

# Test 9: CEC_CLIENT environment variable
echo "[Test 9] CEC_CLIENT environment variable"
if CEC_CLIENT="echo mock" DRY_RUN=true "$SCRIPT_DIR/tv-control.sh" on &>/dev/null; then
    pass "CEC_CLIENT override works"
else
    fail "CEC_CLIENT override failed"
fi
echo ""

# Test 10: LOG_FILE environment variable
echo "[Test 10] LOG_FILE environment variable"
TMPLOG=$(mktemp)
if LOG_FILE="$TMPLOG" DRY_RUN=true "$SCRIPT_DIR/tv-control.sh" on &>/dev/null; then
    pass "LOG_FILE override works"
else
    fail "LOG_FILE override failed"
fi
rm -f "$TMPLOG"
echo ""

# Summary
echo "=== Results ==="
echo "Passed: $PASS"
echo "Failed: $FAIL"
echo ""

if [[ $FAIL -eq 0 ]]; then
    echo "All tests passed!"
    exit 0
else
    echo "Some tests failed!"
    exit 1
fi
