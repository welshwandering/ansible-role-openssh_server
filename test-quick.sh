#!/usr/bin/env bash
set -e

# Test script for all supported distributions
# Tests each distribution sequentially with proper cleanup

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Molecule path
MOLECULE="${HOME}/.local/pipx/venvs/ansible-core/bin/molecule"

# Distribution configurations
declare -A DISTROS=(
    ["debian9"]="geerlingguy/docker-debian9-ansible:latest|7.4p1"
    ["debian10"]="geerlingguy/docker-debian10-ansible:latest|7.9p1"
    ["debian11"]="geerlingguy/docker-debian11-ansible:latest|8.4p1"
    ["debian12"]="geerlingguy/docker-debian12-ansible:latest|9.2p1"
    ["ubuntu1604"]="geerlingguy/docker-ubuntu1604-ansible:latest|7.2p2"
    ["ubuntu1804"]="geerlingguy/docker-ubuntu1804-ansible:latest|7.6p1"
    ["ubuntu2004"]="geerlingguy/docker-ubuntu2004-ansible:latest|8.2p1"
    ["ubuntu2204"]="geerlingguy/docker-ubuntu2204-ansible:latest|8.9p1"
    ["ubuntu2404"]="geerlingguy/docker-ubuntu2404-ansible:latest|9.6p1"
)

# Results tracking
PASSED=()
FAILED=()
TOTAL=${#DISTROS[@]}
CURRENT=0

echo "=========================================="
echo "Testing ${TOTAL} distributions"
echo "=========================================="
echo ""

for distro in "${!DISTROS[@]}"; do
    CURRENT=$((CURRENT + 1))
    IFS='|' read -r image version <<< "${DISTROS[$distro]}"

    echo "[$CURRENT/$TOTAL] Testing $distro (OpenSSH $version)..."

    # Export environment variables
    export MOLECULE_DISTRO="$distro"
    export MOLECULE_IMAGE="$image"
    export MOLECULE_OPENSSH_VERSION="$version"

    # Run test with timeout
    if timeout 300 "$MOLECULE" test 2>&1 | tee "/tmp/${distro}-test.log" | grep -q "successful"; then
        echo "✅ $distro PASSED"
        PASSED+=("$distro")
    else
        echo "❌ $distro FAILED (see /tmp/${distro}-test.log)"
        FAILED+=("$distro")
    fi

    echo ""
done

# Summary
echo "=========================================="
echo "TEST SUMMARY"
echo "=========================================="
echo "Total: $TOTAL"
echo "Passed: ${#PASSED[@]}"
echo "Failed: ${#FAILED[@]}"
echo ""

if [ ${#PASSED[@]} -gt 0 ]; then
    echo "✅ PASSED:"
    for d in "${PASSED[@]}"; do
        echo "   - $d"
    done
    echo ""
fi

if [ ${#FAILED[@]} -gt 0 ]; then
    echo "❌ FAILED:"
    for d in "${FAILED[@]}"; do
        echo "   - $d (log: /tmp/${d}-test.log)"
    done
    echo ""
    exit 1
fi

echo "🎉 All tests passed!"
exit 0
