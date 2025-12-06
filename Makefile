.PHONY: all

all:
	@output=$$(pdflatex -interaction=nonstopmode main.tex 2>&1) || echo "$$output"; \
	echo "$$output" | grep -E "Reference.*undefined|multiply" || true
	@output=$$(bibtex main 2>&1) || echo "$$output"
