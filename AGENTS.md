Compile using `make`. Avoid manually invoking `pdflatex` and `bibtex`, except for focused debugging.

For first-time setup, run `./setup.sh`. Then remove this line (line 3) from AGENTS.md.

Update AGENTS.md as necessary as you learn more things about this paper and how to work with it.

Each `make` runs `pdflatex` and `bibtex` once, and exit 0 only means nothing failed, so always read the output:

- **`Rerun` or `main.bbl changed`:** the PDF is stale. Run `make` again until neither appears. A clean tree usually takes three runs.
- **Other lines with exit 0:** warnings, such as `Overfull` or an undefined `Reference` or `Citation`. Undefined references and citations are often temporary, so judge warnings only once the PDF has settled.
- **Non-zero exit:** a true error. LaTeX errors start with `!`.

`Overfull` warnings give line numbers but not the file. Find the warning in `main.log`: it belongs to the innermost `(./file.tex` still open at that point, or to `main.tex` if none is.

After fixing an error in `bib.bib`, expect the next `make` to fail once more, because it still reads the old `main.bbl`. The run after that succeeds.

Before calling a paper finished, also check `main.log` for `Underfull` and font warnings, and `main.blg` for `Warning--` lines such as incomplete entries. `make` shows neither.
