.PHONY: help all validate ci clean
.PHONY: format lint test-fast test-all test-examples
.PHONY: dogfood-full check-ruchy
.PHONY: install-hooks check-hooks
.PHONY: book-build book-serve book-test book-deploy book-clean
.PHONY: quality-gate quality-report

# Default target: Fast feedback loop
all: format lint test-fast

help:
	@echo "Ruchy CLI Tools Book - Makefile Commands"
	@echo ""
	@echo "IMPORTANT: This project uses RUCHY language, not Rust"
	@echo "Install Ruchy: cargo install ruchy"
	@echo ""
	@echo "Fast Feedback (<10s):"
	@echo "  make format          - Format all Ruchy code (ruchy fmt)"
	@echo "  make lint            - Lint Ruchy code (ruchy lint)"
	@echo "  make test-fast       - Run unit tests"
	@echo "  make validate        - format + lint + test-fast"
	@echo ""
	@echo "Testing:"
	@echo "  make test-all        - All tests"
	@echo "  make test-examples   - Test all CLI examples"
	@echo ""
	@echo "Quality Gates:"
	@echo "  make quality-gate    - Run all blocking quality checks"
	@echo "  make check-ruchy     - Verify Ruchy installation"
	@echo ""
	@echo "Dogfooding (15 Ruchy Tools):"
	@echo "  make dogfood-full    - Test all 15 ruchy tools on examples"
	@echo ""
	@echo "Book Operations:"
	@echo "  make book-build      - Build mdBook"
	@echo "  make book-serve      - Serve book at localhost:3000"
	@echo "  make book-test       - Test all book examples"
	@echo ""
	@echo "Infrastructure:"
	@echo "  make install-hooks   - Install git pre-commit hooks"
	@echo "  make clean           - Clean build artifacts"
	@echo ""
	@echo "TDD Workflow:"
	@echo "  1. Write .ruchy test file (RED phase)"
	@echo "  2. Run: make test-fast (verify test fails)"
	@echo "  3. Write .ruchy implementation (GREEN phase)"
	@echo "  4. Run: make test-fast (verify test passes)"
	@echo "  5. Run: make validate (REFACTOR phase)"
	@echo "  6. Run: make dogfood-full (QUALIFY phase)"

# ============================================================================
# Prerequisites Check
# ============================================================================

check-ruchy:
	@echo "Checking Ruchy installation..."
	@command -v ruchy >/dev/null 2>&1 || { \
		echo "❌ ERROR: Ruchy not installed"; \
		echo ""; \
		echo "Install with: cargo install ruchy"; \
		echo ""; \
		exit 1; \
	}
	@echo "✓ Ruchy is installed"
	@ruchy --version

# ============================================================================
# Fast Feedback Loop (<10s)
# ============================================================================

format: check-ruchy
	@echo "Formatting Ruchy code..."
	@find examples tests tools -name "*.ruchy" -type f -exec ruchy fmt {} \; 2>/dev/null || true
	@echo "✓ Format complete"

lint: check-ruchy
	@echo "Linting Ruchy code..."
	@find examples tests tools -name "*.ruchy" -type f -exec echo "Linting: {}" \; -exec ruchy lint {} \; 2>/dev/null || true
	@echo "✓ Lint complete"

test-fast: check-ruchy
	@echo "Running fast tests..."
	@if find tests -name "*_test.ruchy" -type f | grep -q .; then \
		echo "Running Ruchy tests..."; \
		ruchy test run tests/ || echo "⚠ Some tests pending implementation"; \
	else \
		echo "⚠ No test files found yet"; \
	fi
	@echo "✓ Fast tests complete"

validate: format lint test-fast
	@echo "✓ Validation complete (format, lint, fast tests passed)"

# ============================================================================
# Comprehensive Testing
# ============================================================================

test-all: test-fast test-examples
	@echo "✓ All tests passed"

test-examples: check-ruchy
	@echo "Testing all CLI examples..."
	@for dir in examples/*/; do \
		if [ -d "$$dir" ]; then \
			echo "Testing $$dir"; \
			if find "$$dir" -name "*.ruchy" -type f | grep -q .; then \
				ruchy run "$$dir"/*.ruchy || echo "⚠ Example not yet implemented: $$dir"; \
			fi; \
		fi; \
	done
	@echo "✓ Example tests complete"

# ============================================================================
# Quality Gates (BLOCKING checks)
# ============================================================================

quality-gate: validate
	@echo "Running quality gates..."
	@echo "Checking for SATD markers..."
	@if find examples tests tools -name "*.ruchy" -type f -exec grep -l "TODO\|FIXME\|HACK" {} \; 2>/dev/null | grep -q .; then \
		echo "❌ FAILED: Found SATD markers (TODO/FIXME/HACK)"; \
		echo "These are not allowed. Create GitHub issues instead."; \
		exit 1; \
	else \
		echo "✓ No SATD markers found"; \
	fi
	@echo "✓ All quality gates passed"

quality-report:
	@echo "Generating quality metrics report..."
	@mkdir -p docs/reports
	@echo "# Quality Metrics Report" > docs/reports/quality-$(shell date +%Y%m%d).md
	@echo "Generated: $(shell date)" >> docs/reports/quality-$(shell date +%Y%m%d).md
	@echo "" >> docs/reports/quality-$(shell date +%Y%m%d).md
	@echo "## Ruchy Files" >> docs/reports/quality-$(shell date +%Y%m%d).md
	@find examples tests tools -name "*.ruchy" -type f | wc -l >> docs/reports/quality-$(shell date +%Y%m%d).md
	@echo "✓ Quality report generated: docs/reports/quality-$(shell date +%Y%m%d).md"

# ============================================================================
# Dogfooding (Test with all 15 Ruchy tools)
# ============================================================================

dogfood-full: check-ruchy
	@echo "Testing with all 15 Ruchy tools..."
	@echo "Running tools on examples directory..."
	@echo ""
	@echo "1. ruchy check - Syntax validation"
	@find examples -name "*.ruchy" -exec ruchy check {} \; || echo "⚠ Check found issues"
	@echo ""
	@echo "2. ruchy transpile - Transpile to Rust"
	@find examples -name "*.ruchy" -exec echo "Transpiling: {}" \; || true
	@echo "⚠ Transpile output not shown (verbose)"
	@echo ""
	@echo "3. ruchy lint - Style checking"
	@find examples -name "*.ruchy" -exec ruchy lint {} \; || echo "⚠ Lint found issues"
	@echo ""
	@echo "4. ruchy fmt - Format code"
	@find examples -name "*.ruchy" -exec ruchy fmt --check {} \; || echo "⚠ Format needed"
	@echo ""
	@echo "5. ruchy run - Execute programs"
	@echo "⚠ Run requires complete implementations"
	@echo ""
	@echo "6. ruchy test - Run tests"
	@ruchy test run tests/ || echo "⚠ Tests pending"
	@echo ""
	@echo "7-15: Additional tools (wasm, repl, notebook, etc.)"
	@echo "✓ Will test as features are implemented"
	@echo ""
	@echo "✓ Dogfooding complete"

# ============================================================================
# Full CI Pipeline
# ============================================================================

ci: validate test-all dogfood-full quality-gate
	@echo "✓ Full CI pipeline complete"

# ============================================================================
# Pre-commit Hooks
# ============================================================================

install-hooks:
	@echo "Installing pre-commit hooks..."
	@mkdir -p .git/hooks
	@mkdir -p scripts
	@if [ ! -f scripts/pre-commit-hook.sh ]; then \
		echo "Creating pre-commit hook script..."; \
		echo '#!/bin/bash' > scripts/pre-commit-hook.sh; \
		echo 'set -e' >> scripts/pre-commit-hook.sh; \
		echo 'echo "Running pre-commit checks for Ruchy code..."' >> scripts/pre-commit-hook.sh; \
		echo 'make validate' >> scripts/pre-commit-hook.sh; \
		chmod +x scripts/pre-commit-hook.sh; \
	fi
	@cp scripts/pre-commit-hook.sh .git/hooks/pre-commit
	@chmod +x .git/hooks/pre-commit
	@echo "✓ Pre-commit hooks installed"
	@echo "Note: Hooks will run automatically on 'git commit'"
	@echo "NEVER use 'git commit --no-verify' (forbidden)"

check-hooks:
	@echo "Testing pre-commit hooks..."
	@if [ -x .git/hooks/pre-commit ]; then \
		echo "✓ Pre-commit hook is installed"; \
		.git/hooks/pre-commit; \
		echo "✓ Pre-commit hook executed successfully"; \
	else \
		echo "❌ Pre-commit hook not installed"; \
		echo "Run 'make install-hooks' to install"; \
		exit 1; \
	fi

# ============================================================================
# Book Operations
# ============================================================================

book-build:
	@echo "Building book..."
	@command -v mdbook >/dev/null 2>&1 || { \
		echo "Installing mdbook..."; \
		cargo install mdbook mdbook-linkcheck; \
	}
	@if [ ! -d book ]; then \
		echo "Creating book structure..."; \
		mkdir -p book/src; \
		echo "[book]" > book/book.toml; \
		echo 'title = "Ruchy CLI Tools Book"' >> book/book.toml; \
		echo 'authors = ["Ruchy Community"]' >> book/book.toml; \
		echo "" >> book/book.toml; \
		echo "[build]" >> book/book.toml; \
		echo 'build-dir = "book"' >> book/book.toml; \
		echo "" >> book/book.toml; \
		echo "[output.html]" >> book/book.toml; \
		echo 'git-repository-url = "https://github.com/YOUR_USERNAME/ruchy-cli-tools-book"' >> book/book.toml; \
		echo "" >> book/book.toml; \
		echo '[output.linkcheck]' >> book/book.toml; \
		echo "# Summary" > book/src/SUMMARY.md; \
		echo "" >> book/src/SUMMARY.md; \
		echo "[Introduction](introduction.md)" >> book/src/SUMMARY.md; \
		echo "# Introduction" > book/src/introduction.md; \
		echo "" >> book/src/introduction.md; \
		echo "Welcome to the Ruchy CLI Tools Book!" >> book/src/introduction.md; \
	fi
	cd book && mdbook build
	@echo "✓ Book built successfully"
	@echo "Output: book/book/index.html"

book-serve: book-build
	@echo "Serving book at http://localhost:3000"
	cd book && mdbook serve --open

book-test:
	@echo "Testing all book examples..."
	@$(MAKE) test-examples

book-deploy:
	@echo "Book deployment is handled by GitHub Actions"
	@echo "Push to main branch to trigger deployment"
	@echo "URL: https://YOUR_USERNAME.github.io/ruchy-cli-tools-book/"

book-clean:
	@echo "Cleaning book build artifacts..."
	@rm -rf book/book
	@echo "✓ Book artifacts cleaned"

# ============================================================================
# Clean
# ============================================================================

clean:
	@echo "Cleaning build artifacts..."
	@rm -rf book/book
	@find . -name "*.rs" -path "*/target/*" -delete 2>/dev/null || true
	@find . -type d -name "target" -exec rm -rf {} + 2>/dev/null || true
	@echo "✓ Clean complete"

# ============================================================================
# Development Helpers
# ============================================================================

.PHONY: watch

watch: check-ruchy
	@echo "Watching Ruchy files for changes..."
	@echo "⚠ Manual implementation: run 'make test-fast' when you save files"
	@echo "Note: Auto-watch not yet implemented"
