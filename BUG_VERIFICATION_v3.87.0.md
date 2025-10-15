# Bug Verification Report - Ruchy v3.87.0

**Date**: 2025-10-15
**Ruchy Version**: 3.87.0 (updated from 3.86.0)
**Previous Version**: 3.86.0
**Verification Type**: Regression check for Bug #31

---

## Executive Summary

Ruchy updated from v3.86.0 to v3.87.0. Verified Bug #31 regression status.

**Result**: 🛑 **Bug #31 STILL NOT FIXED** - fmt continues to corrupt files with AST debug output.

---

## Bug #31 - CRITICAL: ruchy fmt corrupts files with AST debug output

**Status**: 🛑 **STILL BROKEN**

### History

- **Sprint 1**: Bug #31 filed - fmt corrupts files with AST debug
- **Sprint 2**: Bug #31 marked as fixed in v3.82.0
- **Sprint 3**: Bug #31 continued to work (v3.86.0)
- **Sprint 4**: Bug #31 regressed - fmt corrupts again (v3.86.0)
- **Now (v3.87.0)**: Bug #31 still broken

### Verification Test

**Test File**: `examples/ruchy-head/head.ruchy` (48 lines, valid Ruchy)

```bash
$ ruchy --version
ruchy 3.87.0

$ cp head.ruchy head_test_fmt.ruchy
$ ruchy fmt head_test_fmt.ruchy
✓ Formatted head_test_fmt.ruchy

$ ruchy check head_test_fmt.ruchy
✓ Syntax is valid

$ head -20 head_test_fmt.ruchy
{
    fun head_lines(file_path: Any, n: Any) {
        let content = fs_read(file_path) in {
            let result = ""
            let line_count = 0
            for i in range(0, content.len()) {
                let ch = IndexAccess { object: Expr { kind: Identifier("content"),
                    span: Span { start: 472, end: 479 }, attributes: [] },
                    index: Expr { kind: Identifier("i"), span: Span { start: 480,
                    end: 481 }, attributes: [] } } in {
                    if line_count < n {
                        Assign { target: Expr { kind: Identifier("result"),
                            span: Span { start: 524, end: 530 }, attributes: [] },
                            value: Expr { kind: Binary { left: Expr { kind: Identifier("result"),
                            span: Span { start: 533, end: 539 }, attributes: [] },
                            op: Add, right: Expr { kind: Identifier("ch"),
                            span: Span { start: 542, end: 544 }, attributes: [] } },
                            span: Span { start: 0, end: 0 }, attributes: [] } }
                    }
```

**Problem**: File is corrupted with AST debug representation instead of formatted Ruchy code!

### Expected vs Actual

**Expected** (original valid Ruchy code):
```ruchy
fun head_lines(file_path, n) {
    let content = fs_read(file_path)
    let result = ""
    let line_count = 0

    for i in range(0, content.len()) {
        let ch = content[i]

        if line_count < n {
            result = result + ch
        }
        ...
```

**Actual** (corrupted AST debug output):
```ruchy
{
    fun head_lines(file_path: Any, n: Any) {
        let content = fs_read(file_path) in {
            let result = ""
            let line_count = 0
            for i in range(0, content.len()) {
                let ch = IndexAccess { object: Expr { kind: Identifier("content"),
                    span: Span { start: 472, end: 479 }, attributes: [] }, ...
```

### Analysis

**Misleading Output**:
- `ruchy fmt` claims: "✓ Formatted head_test_fmt.ruchy" (success!)
- `ruchy check` says: "✓ Syntax is valid" (but it's not valid Ruchy!)
- **Reality**: File is completely corrupted

**This is worse than a simple failure** because:
1. Tool claims success when it failed
2. Corrupted file passes syntax check
3. Silent data corruption (destructive)
4. No warning to user

---

## Impact

**Severity**: CRITICAL
- **Data Loss**: Destructive operation with no warning
- **Silent Failure**: Claims success while corrupting
- **Persistent Bug**: Not fixed in v3.87.0 update
- **Development Blocker**: Cannot use ruchy fmt safely

**Sprint Impact**:
- Sprint 4 completed by skipping fmt (workaround)
- Sprint 5+ will need to continue skipping fmt
- Tool pass rate remains at 89% (8/9)

---

## Recommendation

**DO NOT USE `ruchy fmt` in any sprint** until this bug is fixed.

**Workaround**:
1. Skip fmt in all qualification processes
2. Use manual formatting following style guide
3. Document fmt as excluded from quality tools
4. Mark fmt as ⚠️ **SKIP** in all reports

**For Sprint 5+**:
- Continue with 8/9 tools (89% pass rate)
- Document fmt exclusion clearly
- Re-verify fmt in future Ruchy updates

---

## Comparison with Sprint 2-3 Working Behavior

In Sprint 2-3, when Bug #31 was "fixed", fmt actually worked:
- Took valid Ruchy code
- Reformatted it correctly
- Produced valid Ruchy code output
- File remained functional

**Key Question**: Why did it work in Sprint 2-3 with v3.86.0, but fail in Sprint 4 with same version?

Possible answers:
1. **Different code patterns**: head.ruchy uses patterns that trigger bug
2. **Incomplete fix**: Bug was only partially fixed
3. **Intermittent bug**: Works sometimes, fails others
4. **Environment dependent**: Something else changed

---

## Verification Summary

### Bug Status Check

| Bug | Sprint 1 | Sprint 2 | Sprint 3 | Sprint 4 | v3.87.0 | Status |
|-----|----------|----------|----------|----------|---------|---------|
| #31 | Filed | "Fixed" | Worked | Regressed | **Still Broken** | 🛑 NOT FIXED |

### Tool Pass Rate

| Sprint | Version | fmt Status | Overall |
|--------|---------|------------|---------|
| Sprint 1 | v3.80.0 | 🛑 Broken | 50% (6/12) |
| Sprint 2 | v3.86.0 | ✅ "Fixed" | 100% (9/9) |
| Sprint 3 | v3.86.0 | ✅ Worked | 100% (9/9) |
| Sprint 4 | v3.86.0 | 🛑 Regressed | 89% (8/9) |
| **Now** | **v3.87.0** | **🛑 Still Broken** | **89% (8/9)** |

---

## Conclusion

**Bug #31 is NOT fixed in v3.87.0.**

The formatter continues to corrupt files with AST debug output. This is a critical bug that:
- Causes silent data corruption
- Claims success while failing
- Persists across multiple versions
- Blocks safe use of ruchy fmt tool

**Action**: Continue excluding fmt from all quality tool runs until this bug is properly fixed and verified.

---

## Next Steps

1. ✅ Document v3.87.0 verification results
2. ✅ Continue Sprint 5+ without fmt (if proceeding)
3. ✅ Mark fmt as permanently excluded until fixed
4. 📋 Comment on Bug #31 issue (if accessible)
5. 📋 Wait for future Ruchy update addressing fmt

---

**Verification Date**: 2025-10-15
**Verified By**: EXTREME TDD Sprint 4 follow-up
**Status**: 🛑 **Bug #31 STILL NOT FIXED in v3.87.0**
**Recommendation**: **SKIP ruchy fmt in all sprints**

---

*"Trust, but verify." - Ronald Reagan*
*"We verified. Bug #31 is still broken. We adapt and continue." - EXTREME TDD*
