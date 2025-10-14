#!/bin/bash
# Pre-commit hook for Ruchy CLI Tools Book
# Enforces EXTREME TDD quality standards
# NEVER bypass with --no-verify (FORBIDDEN)

set -e  # Exit on first failure

echo "================================================================"
echo "Pre-commit Quality Gates (Ruchy Project)"
echo "================================================================"
echo ""

# Track if any check failed
FAILED=0

# ============================================================================
# 0. CHECK RUCHY INSTALLATION
# ============================================================================
echo "0/7 Verifying Ruchy installation..."
if command -v ruchy >/dev/null 2>&1; then
    echo "    ✓ Ruchy is installed ($(ruchy --version))"
else
    echo "    ❌ Ruchy NOT installed"
    echo "    Install: cargo install ruchy"
    FAILED=1
    exit 1
fi
echo ""

# ============================================================================
# 1. FORMAT CHECK (Ruchy files)
# ============================================================================
echo "1/7 Checking Ruchy code formatting..."
if find examples tests tools -name "*.ruchy" -type f -exec ruchy fmt --check {} \; 2>/dev/null; then
    echo "    ✓ Format check passed"
else
    echo "    ❌ Format check FAILED"
    echo "    Run: make format"
    FAILED=1
fi
echo ""

# ============================================================================
# 2. LINT CHECK (Ruchy files)
# ============================================================================
echo "2/7 Running Ruchy lint..."
if find examples tests tools -name "*.ruchy" -type f -exec ruchy lint {} \; 2>/dev/null; then
    echo "    ✓ Lint passed"
else
    echo "    ❌ Lint FAILED"
    echo "    Run: make lint"
    FAILED=1
fi
echo ""

# ============================================================================
# 3. SYNTAX CHECK (Ruchy files)
# ============================================================================
echo "3/7 Checking Ruchy syntax..."
if find examples tests tools -name "*.ruchy" -type f -exec ruchy check {} \; 2>/dev/null; then
    echo "    ✓ Syntax check passed"
else
    echo "    ❌ Syntax check FAILED"
    echo "    Run: ruchy check <file>"
    FAILED=1
fi
echo ""

# ============================================================================
# 4. FAST TESTS (Ruchy tests, <10s)
# ============================================================================
echo "4/7 Running fast tests..."
if find tests -name "*_test.ruchy" -type f | grep -q . 2>/dev/null; then
    if ruchy test run tests/ >/dev/null 2>&1; then
        echo "    ✓ Fast tests passed"
    else
        echo "    ❌ Tests FAILED"
        echo "    Run: make test-fast"
        FAILED=1
    fi
else
    echo "    ⚠ No test files found yet, skipping"
fi
echo ""

# ============================================================================
# 5. EXAMPLE TESTS
# ============================================================================
echo "5/7 Checking example tests..."
if find examples -name "*_test.ruchy" -type f | grep -q . 2>/dev/null; then
    echo "    ✓ Example tests exist"
else
    echo "    ⚠ No example tests found yet"
fi
echo ""

# ============================================================================
# 6. SATD CHECK (Zero TODO/FIXME/HACK tolerance) - Ruchy files
# ============================================================================
echo "6/7 Checking for SATD markers in Ruchy files..."
if find examples tests tools -name "*.ruchy" -type f -exec grep -l "TODO\|FIXME\|HACK" {} \; 2>/dev/null | head -5; then
    echo "    ❌ SATD markers found (TODO/FIXME/HACK) in .ruchy files"
    echo "    These are FORBIDDEN. Create GitHub issues instead."
    FAILED=1
else
    echo "    ✓ No SATD markers found in Ruchy files"
fi
echo ""

# ============================================================================
# 7. TDD VERIFICATION (Commit message check)
# ============================================================================
echo "7/7 Verifying TDD workflow..."
# Get the commit message (if available)
if [ -f .git/COMMIT_EDITMSG ]; then
    COMMIT_MSG=$(cat .git/COMMIT_EDITMSG)
    if echo "$COMMIT_MSG" | grep -qE "^(RED|GREEN|REFACTOR|PROPERTY|QUALIFY|DOCS|INFRA|FIX):"; then
        echo "    ✓ TDD commit message format detected"
    else
        echo "    ⚠ Commit message should follow TDD format:"
        echo "       RED:, GREEN:, REFACTOR:, PROPERTY:, QUALIFY:"
        echo "       DOCS:, INFRA:, FIX:"
        # Don't fail on this, just warn
    fi
else
    echo "    ⚠ Cannot verify commit message (not available yet)"
fi
echo ""

# ============================================================================
# FINAL RESULT
# ============================================================================
echo "================================================================"
if [ $FAILED -eq 1 ]; then
    echo "❌ PRE-COMMIT CHECKS FAILED"
    echo "================================================================"
    echo ""
    echo "Fix the issues above and try again."
    echo ""
    echo "IMPORTANT: NEVER use 'git commit --no-verify'"
    echo "This bypasses quality gates and is STRICTLY FORBIDDEN."
    echo ""
    exit 1
else
    echo "✓ ALL PRE-COMMIT CHECKS PASSED"
    echo "================================================================"
    echo ""
    echo "Proceeding with commit..."
    echo ""
    exit 0
fi
