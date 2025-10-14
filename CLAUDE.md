# CLAUDE.md - Ruchy CLI Tools Book Project

## Project Identity

**Name**: Ruchy CLI Tools Book
**Goal**: Demonstrate EXTREME TDD practices for building CLI tools IN the Ruchy language
**Language**: Ruchy (`.ruchy` files) - NOT Rust
**Branch Strategy**: Main branch only (no feature branches)
**Quality Philosophy**: Toyota Way - Stop the line on defects, zero tolerance

## CRITICAL: This Project Uses RUCHY Language

**IMPORTANT**: All CLI tools are written in RUCHY, not Rust!
- File extension: `.ruchy`
- Commands: `ruchy run`, `ruchy fmt`, `ruchy lint`, `ruchy check`, `ruchy test`
- Syntax: Similar to Rust + Python (see ../ruchy/examples/*.ruchy)
- Transpiles: Ruchy → Rust → native binary

**Example Ruchy Syntax**:
```ruchy
fun quicksort(arr: [i32]) -> [i32] {
    if arr.len() <= 1 {
        arr
    } else {
        let pivot = arr[0]
        let less = arr >> filter(|x| x < pivot)
        let greater = arr >> filter(|x| x > pivot)
        quicksort(less) + [pivot] + quicksort(greater)
    }
}
```

## CRITICAL RULES (NEVER VIOLATE)

### 0. STOP THE LINE: Bug in Ruchy Language Found

**🛑 JIDOKA (AUTONOMATION) - STOP THE LINE IMMEDIATELY**

If you discover a bug in the Ruchy language itself (compiler, runtime, transpiler, etc.):

1. **STOP ALL WORK** - Halt current development immediately
2. **REPRODUCE** - Create minimal reproducible example
3. **DOCUMENT** - Write detailed bug report
4. **FILE ISSUE** - Report to Ruchy repository (../ruchy)
5. **WORKAROUND** - Document temporary workaround if possible
6. **TRACK** - Add to project tracking (roadmap.yaml)

**Bug Report Template**:
```markdown
## Bug in Ruchy Language

**Component**: [compiler/runtime/transpiler/lint/fmt/etc.]
**Severity**: [blocking/high/medium/low]
**Ruchy Version**: $(ruchy --version)

### Minimal Reproducible Example
```ruchy
// Paste minimal .ruchy code that triggers bug
fun trigger_bug() {
    // ...
}
```

### Expected Behavior
What should happen according to language spec

### Actual Behavior
What actually happens (error message, crash, wrong output)

### Workaround
Temporary solution while bug is fixed (if any)

### Impact on Project
How this blocks current sprint/task
```

**After Filing Bug**:
- Add note to current task in roadmap.yaml
- Document workaround in code comments
- Continue with alternative approach or next task
- Check bug status before resuming blocked work

**This is Toyota Way Jidoka**: Stop the line on defects, don't work around quality issues.

### 1. TDD is MANDATORY
```
RED → GREEN → REFACTOR → MUTATION → PROPERTY → QUALIFY
```

**RED: Write Failing Test FIRST**
- NEVER write production code without a failing test
- Write test in `.ruchy` file (e.g., `cat_test.ruchy`)
- Test MUST fail for the right reason
- Commit message format: `RED: Add test for [feature]`

**GREEN: Minimal Code to Pass**
- Write ONLY enough code to make test pass
- Write implementation in `.ruchy` file (e.g., `cat.ruchy`)
- Ugly code is acceptable at this stage
- Commit message format: `GREEN: Implement [feature]`

**REFACTOR: Improve Code Quality**
- Keep ALL tests passing
- Improve readability, performance, structure
- Run `ruchy fmt` to format code
- Commit message format: `REFACTOR: Improve [component]`

**MUTATION: Verify Test Quality**
- Run `ruchy test run` with comprehensive tests
- Target: 75% minimum, 90% ideal (measured by Ruchy's test framework)
- Commit message format: `MUTATION: Achieve X% test quality on [file]`

**PROPERTY: Test Invariants**
- Add property tests in Ruchy test files
- Test invariants like "output never panics", "idempotent operations"
- Commit message format: `PROPERTY: Add [invariant] test`

**QUALIFY: All 15 Ruchy Tools**
- Run `make dogfood-full`
- Tests: check, transpile, lint, fmt, run, test, wasm, repl, notebook, etc.
- 100% pass rate for applicable tools
- Commit message format: `QUALIFY: Pass all ruchy tools`

### 2. Pre-commit Hooks are SACRED
```bash
# FORBIDDEN COMMAND - NEVER USE
git commit --no-verify
```

**Mandatory Checks (in order):**
1. Format: `ruchy fmt --check` on all `.ruchy` files
2. Lint: `ruchy lint` (ZERO warnings)
3. Fast Tests: `ruchy test run tests/` (<10s)
4. Syntax: `ruchy check` all files
5. SATD: Zero TODO/FIXME/HACK allowed
6. Quality: Follow Ruchy's A+ complexity standards (≤10)

**If hook blocks you:**
- Fix the issue (don't bypass)
- Run `make validate` to see details
- Ask for help if stuck

### 3. Quality Gates are BLOCKING

**Level 1: Pre-commit (Automated)**
```bash
make install-hooks  # Run once to setup
# Then every commit automatically checks
```

**Level 2: Manual Validation**
```bash
make validate  # Before pushing
make ci        # Full validation (slow)
```

**Level 3: GitHub Actions (Continuous)**
- Runs on every push to main
- Blocks merge if any check fails
- Deploys book on success

### 4. Zero Technical Debt Tolerance

**FORBIDDEN Markers:**
```rust
// TODO: Fix this later  ❌
// FIXME: Hack for now  ❌
// HACK: Temporary solution  ❌
```

**Allowed Approach:**
```rust
// Create GitHub issue #42 for performance optimization
// Current implementation is O(n²), target O(n log n)
```

### 5. Testing Standards

**Coverage Target: 85%+**
```bash
make coverage  # Generate report
```

**Mutation Score: 75%+ (90% ideal)**
```bash
make test-mutations-incremental
```

**Property Tests: 80% of modules**
```bash
make test-property
```

**CLI Tests: All examples**
```bash
make test-cli-examples
```

## Development Workflow

### Starting a New Feature

1. **Create Failing Test**
```bash
# Edit tests/test_feature_test.ruchy or examples/tool/tool_test.ruchy
ruchy test run tests/  # Should FAIL
git add tests/test_feature_test.ruchy
git commit -m "RED: Add test for feature_name"
```

2. **Implement Feature**
```bash
# Edit examples/tool/tool.ruchy
ruchy test run tests/  # Should PASS
git add examples/tool/tool.ruchy
git commit -m "GREEN: Implement feature_name"
# Pre-commit hooks run automatically
```

3. **Refactor if Needed**
```bash
# Improve code quality
ruchy fmt examples/tool/tool.ruchy
ruchy test run tests/  # All tests still pass
git add examples/tool/tool.ruchy
git commit -m "REFACTOR: Clean up feature_name implementation"
```

4. **Property Testing**
```bash
# Add property tests in Ruchy test files
# Test invariants like never panic, idempotent, etc.
ruchy test run tests/
git add tests/property_feature_test.ruchy
git commit -m "PROPERTY: Add no-panic invariant for feature"
```

5. **Full Qualification**
```bash
make dogfood-full
git add .
git commit -m "QUALIFY: Pass all 15 ruchy tools"
```

### Daily Workflow

```bash
# Morning
git pull
make validate  # Ensure clean state

# Development cycle (repeat)
make test-fast  # Quick feedback (<10s)
# Write code...
make validate   # Pre-push check

# End of day
make ci         # Full validation
git push        # Triggers GitHub Actions
```

## Makefile Commands (Primary Interface)

### Fast Feedback (<10s)
```bash
make format       # Format Ruchy code
make lint         # Lint Ruchy code
make test-fast    # Unit tests
make validate     # format + lint + test-fast
```

### Comprehensive Testing (<5 min)
```bash
make test-all           # All tests
make test-examples      # Test all CLI examples
```

### Quality Analysis
```bash
make dogfood-full      # Test all 15 ruchy tools
make quality-gate      # All blocking quality checks
make quality-report    # Generate metrics report
```

### Full CI Pipeline
```bash
make ci  # validate + test-all + dogfood + quality-gate
```

### Book Operations
```bash
make book-build    # Build book
make book-serve    # Serve locally at localhost:3000
make book-test     # Test all examples in book
make book-deploy   # Build + test + deploy (GitHub Actions)
```

### Infrastructure
```bash
make install-hooks  # Setup pre-commit hooks
make clean          # Clean build artifacts
make help           # Show all available commands
```

## Project Structure

```
ruchy-cli-tools-book/
├── CLAUDE.md              # This file
├── README.md
├── LICENSE
├── Makefile               # Primary interface
├── roadmap.yaml           # Sprint planning
├── .gitignore
├── scripts/               # Pre-commit hooks
│   └── pre-commit-hook.sh
├── docs/
│   ├── specification/
│   │   └── ruchy-cli-tools-book.md
│   └── reports/           # Generated quality reports
├── book/
│   ├── book.toml          # mdBook config
│   └── src/
│       ├── SUMMARY.md
│       ├── introduction.md
│       └── chapter_*.md
├── examples/              # Ruchy CLI tools
│   ├── ruchy-cat/
│   │   ├── cat.ruchy          # Implementation
│   │   └── cat_test.ruchy     # Tests
│   ├── ruchy-grep/
│   ├── ruchy-wc/
│   └── ... (10 tools total)
├── tests/                 # Additional test files
│   └── *.ruchy
├── tools/                 # Helper utilities
└── .github/
    └── workflows/
        ├── ci.yml
        └── book-deploy.yml
```

## Testing Patterns

### Unit Test (Red Phase)
```ruchy
// cat_test.ruchy
#[test]
fun test_read_single_file() {
    let result = read_file("test.txt")
    assert!(result.is_ok())
    assert_eq!(result.unwrap(), "expected content")
}

#[test]
fun test_concatenate_multiple_files() {
    let files = ["file1.txt", "file2.txt"]
    let result = cat(files)
    assert!(result.is_ok())
}
```

### Property Test (Invariants)
```ruchy
// cat_test.ruchy
#[test]
fun property_never_panics() {
    // Test that cat never panics with any input
    for i in 0..1000 {
        let random_files = generate_random_filenames(i)
        let result = cat(random_files)
        // Should return Ok or Err, never panic
        assert!(result.is_ok() || result.is_err())
    }
}

#[test]
fun property_idempotent_output() {
    // cat file.txt | cat should equal cat file.txt
    let content1 = read_file("test.txt").unwrap()
    let content2 = cat(["test.txt"]).unwrap()
    assert_eq!(content1, content2)
}
```

### Integration Test
```ruchy
// integration_test.ruchy
#[test]
fun test_cli_help() {
    let output = run_command("ruchy-cat --help")
    assert!(output.contains("USAGE:"))
    assert!(output.contains("ruchy-cat"))
}

#[test]
fun test_error_on_missing_file() {
    let output = run_command("ruchy-cat nonexistent.txt")
    assert!(output.is_err())
    assert!(output.err().contains("No such file"))
}
```

## Commit Message Convention

```
RED: Add test for [feature]
GREEN: Implement [feature]
REFACTOR: Improve [component]
MUTATION: Achieve X% score on [file]
PROPERTY: Add [invariant] test
QUALIFY: Pass all ruchy tools
DOCS: Update [documentation]
INFRA: Setup [infrastructure]
FIX: Resolve [issue]
```

**Examples:**
```
RED: Add test for flag parsing with multiple arguments
GREEN: Implement basic flag parser using clap
REFACTOR: Extract validation logic to separate module
MUTATION: Achieve 87% score on parser.rs
PROPERTY: Add no-panic invariant for all inputs
QUALIFY: Pass all 15 ruchy tools (14/14 applicable)
```

## Quality Metrics Dashboard

Track these metrics over time:

| Metric | Target | Current |
|--------|--------|---------|
| Code Coverage | 85%+ | TBD |
| Mutation Score | 75%+ | TBD |
| Property Tests | 80% modules | TBD |
| Clippy Warnings | 0 | TBD |
| SATD Markers | 0 | TBD |
| Complexity (Cyclomatic) | ≤10 | TBD |
| Complexity (Cognitive) | ≤15 | TBD |
| TDG Score | A- (85+) | TBD |
| Build Time | <2 min | TBD |
| Test Time (fast) | <10s | TBD |
| Test Time (all) | <5 min | TBD |

## Book Content Style

The book will follow **[STYLE TO BE DETERMINED]** approach:

**Option 1: Tutorial Style**
- Build one complete CLI tool across all chapters
- Progressive feature addition
- Single coherent example

**Option 2: Pattern Library**
- Each chapter shows different CLI patterns
- Flags, subcommands, pipes, etc.
- Multiple independent examples

**Option 3: Real-World Clones**
- Recreate famous CLI tools (grep, sed, jq)
- Show Ruchy implementation
- Compare with originals

**Option 4: Domain-Specific**
- Focus on one domain (data pipelines, DevOps, etc.)
- Build related tools
- Show integration patterns

## 15 Ruchy Tools Qualification

Every example MUST pass these tools:

1. ✓ `ruchy check` - Syntax validation
2. ✓ `ruchy transpile` - Code generation
3. ✓ `ruchy -e` - REPL evaluation
4. ✓ `ruchy lint` - Style checking
5. ✓ `ruchy compile` - Full compilation
6. ✓ `ruchy run` - Execution
7. ✓ `ruchy coverage` - Test coverage
8. ✓ `ruchy runtime --bigo` - Performance analysis
9. ✓ `ruchy ast` - AST inspection
10. ✓ `ruchy wasm` - WASM compilation (if applicable)
11. ✓ `ruchy provability` - Formal verification (if applicable)
12. ✓ `ruchy property-tests` - Property test generation
13. ✓ `ruchy mutations` - Mutation testing wrapper
14. ✓ `ruchy fuzz` - Fuzz testing
15. ✓ `ruchy notebook` - Interactive notebook

## Troubleshooting

### Pre-commit Hook Fails
```bash
make validate  # See detailed errors
cargo fmt      # Fix formatting
cargo clippy --fix  # Fix lints
cargo test     # Fix failing tests
```

### Coverage Decreased
```bash
make coverage  # Generate report
open target/coverage/html/index.html
# Add tests for uncovered lines
```

### Mutation Score Low
```bash
cargo mutants --file src/path/file.rs
# Review uncaught mutants
# Add tests for gaps
```

### Build Too Slow
```bash
cargo clean
cargo build --release -j $(nproc)
# Consider using sccache
```

## Resources

- **Specification**: `docs/specification/ruchy-cli-tools-book.md`
- **Roadmap**: `roadmap.yaml`
- **Makefile**: Primary command interface
- **Reference Projects**:
  - `../ruchy` - Testing patterns
  - `../ruchy-book` - Book structure
  - `../rosetta-ruchy` - Example patterns
  - `../paiml-mcp-agent-toolkit` - Quality infrastructure

## Contact & Support

- **Issues**: GitHub Issues (track bugs, features, questions)
- **Discussions**: GitHub Discussions (architecture, design decisions)
- **CI Status**: GitHub Actions tab

## Version History

- **v0.1.0** (2025-10-14): Initial CLAUDE.md created
