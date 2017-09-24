# "Automating the Build of your Technical Presentation" -- The Template

This is a template for technical presentations written in Markdown, generating
PDF output using [Pandoc][] and [Beamer][]. Source code snippets are included
using [pandoc-include-code][]. Diagrams are generated using [Graphviz][] and/or
[PlantUML].

## Samples

* [With Notes (Presenter PDF)](https://wickstrom.tech/assets/slides.pdf)
* [Without Notes (Handout)](https://wickstrom.tech/assets/slides-no-notes.pdf)

## Requirements

* A LaTeX distribution, e.g. [TeX Live](https://www.tug.org/texlive/) or
  [MacTeX](http://www.tug.org/mactex/).
* [Graphviz][]
* [Pandoc][] (version 2.0)
* [pandoc-include-code][]
* [Oracle JRE/JDK](http://www.oracle.com/technetwork/java/javase/downloads/index.html)

All the above dependencies' executables need to be on your PATH.

## Usage

1. Download this repository as a ZIP file, or clone it with git, and start
   hacking away at your own presentation!
2. Write your slides in `src/slides.md`. There's a number of examples on how
   you can include content and write notes in the existing file.
3. Add Graphviz diagrams to `src/uml/*.uml.txt` and PlantUML diagrams to
   `src/uml/*.uml.txt`. There are some examples provided that you can modify
   or remove.

## Build

Make slide handouts and slides with notes:

```
make slides
```

Start [pdfpc][] presenter:

```
make present
```

## License

[Mozilla Public License Version 2.0](LICENSE)

[Pandoc]: https://pandoc.org
[Beamer]: https://en.wikipedia.org/wiki/Beamer_(LaTeX)
[pandoc-include-code]: https://github.com/owickstrom/pandoc-include-code
[Graphviz]: http://graphviz.org
[PlantUML]: http://plantuml.com
[pdfpc]: https://pdfpc.github.io
