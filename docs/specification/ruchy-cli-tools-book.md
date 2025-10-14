# Ruchy CLI Tools Book - Technical Specification

## Project Overview

A comprehensive book on writing CLI tools **in the Ruchy programming language**, built using EXTREME TDD practices that demonstrate the complete RED-GREEN-REFACTOR cycle with industrial-grade quality enforcement.

## Language: Ruchy (NOT Rust)

**CRITICAL**: This project uses the **Ruchy programming language**, not Rust.

- **Language**: Ruchy v3.78.0+
- **File Extension**: `.ruchy`
- **Test Files**: `*_test.ruchy`
- **Compiler**: Self-hosting Ruchy compiler (written in Rust)
- **Transpilation**: Ruchy → Rust → native binary
- **Installation**: `cargo install ruchy`

## Core Philosophy

This project follows the **Toyota Way** manufacturing principles adapted for software:
- **Jidoka (Autonomation)**: Stop the line on defects - pre-commit hooks BLOCK bad code
- **Genchi Genbutsu (Go and See)**: Verify quality directly through tests, not assumptions
- **Kaizen (Continuous Improvement)**: Every commit improves quality metrics
- **Zero Defect Tolerance**: 100% compliance with all quality gates

### 🛑 CRITICAL: Stop The Line - Ruchy Language Bugs

**Jidoka Applied to Language Bugs**

If a bug is discovered in the Ruchy language itself (compiler, runtime, transpiler, any of the 15 tools):

**MANDATORY PROTOCOL**:

1. **🛑 STOP THE LINE** - Halt all development work immediately
2. **🔍 REPRODUCE** - Create minimal reproducible example (< 20 lines)
3. **📝 DOCUMENT** - Write detailed bug report with template below
4. **🐛 FILE ISSUE** - Submit to Ruchy repository: https://github.com/paiml/ruchy
5. **🔧 WORKAROUND** - Document temporary workaround if possible
6. **📊 TRACK** - Add bug tracking entry to roadmap.yaml

**Bug Report Template**:
```markdown
## Ruchy Language Bug Report

**Component**: [compiler/runtime/transpiler/ruchy-lint/ruchy-fmt/ruchy-test/etc.]
**Severity**: [blocking/high/medium/low]
**Ruchy Version**: 3.78.0
**Date Found**: YYYY-MM-DD
**Found During**: [Sprint X, Task Y, Chapter Z]

### Minimal Reproducible Example (< 20 lines)
```ruchy
// file: bug_reproduction.ruchy
fun demonstrate_bug() {
    // Minimal code that triggers the bug
    let x = 42
    // ... exact code that fails
}
```

### Expected Behavior
According to Ruchy language specification or reasonable expectation:
- What SHOULD happen
- Reference to docs if applicable

### Actual Behavior
What actually happens:
- Exact error message (copy/paste)
- Stack trace if available
- Wrong output if applicable

### Steps to Reproduce
1. Create file bug_reproduction.ruchy with code above
2. Run: `ruchy [command] bug_reproduction.ruchy`
3. Observe: [error/crash/wrong output]

### Environment
- OS: Linux/macOS/Windows
- Ruchy version: `ruchy --version`
- Rust version: `rustc --version`

### Workaround (if any)
Temporary solution to unblock development:
```ruchy
// Alternative approach that works
fun workaround() {
    // ...
}
```

### Impact on Project
- **Blocks**: Sprint X, Task Y
- **Affects**: Chapter Z implementation
- **Estimated Delay**: X days/hours
- **Alternative Approach**: [yes/no] - describe if yes
```

**After Filing Bug**:

1. **Update roadmap.yaml**:
```yaml
- id: S1T2
  title: "GREEN: Implement basic file reading"
  status: blocked
  blocked_by:
    type: ruchy_language_bug
    issue_url: "https://github.com/paiml/ruchy/issues/XXX"
    severity: blocking
    workaround: "Use alternative syntax (see code comments)"
    date_filed: "2025-10-14"
```

2. **Document in Code**:
```ruchy
// WORKAROUND for Ruchy bug #XXX
// Issue: https://github.com/paiml/ruchy/issues/XXX
// TODO: Replace with proper syntax when bug is fixed
fun workaround_implementation() {
    // Temporary solution
}
```

3. **Continue Development**:
   - If **blocking**: Work on different tool/chapter
   - If **high**: Use workaround, continue with caution
   - If **medium/low**: Document, continue normally

**This ensures**:
- ✅ Ruchy language quality improves (we're dogfooding!)
- ✅ Bugs are properly tracked and resolved
- ✅ Project maintains momentum
- ✅ Future users won't hit same issues

## Quality Enforcement Hierarchy

### Level 1: BLOCKING (Pre-commit Hooks)
```
Format → Lint → Fast Tests → Coverage Baseline → Complexity → SATD Check
```
All must pass BEFORE commit is allowed. `--no-verify` is FORBIDDEN.

### Level 2: VALIDATION (Make Targets)
```
make validate: format lint test-fast coverage quality-gate
make ci: validate test-all mutation-test dogfood
```

### Level 3: CONTINUOUS (GitHub Actions)
```
On Push: validate → test-all → mutation-test → dogfood → build-book → deploy
On PR: validate → test-all → generate-report
```

## Extreme TDD Workflow

### A. RED: Write Failing Test FIRST
```ruchy
// cat_test.ruchy
#[test]
fun test_read_valid_file() {
    let result = read_file("test.txt")
    assert!(result.is_ok())  // FAILS - read_file doesn't exist yet
    assert_eq!(result.unwrap(), "expected content")
}
```

**Requirements:**
- Test MUST fail for the right reason (missing code, not syntax error)
- Test MUST be verifiable via `ruchy test run`
- Commit message: `RED: Add test for read_file function`

### B. GREEN: Write MINIMAL Code to Pass
```ruchy
// cat.ruchy
fun read_file(path: String) -> Result<String> {
    // Minimal implementation
    Ok("expected content")
}
```

**Requirements:**
- Code MUST pass the test
- Code MAY be ugly/hard-coded (we'll refactor next)
- Commit message: `GREEN: Implement basic read_file`

### C. REFACTOR: Improve While Maintaining Green
```ruchy
// cat.ruchy
fun read_file(path: String) -> Result<String> {
    // Proper implementation with actual file I/O
    match File::read(path) {
        Ok(contents) => Ok(contents),
        Err(e) => Err(f"Failed to read {path}: {e}")
    }
}
```

**Requirements:**
- ALL tests still pass
- Code quality improves (readability, real implementation, structure)
- Run `ruchy fmt` to format code
- Commit message: `REFACTOR: Implement actual file reading`

### D. MUTATION TEST: Verify Test Quality
```bash
ruchy test run examples/ruchy-cat/ --comprehensive
```

**Requirements:**
- Comprehensive test coverage (75% minimum, 90% target)
- Test all error paths and edge cases
- Commit message: `MUTATION: Add comprehensive test coverage`

### E. PROPERTY TEST: Verify Invariants
```ruchy
// cat_test.ruchy
#[test]
fun property_never_panics() {
    // Test with 1000+ random inputs
    for i in 0..1000 {
        let random_path = generate_random_path(i)
        let result = read_file(random_path)
        // Should return Ok or Err, never panic
        assert!(result.is_ok() || result.is_err())
    }
}
```

**Requirements:**
- 1,000+ iterations per property
- Cover edge cases: empty paths, special characters, huge files
- Commit message: `PROPERTY: Add no-panic invariant for read_file`

### F. QUALIFICATION: All 15 Ruchy Tools
```bash
make dogfood-full
```

**All 15 Tools Must Pass:**
1. `ruchy check` - Syntax validation
2. `ruchy transpile` - Code generation
3. `ruchy -e` - REPL evaluation
4. `ruchy lint` - Style checking
5. `ruchy compile` - Full compilation
6. `ruchy run` - Execution
7. `ruchy coverage` - Test coverage
8. `ruchy runtime --bigo` - Performance analysis
9. `ruchy ast` - AST inspection
10. `ruchy wasm` - WASM compilation
11. `ruchy provability` - Formal verification
12. `ruchy property-tests` - Property test generation
13. `ruchy mutations` - Mutation testing wrapper
14. `ruchy fuzz` - Fuzz testing
15. `ruchy notebook` - Interactive notebook

**Requirements:**
- 100% pass rate for applicable tools
- Document which tools don't apply (e.g., WASM for non-WASM project)
- Commit message: `QUALIFY: Pass all 15 ruchy tools (14/14 applicable)`

## Testing Infrastructure

### Unit Tests (Fast - <10s)
```makefile
test-fast:
	ruchy test run tests/
```

### Integration Tests
```makefile
test-examples:
	ruchy test run examples/ruchy-cat/
	ruchy test run examples/ruchy-grep/
	# ... all tools
```

### Property Tests
```ruchy
// In *_test.ruchy files
#[test]
fun property_idempotent() {
    for i in 0..1000 {
        let input = generate_random_input(i)
        let result1 = process(input)
        let result2 = process(input)
        assert_eq!(result1, result2)  // Idempotent
    }
}
```

### CLI Example Tests
```ruchy
// integration_test.ruchy
#[test]
fun test_cli_help_output() {
    let output = run_command("ruchy-cat --help")
    assert!(output.contains("USAGE:"))
    assert!(output.contains("ruchy-cat"))
}

#[test]
fun test_cli_reads_file() {
    create_test_file("test.txt", "hello world")
    let output = run_command("ruchy-cat test.txt")
    assert_eq!(output, "hello world")
}
```

### End-to-End Tests
```makefile
test-e2e:
	ruchy run examples/ruchy-cat/cat.ruchy test.txt
	ruchy run examples/ruchy-grep/grep.ruchy "pattern" file.txt
	# ... test all tools work correctly
```

## Book Structure

```
book/
├── src/
│   ├── SUMMARY.md
│   ├── introduction.md
│   ├── chapter_01_setup.md
│   ├── chapter_02_parsing.md
│   ├── chapter_03_validation.md
│   ├── chapter_04_execution.md
│   ├── chapter_05_testing.md
│   ├── chapter_06_mutation.md
│   ├── chapter_07_property.md
│   ├── chapter_08_quality.md
│   └── appendix_tools.md
├── examples/
│   ├── 01_hello/
│   ├── 02_parser/
│   ├── 03_validator/
│   └── ...
└── theme/
```

## Example Styles (4 Options - See Below)

The book will follow ONE of these example progression styles:
1. **Tutorial Style**: Build one complete CLI tool across all chapters
2. **Pattern Library**: Each chapter shows different CLI patterns (flags, subcommands, pipes)
3. **Real-World Clones**: Recreate famous CLI tools (grep, sed, jq) in Ruchy
4. **Domain-Specific**: Focus on one domain (e.g., data processing pipelines)

## Roadmap Structure

All work MUST be tracked in `roadmap.yaml` with this format:

```yaml
sprints:
  - number: 1
    goal: "Setup project infrastructure"
    tasks:
      - id: S1T1
        title: "Create Makefile with quality gates"
        status: pending
        type: infrastructure
        test_required: false

      - id: S1T2
        title: "Setup pre-commit hooks"
        status: pending
        type: infrastructure
        test_required: true  # Test hook blocks bad commits

  - number: 2
    goal: "RED: Write failing parser tests"
    tasks:
      - id: S2T1
        title: "Test: Parse --verbose flag"
        status: pending
        type: test
        test_required: true
        mutation_target: 85
        property_tests: 1
```

## PMAT Quality Enforcement

### Required Configuration (.pmat-gates.toml)
```toml
[gates.test]
enabled = true
minimum_coverage = 85.0

[gates.lint]
enabled = true
max_warnings = 0

[gates.complexity]
enabled = true
max_cyclomatic = 10
max_cognitive = 15

[gates.mutations]
enabled = true
minimum_score = 75.0

[gates.satd]
enabled = true
allowed_tags = []  # Zero TODO/FIXME/HACK
```

## GitHub Actions Workflow

### On Every Push to Main
1. Run `make validate` (format, lint, fast tests)
2. Run `make test-all` (unit, integration, property)
3. Run `make mutation-test` (incremental)
4. Run `make dogfood-full` (15 tools)
5. Build book with `mdbook build`
6. Test all book examples
7. Deploy to GitHub Pages

### On Pull Requests
1. Run `make validate`
2. Run `make test-all`
3. Generate mutation testing report
4. Post coverage/quality report as comment

## Pre-commit Hook Configuration

Installed via: `make install-hooks`

**Checks (in order):**
1. `cargo fmt -- --check` (format)
2. `cargo clippy -- -D warnings` (lint)
3. `cargo test --lib` (fast tests)
4. Coverage baseline check
5. Complexity analysis
6. SATD check (zero tolerance)
7. TDG score (minimum A-)

**Enforcement:**
- All checks MUST pass
- Hook is MANDATORY (tracked in repo)
- `--no-verify` is FORBIDDEN (documented in CLAUDE.md)

## CLI Testing with Rexpect/Assert_cmd

### Standard CLI Test Pattern
```rust
#[test]
fn test_cli_verbose_output() {
    Command::cargo_bin("ruchy-tool")
        .unwrap()
        .arg("--verbose")
        .arg("input.txt")
        .assert()
        .success()
        .stdout(predicate::str::contains("Processing input.txt"));
}
```

### Interactive REPL Test Pattern (Rexpect)
```rust
use rexpect::spawn;

#[test]
fn test_repl_session() {
    let mut p = spawn("ruchy-repl", Some(5000)).unwrap();
    p.exp_string("ruchy>").unwrap();
    p.send_line("(+ 1 2)").unwrap();
    p.exp_string("3").unwrap();
}
```

## Success Criteria

### Per Chapter
- [ ] All examples compile and run
- [ ] 85%+ code coverage
- [ ] 75%+ mutation score
- [ ] Zero clippy warnings
- [ ] Zero SATD markers
- [ ] All property tests pass (10K+ iterations)
- [ ] All CLI tests pass (assert_cmd/rexpect)
- [ ] 14/14 applicable ruchy tools pass

### Per Commit
- [ ] Pre-commit hooks pass
- [ ] Tests added BEFORE code (TDD)
- [ ] Commit message follows convention (RED/GREEN/REFACTOR/MUTATION/PROPERTY/QUALIFY)

### Project-Wide
- [ ] Book builds successfully
- [ ] All examples in book are tested
- [ ] GitHub Pages deployment works
- [ ] Makefile orchestrates all workflows
- [ ] Documentation is comprehensive

## Technology Stack

### Core
- **Language**: Ruchy v3.78.0+ (for ALL CLI tools)
- **Compiler**: Ruchy self-hosting compiler (transpiles to Rust)
- **File Extension**: `.ruchy`
- **Book**: mdBook + mdbook-linkcheck
- **Testing**: Ruchy's built-in test framework
- **Property Tests**: Written in Ruchy test files
- **CLI Testing**: Ruchy integration tests
- **Quality**: All 15 Ruchy tools (check, lint, fmt, test, etc.)

### CI/CD
- **Version Control**: Git (main branch only)
- **CI**: GitHub Actions (using `ruchy` commands)
- **Deployment**: GitHub Pages
- **Hooks**: Git pre-commit hooks (using `ruchy` commands)

### Development
- **Build**: `ruchy` + `make`
- **Format**: `ruchy fmt`
- **Lint**: `ruchy lint`
- **Test**: `ruchy test run`
- **Check**: `ruchy check`
- **Run**: `ruchy run`
- **Orchestration**: Makefile (primary interface)

## Non-Goals (Out of Scope)

- Branching strategies (main only)
- Multiple language examples (Rust only)
- GUI tools (CLI only)
- Deployment beyond GitHub Pages
- Package distribution (crates.io, Homebrew, etc.)
- Windows-specific testing (Linux/macOS focus)

## Maintenance

### Continuous Improvement (Kaizen)
- Track quality metrics over time
- Improve mutation scores incrementally
- Refactor for better test coverage
- Document lessons learned

### Zero Technical Debt
- No TODO/FIXME/HACK markers allowed
- All warnings treated as errors
- Immediate fix or revert on quality regression
- Regular dependency updates

## References

- **paiml-mcp-agent-toolkit**: Makefile patterns, PMAT integration
- **ruchy**: Testing infrastructure, mutation testing approach
- **ruchy-book**: Book structure, mdBook configuration
- **rosetta-ruchy**: Example patterns, dogfooding strategy

## Version History

- **v0.1.0** (2025-10-14): Initial specification created
