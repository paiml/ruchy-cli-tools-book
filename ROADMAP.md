# Ruchy CLI Tools Book - Roadmap

## Completed Chapters

### Part I: Foundations
- ✅ Chapter 1: Getting Started with Ruchy
- ✅ Chapter 2: EXTREME TDD Philosophy
- ✅ Chapter 3: CLI Development Basics

### Part II: Building Unix Classics
- ✅ Chapter 1: ruchy-cat (328 lines)
- ✅ Chapter 2: ruchy-grep (343 lines)
- ✅ Chapter 3: ruchy-wc (380 lines)
- ✅ Chapter 4: ruchy-head (460 lines)

### Part III: Advanced Topics
- ✅ Testing Strategies
- ✅ Mutation Testing Deep Dive
- ✅ Property-Based Testing
- ✅ Quality Gates
- ✅ Performance & Optimization

### Part IV: The Toyota Way
- ✅ Jidoka: Stop The Line
- ✅ Genchi Genbutsu: Go and See
- ✅ Kaizen: Continuous Improvement
- ✅ Respect for People

### Appendices
- ✅ Appendix A: Ruchy Language Reference
- ✅ Appendix B: Unix Tool Reference
- ✅ Appendix C: Testing Patterns
- ✅ Appendix D: Quality Metrics
- ✅ Appendix E: Troubleshooting

## Planned Chapters (Part II: Building Unix Classics)

The following Unix tool implementations are planned for future releases:

### Text Processing & Transformation
- **ruchy-cut** - Extract columns/fields from text
  - Field extraction with delimiters
  - Character/byte position selection
  - Multiple field ranges
  - EXTREME TDD: Mutation testing for boundary conditions

- **ruchy-sed** - Stream editor for text transformation
  - Pattern matching and replacement
  - Line addressing and ranges
  - Multiple commands and scripts
  - EXTREME TDD: Property-based testing for transformations

### Data Operations
- **ruchy-sort** - Sort lines of text
  - Multiple sort keys
  - Numeric vs alphabetic sorting
  - Reverse sorting
  - EXTREME TDD: Property-based testing for sort invariants

- **ruchy-uniq** - Report or filter repeated lines
  - Count occurrences
  - Skip fields/characters
  - Case-insensitive comparison
  - EXTREME TDD: Mutation testing for edge cases

- **ruchy-tail** - Output the last part of files
  - Follow mode (-f)
  - Byte vs line mode
  - Multiple file handling
  - EXTREME TDD: Testing concurrent file monitoring

### Advanced Tools
- **ruchy-jq** - JSON processor (simplified subset)
  - JSON parsing and querying
  - Filter expressions
  - Data transformations
  - EXTREME TDD: Property-based testing for JSON roundtrips

## Implementation Philosophy

Each planned chapter will follow the **EXTREME TDD** methodology:

1. **RED**: Write failing tests first
2. **GREEN**: Minimal implementation to pass
3. **REFACTOR**: Clean up code while maintaining tests
4. **MUTATION**: Verify test quality with mutation testing (85%+ kill rate)
5. **PROPERTY**: Add property-based tests for invariants
6. **QUALIFY**: Run all 15 quality tools before integration

### Quality Standards
- Minimum 85% test coverage
- Minimum 85% mutation test score
- Zero linter warnings
- Zero security vulnerabilities
- Complete type annotations
- Comprehensive documentation

## Contributing

Want to help write one of these chapters? Each chapter should:

1. Document the **actual development journey** including:
   - Real bugs encountered
   - Stop The Line events when quality drops
   - Complete RED-GREEN-REFACTOR-PROPERTY-QUALIFY cycle

2. Follow the **Toyota Way principles**:
   - **Jidoka**: Stop when quality drops below 85%
   - **Genchi Genbutsu**: Show real terminal output and test results
   - **Kaizen**: Document continuous improvement iterations
   - **Respect**: Explain decisions clearly for future maintainers

3. Provide **working code** that readers can run and learn from

4. Include **complete test suites** demonstrating EXTREME TDD

## Timeline

Chapters will be added as they are completed to production quality standards. We do not publish placeholder or incomplete chapters ("no vaporware").

Each chapter takes approximately:
- 2-4 weeks for initial implementation
- 1 week for EXTREME TDD refinement
- 1 week for documentation and polish
- **Total: 4-6 weeks per chapter**

## Status

Last updated: 2025-10-15
Completed chapters: 4/10 Part II chapters (40%)
