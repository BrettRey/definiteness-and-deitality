# Definiteness and Deitality in English

This repository contains Brett Reynolds's paper **Definiteness and Deitality in English: A Projectibility-First Account**.

## Canonical draft

- `Claude.tex` is the current paper.

## Project files

- `Claude.tex` — canonical paper draft
- `Claude.pdf` — current compiled PDF
- `preamble.tex` — local LaTeX preamble
- `references.bib` — self-contained bibliography for cited sources
- `references-local.bib` — anonymous-review placeholder entries
- `Makefile` — build targets

## Build

The intended canonical build is:

```bash
xelatex Claude.tex
biber Claude
xelatex Claude.tex
xelatex Claude.tex
```

The anonymous review build is:

```bash
make anonymous
```

Current caveats:

- `Makefile` targets `Claude.tex` and uses XeLaTeX by default.
- `xelatex Claude.tex` currently succeeds locally.
- `make anonymous` builds `Claude-anonymous.pdf` for blind review.
- `lualatex Claude.tex` may still fail with an `xcolor` option clash caused by package load order.

## License

The manuscript, source files, and compiled PDF are licensed under the Creative Commons Attribution 4.0 International License (CC BY 4.0). See `LICENSE`.

## Current status

The paper exists as a LingBuzz preprint (`009369`) and is being revised for *Journal of Linguistics*.
