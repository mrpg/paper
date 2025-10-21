.PHONY: all

all:
	@output=$$(pdflatex -interaction=nonstopmode main.tex 2>&1) || echo "$$output"
	@output=$$(bibtex main 2>&1) || echo "$$output"
