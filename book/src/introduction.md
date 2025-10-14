# Introduction

Welcome to **Ruchy CLI Tools: Building Command-Line Applications with Extreme TDD**!

## What This Book Is About

This book teaches you how to build production-quality command-line interface (CLI) tools using the **Ruchy programming language** while practicing **EXTREME Test-Driven Development** (TDD) inspired by the Toyota Way manufacturing principles.

You'll learn by doing—recreating 10 classic Unix tools:
1. **ruchy-cat** - Concatenate and print files
2. **ruchy-grep** - Search for patterns in text
3. **ruchy-wc** - Count lines, words, and bytes
4. **ruchy-cut** - Extract fields from lines
5. **ruchy-sort** - Sort lines of text
6. **ruchy-uniq** - Remove duplicate lines
7. **ruchy-sed** - Stream editor for transforming text
8. **ruchy-head** - Output first part of files
9. **ruchy-tail** - Output last part of files
10. **ruchy-jq** - JSON query and manipulation

## What Makes This Book Different?

### 1. EXTREME TDD (Not Just TDD)

We don't just write tests—we practice **EXTREME TDD** with:
- **RED**: Write failing test FIRST (always)
- **GREEN**: Minimal code to pass (may be ugly)
- **REFACTOR**: Improve while keeping tests green
- **MUTATION**: Verify test quality (75%+ mutation score required)
- **PROPERTY**: Test invariants (1000+ iterations per property)
- **QUALIFY**: Pass all 15 Ruchy tools (100% compliance)

### 2. Toyota Way Quality Culture

Inspired by Toyota's manufacturing excellence, we apply:
- **Jidoka (Autonomation)**: Stop the line when defects are detected
- **Genchi Genbutsu (Go and See)**: Direct observation and verification
- **Kaizen (Continuous Improvement)**: Always improving quality metrics
- **Respect for People**: Quality documentation and proper bug reports

### 3. Zero Defect Tolerance

Quality is **built-in, not bolted-on**:
- ✅ 85%+ code coverage (minimum)
- ✅ 75%+ mutation score (test quality)
- ✅ Zero clippy warnings
- ✅ Zero SATD markers (no TODO/FIXME/HACK)
- ✅ All 15 Ruchy tools pass
- ✅ Pre-commit hooks block bad code
- ✅ CI/CD enforces all quality gates

### 4. Dogfooding Ruchy

This book is **dogfooding** the Ruchy programming language—we're using Ruchy to showcase what it can do. As early adopters, we'll encounter language bugs and handle them professionally using our "Stop The Line" protocol.

## Who This Book Is For

This book is for developers who want to:
- **Learn Ruchy** through practical, real-world examples
- **Master TDD** at an industrial-strength level
- **Build CLI tools** with production-quality standards
- **Understand quality culture** from Toyota Way principles
- **Experience dogfooding** a new programming language

You should be comfortable with:
- Basic programming concepts (variables, functions, loops)
- Command-line usage (terminal, shell, pipes)
- Software testing fundamentals
- Git and version control

No prior Ruchy experience required!

## How to Use This Book

### Part I: Foundations (Chapters 1-3)
Start here if you're new to Ruchy or EXTREME TDD. Learn the tools, philosophy, and CLI development basics.

### Part II: Building Unix Classics (Chapters 1-10)
The core of the book. Each chapter builds one complete CLI tool from scratch using EXTREME TDD. Follow along in order, or jump to the tool that interests you most.

### Part III: Advanced Topics (Chapters 1-5)
Deep dives into testing strategies, mutation testing, property-based testing, quality gates, and performance optimization.

### Part IV: The Toyota Way (Chapters 1-4)
Learn how Toyota's manufacturing principles apply to software quality. Real-world lessons from dogfooding Ruchy.

### Appendices
Quick reference for Ruchy language, Unix tools, testing patterns, quality metrics, and troubleshooting.

## Code Examples

All code in this book is:
- **Tested**: Every example has comprehensive tests
- **Verified**: All code passes quality gates
- **Executable**: You can run every example
- **Open Source**: Available at [github.com/paiml/ruchy-cli-tools-book](https://github.com/paiml/ruchy-cli-tools-book)

## Conventions Used

### Code Blocks

```ruchy
// Ruchy code examples look like this
fn main() {
    println("Hello, Ruchy!")
}
```

### Annotations

```ruchy
// RED: This test will fail initially
@test("reads file")
fun test_read_file() {
    assert_eq(read_file("test.txt"), "expected content")
}
```

### Quality Notes

> **QUALITY NOTE**: Important quality-related information about testing, coverage, or Toyota Way principles.

### Stop The Line

> **🛑 STOP THE LINE**: Critical quality issues that require immediate attention, just like on a Toyota production line.

### Ruchy Version

This book uses **Ruchy v3.78.0+**. Some features may change as the language evolves.

## Getting Help

- **Ruchy Documentation**: [ruchy-lang.org](https://ruchy-lang.org)
- **Book Repository**: [github.com/paiml/ruchy-cli-tools-book](https://github.com/paiml/ruchy-cli-tools-book)
- **Issues**: Report problems via GitHub Issues
- **Discussions**: Join the Ruchy community

## A Note on Quality

This book practices what it preaches. The entire book project:
- Follows EXTREME TDD methodology
- Enforces quality gates via pre-commit hooks
- Runs comprehensive CI/CD pipelines
- Documents "Stop The Line" events (like [Ruchy bug #30](https://github.com/paiml/ruchy/issues/30))
- Maintains 85%+ code coverage
- Achieves 75%+ mutation scores

You're not just reading about quality—you're seeing it in action.

## Let's Begin!

Ready to build production-quality CLI tools with EXTREME TDD? Let's start with [Part I: Getting Started with Ruchy](./part1/01_getting_started.md).

---

**Remember**: Quality is built-in, not bolted-on. We stop the line when defects are detected. We verify directly through tests. We continuously improve. We respect the craft.

Welcome to EXTREME TDD with Ruchy! 🚀
