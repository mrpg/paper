.PHONY: all

all:
	@if [ -f pre.sh ]; then ./pre.sh; fi
	@output=$$(pdflatex -interaction=nonstopmode main.tex 2>&1) || echo "$$output"; \
	echo "$$output" | grep -E "Reference.*undefined|Citation.*undefined|multiply" || true
	@output=$$(bibtex main 2>&1) || echo "$$output"
	@if [ -f post.sh ]; then ./post.sh; fi
