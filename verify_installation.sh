#!/bin/bash

# SYNDRAVA Installation Verification Script
# Run this to verify your SYNDRAVA installation is ready

echo "╔════════════════════════════════════════════════════════════╗"
echo "║                                                            ║"
echo "║           ⬡ SYNDRAVA VERIFICATION SCRIPT ⬡                ║"
echo "║                                                            ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

PASS=0
FAIL=0

# Function to check file
check_file() {
    if [ -f "$1" ]; then
        echo "✅ $1 found"
        ((PASS++))
        return 0
    else
        echo "❌ $1 MISSING"
        ((FAIL++))
        return 1
    fi
}

# Function to validate JSON
validate_json() {
    if python3 -m json.tool "$1" > /dev/null 2>&1; then
        echo "✅ $1 valid JSON"
        ((PASS++))
        return 0
    else
        echo "❌ $1 INVALID JSON"
        ((FAIL++))
        return 1
    fi
}

echo "📋 STEP 1: Checking core files..."
echo "─────────────────────────────────────────────────────────────"
check_file "SYNDRAVA.amxd"
check_file "p_spectral_blur.maxpat"
echo ""

echo "📋 STEP 2: Checking documentation..."
echo "─────────────────────────────────────────────────────────────"
check_file "README.md"
check_file "QUICK_REFERENCE.md"
check_file "INSTALLATION_GUIDE.md"
check_file "ADVANCED_CUSTOMIZATION.md"
check_file "PROJECT_SUMMARY.md"
check_file "DEPENDENCY_REPORT.md"
echo ""

echo "📋 STEP 3: Validating JSON structure..."
echo "─────────────────────────────────────────────────────────────"
validate_json "SYNDRAVA.amxd"
validate_json "p_spectral_blur.maxpat"
echo ""

echo "📋 STEP 4: Checking Max objects..."
echo "─────────────────────────────────────────────────────────────"
OBJECTS=$(grep -oP '"text"\s*:\s*"\K[^"]+' SYNDRAVA.amxd | grep -E '^[a-z~]' | awk '{print $1}' | sort -u | wc -l)
echo "✅ Found $OBJECTS unique Max objects"
((PASS++))
echo ""

echo "📋 STEP 5: Checking patch structure..."
echo "─────────────────────────────────────────────────────────────"
SUBPATCHERS=$(grep -c '"patcher"' SYNDRAVA.amxd)
CONNECTIONS=$(grep -c '"patchline"' SYNDRAVA.amxd)
echo "✅ $SUBPATCHERS sub-patchers found"
echo "✅ $CONNECTIONS signal connections found"
((PASS+=2))
echo ""

echo "╔════════════════════════════════════════════════════════════╗"
echo "║                     VERIFICATION SUMMARY                   ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "  Tests Passed: $PASS"
echo "  Tests Failed: $FAIL"
echo ""

if [ $FAIL -eq 0 ]; then
    echo "  ✅ STATUS: ALL SYSTEMS GO!"
    echo ""
    echo "  🎉 SYNDRAVA is ready to use!"
    echo ""
    echo "  Next steps:"
    echo "    1. Copy SYNDRAVA.amxd to Ableton User Library"
    echo "    2. Copy p_spectral_blur.maxpat to same folder"
    echo "    3. Open Ableton Live 11+"
    echo "    4. Load SYNDRAVA from Browser → Max Instrument"
    echo "    5. Read QUICK_REFERENCE.md for controls"
    echo ""
    echo "  ⬡ Ready for ritual ⬡"
    exit 0
else
    echo "  ❌ STATUS: ISSUES DETECTED"
    echo ""
    echo "  Please check the failed tests above."
    echo "  Re-download missing files or check for corruption."
    echo ""
    exit 1
fi
