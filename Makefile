.PHONY: all clean

all:
	@if [ -f pre.sh ]; then ./pre.sh; fi
	@output=$$(max_print_line=10000 pdflatex -interaction=nonstopmode main.tex 2>&1); latex=$$?; \
	if [ $$latex -ne 0 ]; then printf '%s\n' "$$output"; else \
		printf '%s\n' "$$output" | LC_ALL=C grep -aE "Reference.*undefined|Citation.*undefined|multiply|Overfull|Rerun"; \
		[ $$? -le 1 ] || exit 1; \
	fi; \
	before=$$(cksum main.bbl 2>/dev/null); \
	output=$$(bibtex main 2>&1); code=$$?; \
	if [ $$code -ne 0 ]; then \
		printf '%s\n' "$$output"; \
		case "$$code:$$output" in 2:*'I found no \citation commands'*'(There was 1 error message)') ;; *) exit $$code ;; esac; \
	fi; \
	[ "$$before" = "$$(cksum main.bbl 2>/dev/null)" ] || echo "main.bbl changed: run make again to update the PDF"; \
	exit $$latex
	@if [ -f post.sh ]; then ./post.sh; fi

clean:
	rm -f main.aux main.bbl main.blg main.log main.out main.pdf main.loc main.soc
