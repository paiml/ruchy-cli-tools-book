# Ruchy CLI Tools Book

A comprehensive book on writing CLI tools **in the Ruchy programming language**, built using **EXTREME TDD** practices that demonstrate the complete RED-GREEN-REFACTOR cycle with industrial-grade quality enforcement.

## ⚠️ IMPORTANT: This Project Uses the Ruchy Language

**NOT Rust!** All CLI tools are written in **Ruchy** (`.ruchy` files).

- **Language**: Ruchy v3.78.0+
- **File Extension**: `.ruchy`
- **Test Files**: `*_test.ruchy`
- **Commands**: `ruchy run`, `ruchy fmt`, `ruchy lint`, `ruchy test`
- **Install Ruchy**: `cargo install ruchy`

## Project Status

**Phase:** Infrastructure Setup Complete
**Language:** Ruchy (NOT Rust)
**Current Sprint:** Sprint 0 - Infrastructure & Setup
**Next Sprint:** Sprint 1 - Chapter 1: ruchy-cat

## Quick Start

```bash
# Prerequisites: Install Ruchy compiler
cargo install ruchy

# Verify installation
make check-ruchy

# Install pre-commit hooks (REQUIRED)
make install-hooks

# Fast feedback loop (<10s)
make validate

# Run all tests
make test-all

# Test all 15 Ruchy tools on examples
make dogfood-full

# Build and serve book
make book-serve
```

## Project Philosophy: EXTREME TDD

This project follows the **Toyota Way** manufacturing principles:
- **Jidoka (Stop the Line)**: Pre-commit hooks BLOCK bad code
- **Genchi Genbutsu (Go and See)**: Verify quality through tests, not assumptions
- **Kaizen (Continuous Improvement)**: Every commit improves quality
- **Zero Defects**: 100% compliance with all quality gates

## TDD Workflow

```
RED → GREEN → REFACTOR → MUTATION → PROPERTY → QUALIFY
```

1. **RED**: Write failing test FIRST
2. **GREEN**: Write minimal code to pass
3. **REFACTOR**: Improve code quality while tests pass
4. **MUTATION**: Verify test quality (75%+ score)
5. **PROPERTY**: Add property tests (10,000+ iterations)
6. **QUALIFY**: Pass all 15 ruchy tools

## Quality Metrics

| Metric | Target | Status |
|--------|--------|--------|
| Code Coverage | 85%+ | TBD |
| Mutation Score | 75%+ | TBD |
| Property Tests | 80% modules | TBD |
| Clippy Warnings | 0 | ✓ |
| SATD Markers | 0 | ✓ |
| Complexity (Cyclomatic) | ≤10 | TBD |

## Book Content

This book teaches CLI development by **recreating Unix classics using the Ruchy programming language**:

### Example Ruchy Syntax

```ruchy
// quicksort.ruchy - From ../ruchy/examples
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

### Chapters

1. **ruchy-cat** - Concatenate files (Simple) - `.ruchy` implementation
2. **ruchy-grep** - Pattern matching (Medium) - with Ruchy regex
3. **ruchy-wc** - Word count (Simple) - Ruchy file I/O
4. **ruchy-cut** - Column extraction (Medium) - Ruchy string processing
5. **ruchy-sort** - Sorting lines (Medium) - Ruchy collections
6. **ruchy-uniq** - Deduplicate lines (Simple) - Ruchy algorithms
7. **ruchy-sed** - Stream editor basics (High) - Ruchy parsing
8. **ruchy-head** - First N lines (Simple) - Ruchy iterators
9. **ruchy-tail** - Last N lines (Medium) - Ruchy buffers
10. **ruchy-jq** - JSON query (High) - Ruchy JSON handling
11. **Pipeline Integration** - Real-world Ruchy usage
12. **Appendix** - Ruchy language reference

## Project Structure

```
ruchy-cli-tools-book/
├── CLAUDE.md                    # Project-specific AI assistant instructions
├── README.md                    # This file
├── roadmap.yaml                 # Sprint planning and task tracking
├── Makefile                     # Primary command interface (uses 'ruchy' commands)
├── docs/
│   ├── specification/           # Technical specifications
│   └── reports/                 # Generated quality reports
├── book/
│   ├── book.toml               # mdBook configuration
│   └── src/                    # Book content
├── examples/                   # Ruchy CLI tools (.ruchy files)
│   ├── ruchy-cat/
│   │   ├── cat.ruchy           # Implementation
│   │   └── cat_test.ruchy      # Tests
│   ├── ruchy-grep/
│   ├── ruchy-wc/
│   └── ...                    # 10 tools total
├── tests/                      # Additional test files (*.ruchy)
├── tools/                      # Helper utilities
├── scripts/
│   └── pre-commit-hook.sh     # Quality enforcement (uses 'ruchy' commands)
└── .github/
    └── workflows/
        ├── ci.yml             # Continuous integration (uses 'ruchy' commands)
        └── book-deploy.yml    # Book deployment
```

## Available Commands

### Fast Feedback (<10s)
```bash
make format          # Format Ruchy code (ruchy fmt)
make lint            # Lint Ruchy code (ruchy lint)
make test-fast       # Unit tests (ruchy test run)
make validate        # format + lint + test-fast
make check-ruchy     # Verify Ruchy installation
```

### Comprehensive Testing
```bash
make test-all          # All tests
make test-examples     # Test all CLI examples
make dogfood-full      # Test with all 15 Ruchy tools
```

### Quality Analysis
```bash
make quality-gate      # All blocking quality checks
make quality-report    # Generate metrics report
```

### Book Operations
```bash
make book-build    # Build book
make book-serve    # Serve at localhost:3000
make book-test     # Test all examples
```

### Full CI
```bash
make ci  # Complete validation pipeline
```

## Pre-commit Hooks

Pre-commit hooks are **MANDATORY** and enforce:
1. Code formatting (rustfmt)
2. Zero clippy warnings
3. Fast tests pass
4. Coverage maintained
5. Zero SATD markers (TODO/FIXME/HACK)

**Installation:**
```bash
make install-hooks
```

**FORBIDDEN COMMAND:**
```bash
git commit --no-verify  # NEVER USE THIS
```

## Testing Frameworks

- **Unit/Integration**: `ruchy test run` (Ruchy's built-in test framework)
- **Property Tests**: Written in Ruchy test files with property test patterns
- **CLI Tests**: Integration tests using Ruchy
- **Quality Tools**: All 15 Ruchy tools (check, lint, fmt, transpile, run, test, wasm, repl, notebook, etc.)

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

## Documentation

- **Specification**: [docs/specification/ruchy-cli-tools-book.md](docs/specification/ruchy-cli-tools-book.md)
- **Project Guide**: [CLAUDE.md](CLAUDE.md)
- **Roadmap**: [roadmap.yaml](roadmap.yaml)
- **Book**: Built via `make book-serve`

## GitHub Actions

### CI Workflow (on push/PR)
- Format check
- Lint check
- All tests
- Coverage check (85%+ threshold)
- Quality gates
- Mutation testing (incremental)

### Book Deploy Workflow (on push to main)
- Build book with mdBook
- Test all examples
- Deploy to GitHub Pages

## Development Workflow

```bash
# Morning
git pull
make check-ruchy  # Verify Ruchy is installed
make validate

# Development cycle (repeat)
# 1. Write failing test (RED)
# Edit examples/ruchy-cat/cat_test.ruchy
ruchy test run examples/ruchy-cat/  # Should FAIL
git add examples/ && git commit -m "RED: Add test for feature_name"

# 2. Write minimal code (GREEN)
# Edit examples/ruchy-cat/cat.ruchy
ruchy test run examples/ruchy-cat/  # Should PASS
git add examples/ && git commit -m "GREEN: Implement feature_name"

# 3. Improve code (REFACTOR)
ruchy fmt examples/ruchy-cat/cat.ruchy
make validate  # All tests still pass
git add examples/ && git commit -m "REFACTOR: Clean up feature_name"

# 4. Property testing
# Add property tests to cat_test.ruchy
ruchy test run examples/ruchy-cat/
git add examples/ && git commit -m "PROPERTY: Add invariants"

# 5. Qualification
make dogfood-full  # Test with all 15 Ruchy tools
git commit -m "QUALIFY: Pass all ruchy tools"

# End of day
make ci         # Full validation
git push
```

## Contributing

This project follows strict TDD practices:
1. **Test First**: Always write test before code
2. **Quality Gates**: All pre-commit checks must pass
3. **Zero Defects**: No TODO/FIXME/HACK markers
4. **Main Only**: No feature branches
5. **Documentation**: Code is self-documenting + tests

## Resources

- **Reference Projects**:
  - [ruchy](https://github.com/YOUR_ORG/ruchy) - Testing patterns
  - [ruchy-book](https://github.com/YOUR_ORG/ruchy-book) - Book structure
  - [rosetta-ruchy](https://github.com/YOUR_ORG/rosetta-ruchy) - Examples
  - [paiml-mcp-agent-toolkit](https://github.com/YOUR_ORG/paiml-mcp-agent-toolkit) - Quality infrastructure

## License

MIT OR Apache-2.0

## Contact

- **Issues**: GitHub Issues
- **Discussions**: GitHub Discussions
- **CI Status**: GitHub Actions tab

---

**Built with EXTREME TDD** | **Zero Defect Tolerance** | **Toyota Way Principles**
