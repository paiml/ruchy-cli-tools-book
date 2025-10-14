# Summary

[Introduction](./introduction.md)

# Part I: Foundations

- [Getting Started with Ruchy](./part1/01_getting_started.md)
  - [Installing Ruchy](./part1/01_getting_started.md#installing-ruchy)
  - [Your First Ruchy Program](./part1/01_getting_started.md#your-first-program)
  - [The 15 Ruchy Tools](./part1/01_getting_started.md#the-15-tools)

- [EXTREME TDD Philosophy](./part1/02_extreme_tdd.md)
  - [The Toyota Way](./part1/02_extreme_tdd.md#the-toyota-way)
  - [RED-GREEN-REFACTOR Cycle](./part1/02_extreme_tdd.md#red-green-refactor)
  - [Mutation Testing](./part1/02_extreme_tdd.md#mutation-testing)
  - [Property-Based Testing](./part1/02_extreme_tdd.md#property-based-testing)
  - [Qualification with 15 Tools](./part1/02_extreme_tdd.md#qualification)

- [CLI Development Basics](./part1/03_cli_basics.md)
  - [Argument Parsing](./part1/03_cli_basics.md#argument-parsing)
  - [Standard Input/Output](./part1/03_cli_basics.md#stdin-stdout)
  - [Error Handling](./part1/03_cli_basics.md#error-handling)
  - [Exit Codes](./part1/03_cli_basics.md#exit-codes)

# Part II: Building Unix Classics

- [Chapter 1: ruchy-cat](./part2/01_cat.md)
  - [Understanding cat](./part2/01_cat.md#understanding-cat)
  - [RED: First Test](./part2/01_cat.md#red-first-test)
  - [GREEN: Minimal Implementation](./part2/01_cat.md#green-minimal)
  - [REFACTOR: Clean Code](./part2/01_cat.md#refactor)
  - [MUTATION: Test Quality](./part2/01_cat.md#mutation)
  - [PROPERTY: Invariants](./part2/01_cat.md#property)
  - [QUALIFY: 15 Tools](./part2/01_cat.md#qualify)

- [Chapter 2: ruchy-grep](./part2/02_grep.md)
  - [Pattern Matching Basics](./part2/02_grep.md#pattern-matching)
  - [Regular Expressions in Ruchy](./part2/02_grep.md#regex)
  - [Building grep with TDD](./part2/02_grep.md#tdd-process)

- [Chapter 3: ruchy-wc](./part2/03_wc.md)
  - [Counting Lines, Words, Bytes](./part2/03_wc.md#counting)
  - [Unicode Handling](./part2/03_wc.md#unicode)
  - [Performance Optimization](./part2/03_wc.md#performance)

- [Chapter 4: ruchy-cut](./part2/04_cut.md)
  - [Field Extraction](./part2/04_cut.md#fields)
  - [Delimiter Handling](./part2/04_cut.md#delimiters)
  - [Range Specifications](./part2/04_cut.md#ranges)

- [Chapter 5: ruchy-sort](./part2/05_sort.md)
  - [Sorting Algorithms](./part2/05_sort.md#algorithms)
  - [Numeric vs Lexicographic](./part2/05_sort.md#sorting-modes)
  - [Stable Sorting](./part2/05_sort.md#stability)

- [Chapter 6: ruchy-uniq](./part2/06_uniq.md)
  - [Deduplication Logic](./part2/06_uniq.md#dedup)
  - [Counting Occurrences](./part2/06_uniq.md#counting)
  - [Case Sensitivity](./part2/06_uniq.md#case)

- [Chapter 7: ruchy-sed](./part2/07_sed.md)
  - [Stream Editing Basics](./part2/07_sed.md#basics)
  - [Substitution Patterns](./part2/07_sed.md#substitution)
  - [Advanced sed Features](./part2/07_sed.md#advanced)

- [Chapter 8: ruchy-head](./part2/08_head.md)
  - [Reading First N Lines](./part2/08_head.md#reading-lines)
  - [Byte-based Reading](./part2/08_head.md#bytes)
  - [Multiple File Handling](./part2/08_head.md#multiple-files)

- [Chapter 9: ruchy-tail](./part2/09_tail.md)
  - [Reading Last N Lines](./part2/09_tail.md#last-lines)
  - [Follow Mode (-f)](./part2/09_tail.md#follow)
  - [Efficient Algorithms](./part2/09_tail.md#efficiency)

- [Chapter 10: ruchy-jq](./part2/10_jq.md)
  - [JSON Parsing](./part2/10_jq.md#parsing)
  - [Query Language](./part2/10_jq.md#query-language)
  - [Transformations](./part2/10_jq.md#transformations)

# Part III: Advanced Topics

- [Testing Strategies](./part3/01_testing.md)
  - [Unit Testing](./part3/01_testing.md#unit-tests)
  - [Integration Testing](./part3/01_testing.md#integration-tests)
  - [CLI Testing with assert_cmd](./part3/01_testing.md#cli-testing)
  - [Interactive Testing with rexpect](./part3/01_testing.md#interactive-testing)

- [Mutation Testing Deep Dive](./part3/02_mutation.md)
  - [What is Mutation Testing?](./part3/02_mutation.md#what-is-mutation)
  - [Interpreting Mutation Scores](./part3/02_mutation.md#scores)
  - [Improving Test Quality](./part3/02_mutation.md#improving)

- [Property-Based Testing](./part3/03_property.md)
  - [Defining Properties](./part3/03_property.md#defining-properties)
  - [Generators and Shrinking](./part3/03_property.md#generators)
  - [Common Patterns](./part3/03_property.md#patterns)

- [Quality Gates](./part3/04_quality.md)
  - [Pre-commit Hooks](./part3/04_quality.md#pre-commit)
  - [CI/CD Pipeline](./part3/04_quality.md#ci-cd)
  - [Coverage Requirements](./part3/04_quality.md#coverage)
  - [Zero SATD Policy](./part3/04_quality.md#zero-satd)

- [Performance & Optimization](./part3/05_performance.md)
  - [Profiling CLI Tools](./part3/05_performance.md#profiling)
  - [Memory Management](./part3/05_performance.md#memory)
  - [I/O Optimization](./part3/05_performance.md#io)

# Part IV: The Toyota Way

- [Jidoka: Stop The Line](./part4/01_jidoka.md)
  - [Quality at the Source](./part4/01_jidoka.md#quality-at-source)
  - [Handling Language Bugs](./part4/01_jidoka.md#language-bugs)
  - [Bug Report Protocol](./part4/01_jidoka.md#bug-protocol)

- [Genchi Genbutsu: Go and See](./part4/02_genchi_genbutsu.md)
  - [Direct Observation](./part4/02_genchi_genbutsu.md#observation)
  - [Debugging Mindset](./part4/02_genchi_genbutsu.md#debugging)

- [Kaizen: Continuous Improvement](./part4/03_kaizen.md)
  - [Metrics Over Time](./part4/03_kaizen.md#metrics)
  - [Refactoring Strategy](./part4/03_kaizen.md#refactoring)
  - [Learning from Failures](./part4/03_kaizen.md#learning)

- [Respect for People](./part4/04_respect.md)
  - [Code Review Culture](./part4/04_respect.md#code-review)
  - [Documentation Standards](./part4/04_respect.md#documentation)
  - [Contributing to Open Source](./part4/04_respect.md#contributing)

# Appendices

- [Appendix A: Ruchy Language Reference](./appendix/a_language_reference.md)
  - [Syntax Overview](./appendix/a_language_reference.md#syntax)
  - [Standard Library](./appendix/a_language_reference.md#stdlib)
  - [The 15 Ruchy Tools](./appendix/a_language_reference.md#tools)

- [Appendix B: Unix Tool Reference](./appendix/b_unix_tools.md)
  - [cat](./appendix/b_unix_tools.md#cat)
  - [grep](./appendix/b_unix_tools.md#grep)
  - [wc, cut, sort, uniq, sed, head, tail, jq](./appendix/b_unix_tools.md#others)

- [Appendix C: Testing Patterns](./appendix/c_testing_patterns.md)
  - [RED Patterns](./appendix/c_testing_patterns.md#red)
  - [GREEN Patterns](./appendix/c_testing_patterns.md#green)
  - [REFACTOR Patterns](./appendix/c_testing_patterns.md#refactor)

- [Appendix D: Quality Metrics](./appendix/d_quality_metrics.md)
  - [Code Coverage](./appendix/d_quality_metrics.md#coverage)
  - [Mutation Scores](./appendix/d_quality_metrics.md#mutation)
  - [Complexity Metrics](./appendix/d_quality_metrics.md#complexity)
  - [SATD Analysis](./appendix/d_quality_metrics.md#satd)

- [Appendix E: Troubleshooting](./appendix/e_troubleshooting.md)
  - [Common Errors](./appendix/e_troubleshooting.md#errors)
  - [Build Issues](./appendix/e_troubleshooting.md#build)
  - [Test Failures](./appendix/e_troubleshooting.md#tests)

---

[Contributors](./contributors.md)
[References](./references.md)
