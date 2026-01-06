# Makefile for XeLaTeX resumes (Friggeri-style fonts/colors)
# Usage:
#   make
#   make MAIN=resume.tex
#   make watch MAIN=cv.tex
#   make clean

TEX     := xelatex
MAIN    ?= yuefei_resume.tex        # <-- overridable
OUTDIR  := build
JOBNAME := $(basename $(notdir $(MAIN)))
PDF     := $(JOBNAME).pdf

# Dependencies (extend if needed)
DEPS := $(MAIN) friggeri_sourabh_theme.sty
# DEPS += $(wildcard fonts/*)

.PHONY: all pdf clean distclean watch

all: pdf

pdf: $(PDF)

$(PDF): $(DEPS)
	@mkdir -p $(OUTDIR)
	$(TEX) -interaction=nonstopmode -halt-on-error \
		-output-directory=$(OUTDIR) -jobname=$(JOBNAME) $(MAIN)
	$(TEX) -interaction=nonstopmode -halt-on-error \
		-output-directory=$(OUTDIR) -jobname=$(JOBNAME) $(MAIN)
	@cp $(OUTDIR)/$(JOBNAME).pdf $(PDF)
	@echo "Built: $(PDF)"

clean:
	@rm -rf $(OUTDIR)
	@rm -f *.aux *.log *.out *.toc *.fls *.fdb_latexmk *.synctex.gz

distclean: clean
	@rm -f $(PDF)

# Live rebuild (requires latexmk)
watch:
	@mkdir -p $(OUTDIR)
	latexmk -xelatex -interaction=nonstopmode -halt-on-error \
		-outdir=$(OUTDIR) -jobname=$(JOBNAME) -pdf -pvc $(MAIN)
