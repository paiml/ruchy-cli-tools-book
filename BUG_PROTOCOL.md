# 🛑 Stop The Line - Ruchy Language Bug Protocol

**Toyota Way Jidoka Applied to Language Bugs**

## Overview

This project is **dogfooding** the Ruchy programming language - we're using Ruchy to showcase what it can do. As early adopters, we WILL encounter language bugs. This document defines our **mandatory** protocol for handling them.

## Philosophy: Jidoka (Autonomation)

In Toyota manufacturing, **Jidoka** means machines stop automatically when a defect is detected. Workers are **empowered and required** to stop the entire production line if they find a quality issue.

We apply this to Ruchy language bugs:
- 🛑 **Stop the line** - Halt work immediately
- 📝 **Document thoroughly** - Create reproducible bug report
- 🐛 **File upstream** - Report to Ruchy repository
- 🔧 **Find workaround** - Unblock development if possible
- 📊 **Track progress** - Monitor bug resolution

## When to Apply This Protocol

Apply **STOP THE LINE** protocol when you find a bug in:

✅ **Ruchy Language Components**:
- `ruchy check` - Syntax validation
- `ruchy transpile` - Ruchy → Rust transpilation
- `ruchy lint` - Code linting
- `ruchy fmt` - Code formatting
- `ruchy run` - Program execution
- `ruchy test` - Test framework
- `ruchy wasm` - WASM compilation
- `ruchy repl` - Interactive REPL
- `ruchy notebook` - Notebook interface
- Any of the 15 Ruchy tools
- Ruchy compiler/runtime itself

❌ **NOT for Bugs in Our Code**:
- Bugs in our `.ruchy` CLI tool implementations
- Logical errors in our test files
- Our misunderstanding of Ruchy syntax
- Missing features we need to implement ourselves

## The 6-Step Protocol

### 1. 🛑 STOP THE LINE

**Immediately halt all work on current task.**

```bash
# Stop what you're doing
git stash  # Save work in progress

# Document the stop
echo "STOPPED: Ruchy language bug found in [component]" >> .stop-the-line.log
```

**Do NOT**:
- ❌ Continue working around the bug silently
- ❌ Assume it's our code error without verification
- ❌ Try multiple workarounds without documenting

### 2. 🔍 REPRODUCE

Create **minimal reproducible example** (< 20 lines).

**Good Example**:
```ruchy
// bug_file_read.ruchy
// Demonstrates file read crash in Ruchy v3.78.0

fun main() {
    let file = File::read("test.txt")  // Crashes here
    println(file)
}
```

**Bad Example** (too complex):
```ruchy
// Don't include 100 lines of our cat implementation
// Don't include unrelated code
// Keep it MINIMAL
```

### 3. 📝 DOCUMENT

Write detailed bug report using template:

```markdown
## Ruchy Language Bug Report

**Component**: ruchy run
**Severity**: blocking
**Ruchy Version**: 3.78.0
**Date Found**: 2025-10-14
**Found During**: Sprint 1, Task S1T2, Chapter 1 (ruchy-cat)

### Minimal Reproducible Example
```ruchy
// bug_file_read.ruchy
fun main() {
    let file = File::read("test.txt")
    println(file)
}
```

### Expected Behavior
Should read file contents and print to stdout.
Reference: Ruchy file I/O docs (if exists).

### Actual Behavior
```
Error: undefined method File::read
    at bug_file_read.ruchy:2:14
```

### Steps to Reproduce
1. Create file: `echo "hello" > test.txt`
2. Create bug_file_read.ruchy with code above
3. Run: `ruchy run bug_file_read.ruchy`
4. Observe error

### Environment
- OS: Linux 6.8.0-85-generic
- Ruchy: v3.78.0
- Rust: 1.75+

### Workaround
Use alternative syntax:
```ruchy
// Workaround using standard library
fun main() {
    let file = std::fs::read_to_string("test.txt")
    println(file)
}
```

### Impact on Project
- **Blocks**: Sprint 1, Task S1T2 (Implement file reading)
- **Affects**: Chapter 1 (ruchy-cat implementation)
- **Estimated Delay**: 2-4 hours while bug is investigated
- **Alternative Approach**: Yes - use workaround above
```

### 4. 🐛 FILE ISSUE

Submit bug report to Ruchy repository:

**Local Repository**:
```bash
cd ../ruchy
# Create issue file or use their process
```

**GitHub Repository**:
- URL: https://github.com/paiml/ruchy/issues
- Create new issue
- Paste bug report template
- Tag appropriately (bug, language, blocking, etc.)

**Get Issue Number**: Note the issue # (e.g., #123)

### 5. 🔧 WORKAROUND

Document temporary solution:

**In Code**:
```ruchy
// WORKAROUND for Ruchy bug #123
// Issue: https://github.com/paiml/ruchy/issues/123
// File::read() not implemented in v3.78.0
// TODO: Replace with File::read() when bug is fixed

fun read_file_workaround(path: String) -> String {
    // Using alternative approach that works
    std::fs::read_to_string(path)
}
```

**In Tests**:
```ruchy
#[test]
fun test_file_read() {
    // NOTE: Using workaround due to Ruchy bug #123
    let contents = read_file_workaround("test.txt")
    assert_eq!(contents, "expected")
}
```

### 6. 📊 TRACK

Update roadmap.yaml with bug tracking:

```yaml
- id: S1T2
  title: "GREEN: Implement basic file reading"
  status: in_progress  # or blocked if no workaround
  blocked_by:
    type: ruchy_language_bug
    issue_number: 123
    issue_url: "https://github.com/paiml/ruchy/issues/123"
    component: "file I/O"
    severity: high  # blocking/high/medium/low
    workaround: "Using std::fs::read_to_string instead of File::read"
    date_filed: "2025-10-14"
    date_resolved: null  # Update when bug is fixed
  notes: |
    File::read() method not implemented in Ruchy v3.78.0.
    Using std::fs::read_to_string as workaround.
    Will refactor to File::read() when bug #123 is resolved.
```

## Severity Levels

| Severity | Description | Action |
|----------|-------------|--------|
| **blocking** | Cannot continue current task at all | Work on different chapter/tool |
| **high** | Workaround exists but painful | Use workaround, continue cautiously |
| **medium** | Minor inconvenience | Document, continue normally |
| **low** | Nice to have fix | Document, no impact on work |

## After Filing Bug

### Continue Development

**If blocking**:
- Work on different CLI tool (e.g., skip cat, do wc instead)
- Work on different chapter
- Work on documentation/book content
- Improve testing infrastructure

**If high/workaround exists**:
- Implement using workaround
- Add comments explaining temporary solution
- Add test case for proper implementation
- Track for future refactor

**If medium/low**:
- Continue normally
- Document the issue
- Nice to have improvement

### Monitor Bug Status

```bash
# Check bug status weekly
cd ../ruchy
git pull
# Check if bug #123 is resolved

# Or check GitHub
open https://github.com/paiml/ruchy/issues/123
```

### Update When Resolved

When bug is fixed:

1. **Update roadmap.yaml**:
```yaml
blocked_by:
  ...
  date_resolved: "2025-10-20"
  resolved_in_version: "3.79.0"
```

2. **Refactor Code**:
```ruchy
// Removed workaround - using proper File::read()
// Bug #123 fixed in Ruchy v3.79.0
fun read_file(path: String) -> String {
    File::read(path)  // Now works correctly!
}
```

3. **Test**:
```bash
ruchy test run examples/ruchy-cat/
```

4. **Commit**:
```bash
git commit -m "FIX: Remove workaround for Ruchy bug #123

- File::read() now works in v3.79.0
- Removed std::fs::read_to_string workaround
- Updated tests to use proper API
- Closes project tracking of bug #123"
```

## Benefits of This Protocol

✅ **For Ruchy Language**:
- Bugs are discovered and reported properly
- Dogfooding improves language quality
- Future users won't hit same issues

✅ **For This Project**:
- Maintains development momentum
- Documents all workarounds clearly
- Tracks bug resolution systematically
- Ensures proper refactoring when bugs fixed

✅ **For Toyota Way**:
- Embodies Jidoka (stop the line on defects)
- Genchi Genbutsu (go and see the actual problem)
- Kaizen (continuous improvement of language)
- Respect for people (help Ruchy developers)

## Examples

### Example 1: Blocking Bug

```
Found: ruchy test framework doesn't support #[test] attribute
Severity: blocking
Action: Cannot write tests for current tool
Solution: Work on different tool, write tests as regular functions for now
Filed: Issue #456 in ruchy repository
Workaround: Write tests as fun test_* functions, run manually
```

### Example 2: High Severity with Workaround

```
Found: ruchy fmt doesn't format pipeline operators correctly
Severity: high
Action: Manual formatting required
Solution: Continue development, format manually
Filed: Issue #789 in ruchy repository
Workaround: Format pipeline code manually until fixed
```

### Example 3: Medium Severity

```
Found: ruchy lint warning messages could be clearer
Severity: medium
Action: No impact on development
Solution: Continue normally, note for future
Filed: Issue #101 in ruchy repository
Workaround: None needed, just less helpful error messages
```

## Quick Reference Card

```
🛑 BUG FOUND IN RUCHY LANGUAGE?

1. STOP - Halt current work
2. REPRODUCE - Create minimal example (< 20 lines)
3. DOCUMENT - Use bug report template
4. FILE - Submit to ../ruchy or GitHub
5. WORKAROUND - Find alternative if possible
6. TRACK - Update roadmap.yaml

Then continue with:
- Blocking: Work on different tool/chapter
- High: Use workaround
- Medium/Low: Continue normally
```

## Related Documentation

- **CLAUDE.md**: Section "0. STOP THE LINE: Bug in Ruchy Language Found"
- **roadmap.yaml**: Metadata section "bug_protocol"
- **docs/specification/**: Section "🛑 CRITICAL: Stop The Line"

---

**Remember**: We're dogfooding Ruchy to help it improve. Every bug we find and report properly makes Ruchy better for everyone! 🚀
