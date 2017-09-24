# "Automating the Build of your Technical Presentation" -- The Template
#
# Written by: Oskar Wickström (https://wickstrom.tech)
# Hosted at: https://github.com/owickstrom/automating-the-build-of-your-technical-presentation-template
# License: Mozilla Public License Version 2.0

TEX=pdflatex
PLANTUML=deps/plantuml.jar

OTHER_SRCS=$(shell find src -name '*.tex') \
					 $(shell find src/listings) \
					 $(shell find src/diagrams)

PANDOC_FLAGS= -t beamer \
							-s \
							-H src/customizations.tex \
							--highlight-style=pygments \
							--slide-level=2 \
							--filter pandoc-include-code

PRG_SRCS=$(shell find src/listings -name '*.c')
PRGS=$(PRG_SRCS:src/listings/%.c=target/bin/%)

DIAGRAM_SRCS=$(shell find src/diagrams -name '*.dot')
DIAGRAMS=$(DIAGRAM_SRCS:src/diagrams/%.dot=target/diagrams/%.png)

UML_SRCS=$(shell find src/uml -name '*.uml.txt')
UMLS=$(UML_SRCS:src/uml/%.uml.txt=target/uml/%.png)

SLIDES_DIR=target/slides
SLIDES=$(SLIDES_DIR)/slides.pdf

SLIDES_NO_NOTES_DIR=target/slides-no-notes
SLIDES_NO_NOTES=$(SLIDES_NO_NOTES_DIR)/slides-no-notes.pdf

.PHONY: all
all: slides programs diagrams

.PHONY: slides
slides: $(SLIDES) $(SLIDES_NO_NOTES)

target/slides.tex: src/slides.md $(OTHER_SRCS) diagrams
	mkdir -p $(shell dirname $@)
	pandoc $(PANDOC_FLAGS) -H src/notes.tex $< -o $@

target/slides-no-notes.tex: src/slides.md $(OTHER_SRCS) diagrams
	mkdir -p $(shell dirname $@)
	pandoc $(PANDOC_FLAGS) -V classoption=handout $< -o $@

$(SLIDES): target/slides.tex
	rm -rf $(SLIDES_DIR)
	mkdir -p $(SLIDES_DIR)
	cp target/slides.tex $(SLIDES_DIR)/slides.tex
	cd $(SLIDES_DIR) && \
		$(TEX) \
		-jobname slides \
		-halt-on-error \
		slides.tex

$(SLIDES_NO_NOTES): target/slides-no-notes.tex
	rm -rf $(SLIDES_NO_NOTES_DIR)
	mkdir -p $(SLIDES_NO_NOTES_DIR)
	cp target/slides-no-notes.tex $(SLIDES_NO_NOTES_DIR)/slides.tex
	cd $(SLIDES_NO_NOTES_DIR) && \
		$(TEX) \
		-jobname slides-no-notes \
		-halt-on-error \
		slides.tex

target/bin/%: src/listings/%.c
	mkdir -p $(shell dirname $@)
	rm -f $@
	$(CC) -I src/listings $< -o $@

programs: $(PRGS)

target/diagrams/%.png: src/diagrams/%.dot
	mkdir -p $(shell dirname $@)
	dot -Tpng $< -o $@

target/uml/%.png: src/uml/%.uml.txt src/uml/styles.iuml $(PLANTUML)
	mkdir -p $(shell dirname $@)
	cat $< | java -jar $(PLANTUML) -DPLANTUML_LIMIT_SIZE=8192 -tpng -pipe > $@

.PHONY: diagrams
diagrams: $(DIAGRAMS) $(UMLS)

$(PLANTUML):
	mkdir -p $(shell dirname $@)
	wget http://sourceforge.net/projects/plantuml/files/plantuml.jar/download -O $@

.PHONY: present
present: $(SLIDES)
	pdfpc \
		--notes=right \
		--disable-auto-grouping \
		$(SLIDES)

.PHONY: clean
clean:
	rm -rf target
