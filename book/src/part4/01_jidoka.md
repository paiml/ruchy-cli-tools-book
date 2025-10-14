# Jidoka: Stop The Line

**Jidoka** (自働化) is a Japanese term meaning "autonomation"—automation with human intelligence. In Toyota manufacturing, it means machines automatically stop when a defect is detected, and workers are **empowered and required** to stop the entire production line if they find a quality issue.

In software development, we apply Jidoka by stopping all work immediately when we encounter a fundamental defect—especially bugs in the language or toolchain itself.

## The Philosophy

> "We place the highest value on actual implementation and taking action. There are many things one doesn't understand and therefore, we ask them why don't you just go ahead and take action; try to do something? You realize how little you know and you face your own failures and you simply can correct those failures and redo it again and at the second trial you realize another mistake or another thing you didn't like so you can redo it once again. So by constant improvement, or, should I say, the improvement based upon action, one can rise to the higher level of practice and knowledge."
> — Fujio Cho, Toyota Motor Corporation

### Key Principles

1. **Quality at the Source**: Build quality in, don't bolt it on
2. **Stop When Problems Occur**: Don't pass defects downstream
3. **Fix Problems Immediately**: Address root cause, not symptoms
4. **Respect for People**: Help others by reporting issues properly

## Real-World Example: Ruchy Bug #30

On 2025-10-14, during Sprint 1 of this very book project, we encountered a perfect example of when to "Stop The Line."

### The Situation

**Task**: S1T1 - RED phase for ruchy-cat (write failing test for file reading)

**Discovery**: The `::` (ColonColon) operator was rejected by `ruchy check` as a syntax error:

```bash
$ ruchy check cat_test.ruchy
✗ Syntax error: Unexpected token: ColonColon
Error: Syntax error: Unexpected token: ColonColon
```

### The Conflict

The official Ruchy example files (like `examples/11_file_io.ruchy`) use `::` syntax extensively:

```ruchy
import std::fs

fn main() {
    let content = fs::read_to_string("test.txt")?
    fs::write("output.txt", content)?
    // ... etc
}
```

But `ruchy check` rejects this as invalid syntax!

Even worse—the official example file itself fails:

```bash
$ ruchy check /path/to/ruchy/examples/11_file_io.ruchy
✗ Syntax error: Unexpected token: ColonColon
```

### The Decision: 🛑 STOP THE LINE

Following the Jidoka principle, **all development was immediately halted**.

This wasn't a bug in our code—it was a bug in the Ruchy language itself. File I/O operations (fundamental to CLI tools) require the `::` operator which the syntax checker rejects.

**Severity**: **BLOCKING** - Cannot proceed with any file I/O operations.

## The 6-Step Protocol

When a language bug is discovered, we follow this mandatory protocol:

### 1. 🛑 STOP THE LINE

**Immediately halt all work on the current task.**

```bash
# Document the stop
echo "STOPPED: Ruchy language bug found in ruchy check" >> .stop-the-line.log
echo "Date: $(date)" >> .stop-the-line.log
echo "Component: ruchy check (syntax validation)" >> .stop-the-line.log
echo "Severity: blocking" >> .stop-the-line.log
```

**Do NOT**:
- ❌ Continue working around the bug silently
- ❌ Assume it's our code error without verification
- ❌ Try multiple workarounds without documenting

### 2. 🔍 REPRODUCE

Create a **minimal reproducible example** (< 20 lines).

**Good Example** (`bug_colons.ruchy`):
```ruchy
// Minimal reproducible example for Ruchy bug
// Demonstrates ColonColon syntax error

import std::fs

fn main() {
    let content = "test"
    fs::write("test.txt", content)?
}
```

This is 9 lines and clearly demonstrates the issue.

**Bad Example**:
```ruchy
// Don't include 100 lines of our cat implementation
// Don't include unrelated code
// Keep it MINIMAL
```

### 3. 📝 DOCUMENT

Write a detailed bug report using the template from `BUG_PROTOCOL.md`.

Key sections:
- **Component**: What part of the language/toolchain
- **Severity**: blocking / high / medium / low
- **Minimal Example**: Your < 20 line reproduction
- **Expected Behavior**: What SHOULD happen (with references)
- **Actual Behavior**: What actually happens (exact error messages)
- **Steps to Reproduce**: 1, 2, 3...
- **Environment**: OS, versions, installation method
- **Workaround**: Alternative approaches (if any)
- **Impact**: How this blocks your project

For Ruchy bug #30, we created `RUCHY_BUG_COLONCOLON.md` with all details.

### 4. 🐛 FILE ISSUE

Submit the bug report to the upstream repository.

For Ruchy bugs:
- **Repository**: https://github.com/paiml/ruchy
- **Method**: Use `gh` CLI or web interface

```bash
cd /path/to/ruchy
gh issue create --repo paiml/ruchy \
  --title "Syntax Error: ColonColon (::) operator rejected" \
  --body-file ../ruchy-cli-tools-book/RUCHY_BUG_COLONCOLON.md
```

**Result**: Issue #30 created at https://github.com/paiml/ruchy/issues/30

### 5. 🔧 WORKAROUND

Document any temporary solution that unblocks development.

**For Ruchy bug #30**: No workaround found yet.

File I/O operations fundamentally require the `::` operator which is not currently supported.

If a workaround exists:

```ruchy
// WORKAROUND for Ruchy bug #30
// Issue: https://github.com/paiml/ruchy/issues/30
// The :: operator isn't supported yet
// Using alternative syntax: ...

fun workaround_read_file(path) {
    // Alternative implementation
}
```

### 6. 📊 TRACK

Update `roadmap.yaml` with bug tracking metadata:

```yaml
- id: S1T1
  title: "RED: Test reading single file"
  status: blocked
  blocked_by:
    type: ruchy_language_bug
    issue_number: 30
    issue_url: "https://github.com/paiml/ruchy/issues/30"
    component: "ruchy check - ColonColon (::) syntax"
    severity: blocking
    workaround: "None found - :: required for file I/O"
    date_filed: "2025-10-14"
    date_resolved: null
    notes: |
      Cannot proceed with file I/O until bug is fixed.
      Options: 1) Wait for fix, 2) Work on non-file-I/O tools,
      3) Focus on infrastructure tasks
```

## After Filing The Bug

### Continue Development Strategy

The severity determines your path forward:

| Severity | Action | Example |
|----------|--------|---------|
| **blocking** | Work on different chapter/tool | Our case: focus on infrastructure |
| **high** | Use workaround, continue cautiously | Document workaround in code |
| **medium** | Minor inconvenience | Document, continue normally |
| **low** | Nice to have fix | Note for future improvement |

### For Ruchy Bug #30

We chose **Option 4: Focus on Infrastructure** while waiting:

✅ Completed tasks:
- Configure GitHub Actions (S0T4)
- Setup mdBook structure (S0T5)
- Improve documentation
- Document the Stop The Line process (this chapter!)

❌ Blocked tasks:
- All file I/O operations
- Sprint 1: ruchy-cat
- Most CLI tools (require file I/O)

### Monitoring Bug Status

Check regularly for updates:

```bash
# View issue status
gh issue view 30 --repo paiml/ruchy

# Or visit URL
open https://github.com/paiml/ruchy/issues/30
```

### When Bug Is Resolved

1. **Update roadmap.yaml**:
```yaml
blocked_by:
  ...
  date_resolved: "2025-10-XX"
  resolved_in_version: "3.79.0"
```

2. **Remove workarounds**:
```ruchy
// Removed workaround - using proper :: syntax
// Bug #30 fixed in Ruchy v3.79.0
import std::fs

fn read_file(path) {
    fs::read_to_string(path)?  // Now works!
}
```

3. **Test thoroughly**:
```bash
make validate
make test-all
make dogfood-full
```

4. **Commit and resume**:
```bash
git commit -m "FIX: Remove workaround for Ruchy bug #30

- :: operator now works in v3.79.0
- Implemented proper file I/O
- Resuming Sprint 1 development
- Closes tracking of bug #30"
```

## Benefits of Stop The Line

### For the Language (Ruchy)

✅ Bugs discovered and reported properly
✅ Dogfooding improves language quality
✅ Future users won't hit same issues
✅ Maintainers get detailed, reproducible reports

### For This Project

✅ Maintains development momentum (work on other tasks)
✅ Documents all workarounds clearly
✅ Tracks bug resolution systematically
✅ Ensures proper refactoring when bugs are fixed
✅ Demonstrates real-world quality culture

### For Toyota Way Principles

✅ **Jidoka**: Stopped line when defect detected
✅ **Genchi Genbutsu**: Went and saw the actual problem
✅ **Kaizen**: Helping improve Ruchy language quality
✅ **Respect for People**: Detailed bug report helps maintainers

## Quality at the Source

The key insight: **Don't work around fundamental defects.**

If we had:
- ❌ Continued with hacky workarounds
- ❌ Silently switched to different syntax
- ❌ Ignored the official examples
- ❌ Not filed a proper bug report

Then:
- Future developers would hit the same issue
- The language bug would remain unfixed
- Our code would be fragile and confusing
- We'd waste time on workarounds

By stopping the line:
- ✅ Language improves
- ✅ Documentation improves
- ✅ Everyone benefits
- ✅ Quality is built-in

## Handling Language Bugs

When dogfooding a new language, language bugs are **expected**. This is part of the value we provide!

### Quick Reference Card

```
🛑 BUG FOUND IN RUCHY LANGUAGE?

1. STOP - Halt current work
2. REPRODUCE - Create minimal example (< 20 lines)
3. DOCUMENT - Use bug report template
4. FILE - Submit to github.com/paiml/ruchy/issues
5. WORKAROUND - Find alternative if possible
6. TRACK - Update roadmap.yaml

Then continue with:
- Blocking: Work on different tool/chapter
- High: Use workaround
- Medium/Low: Continue normally
```

## Lessons Learned

From our actual Stop The Line event (Ruchy bug #30):

1. **Verify official examples**: Even example code can have bugs
2. **Test early**: We found the bug in Sprint 1, Task 1
3. **Document thoroughly**: Future developers learn from this
4. **Stay flexible**: Infrastructure tasks kept momentum going
5. **Respect the process**: Following protocol helps everyone

## Genchi Genbutsu: Go and See

Notice how we didn't just assume the problem was our code:

1. ✅ Checked official examples
2. ✅ Tested the official examples themselves
3. ✅ Verified basic programs work
4. ✅ Isolated the exact operator causing issues
5. ✅ Created minimal reproduction

This is **Genchi Genbutsu**—going to see the actual problem directly.

## Summary

**Jidoka in action**:
- 🛑 Stop immediately when defect detected
- 🔍 Investigate root cause thoroughly
- 📝 Document for others
- 🐛 Report upstream properly
- 🔧 Find workaround or alternative path
- 📊 Track and monitor resolution

This is how we build quality into our process, not bolt it on afterward.

---

**Next**: [Genchi Genbutsu: Go and See](./02_genchi_genbutsu.md) - Learn about direct observation and verification.

**Related**:
- [BUG_PROTOCOL.md](../../../BUG_PROTOCOL.md) - Full protocol documentation
- [STOP_THE_LINE_REPORT.md](../../../STOP_THE_LINE_REPORT.md) - Detailed report of bug #30
- [Ruchy Issue #30](https://github.com/paiml/ruchy/issues/30) - Actual bug report
