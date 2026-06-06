# Makefile for LaTeX paper compilation
# Definiteness and Deitality

# Configuration
LATEX = xelatex
BIBER = biber
MAIN = Claude
ANON = Claude-anonymous
OUTDIR = .

# Targets
.PHONY: all anonymous clean distclean view help

# Default target: build the PDF
all: $(MAIN).pdf

# Anonymous build for journal submission review
anonymous: $(ANON).pdf

# Full build sequence with bibliography
$(MAIN).pdf: $(MAIN).tex preamble.tex references.bib references-local.bib
	@echo "==> First LaTeX pass..."
	$(LATEX) -interaction=nonstopmode -halt-on-error -output-directory=$(OUTDIR) $(MAIN).tex
	@echo "==> Running Biber..."
	$(BIBER) $(MAIN)
	@echo "==> Second LaTeX pass..."
	$(LATEX) -interaction=nonstopmode -halt-on-error -output-directory=$(OUTDIR) $(MAIN).tex
	@echo "==> Third LaTeX pass (finalizing)..."
	$(LATEX) -interaction=nonstopmode -halt-on-error -output-directory=$(OUTDIR) $(MAIN).tex
	@echo "==> Build complete: $(MAIN).pdf"

$(ANON).pdf: $(MAIN).tex preamble.tex references.bib references-local.bib
	@echo "==> First anonymous LaTeX pass..."
	$(LATEX) -interaction=nonstopmode -halt-on-error -jobname=$(ANON) -output-directory=$(OUTDIR) "\def\blindsubmission{1}\input{$(MAIN).tex}"
	@echo "==> Running Biber for anonymous build..."
	$(BIBER) $(ANON)
	@echo "==> Second anonymous LaTeX pass..."
	$(LATEX) -interaction=nonstopmode -halt-on-error -jobname=$(ANON) -output-directory=$(OUTDIR) "\def\blindsubmission{1}\input{$(MAIN).tex}"
	@echo "==> Third anonymous LaTeX pass (finalizing)..."
	$(LATEX) -interaction=nonstopmode -halt-on-error -jobname=$(ANON) -output-directory=$(OUTDIR) "\def\blindsubmission{1}\input{$(MAIN).tex}"
	@echo "==> Build complete: $(ANON).pdf"

# Quick build (single pass, no bibliography update)
quick: $(MAIN).tex
	@echo "==> Quick build (single pass)..."
	$(LATEX) -interaction=nonstopmode -halt-on-error -output-directory=$(OUTDIR) $(MAIN).tex

# Use LuaLaTeX instead of XeLaTeX
lualatex: LATEX = lualatex
lualatex: all

# Clean build artifacts (keep PDF)
clean:
	@echo "==> Cleaning build artifacts..."
	rm -f $(MAIN).aux $(MAIN).bbl $(MAIN).bcf $(MAIN).blg $(MAIN).log
	rm -f $(MAIN).out $(MAIN).run.xml $(MAIN).toc $(MAIN).fdb_latexmk
	rm -f $(MAIN).fls $(MAIN).synctex.gz $(MAIN).xdv
	rm -f $(ANON).aux $(ANON).bbl $(ANON).bcf $(ANON).blg $(ANON).log
	rm -f $(ANON).out $(ANON).run.xml $(ANON).toc $(ANON).fdb_latexmk
	rm -f $(ANON).fls $(ANON).synctex.gz $(ANON).xdv
	@echo "==> Clean complete"

# Clean everything including PDF
distclean: clean
	@echo "==> Removing PDF..."
	rm -f $(MAIN).pdf $(ANON).pdf
	@echo "==> Deep clean complete"

# Open PDF viewer (macOS)
view: $(MAIN).pdf
	@echo "==> Opening PDF..."
	open $(MAIN).pdf

# Show available targets
help:
	@echo "Available targets:"
	@echo "  make          - Build PDF with full bibliography (default)"
	@echo "  make anonymous - Build anonymous review PDF"
	@echo "  make quick    - Quick build (single pass, no bib update)"
	@echo "  make lualatex - Build using LuaLaTeX instead of XeLaTeX"
	@echo "  make clean    - Remove build artifacts (keep PDF)"
	@echo "  make distclean- Remove everything including PDF"
	@echo "  make view     - Open PDF (macOS only)"
	@echo "  make help     - Show this help message"
