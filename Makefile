ROFFS = fqa0.roff \
        fqa1.roff

HTMLS = fqa0.html \
        fqa1.html

.SUFFIXES: .txt .roff .html

all: fqa.pdf ${HTMLS}

fqa.pdf: fqa.ps
	ps2pdf fqa.ps fqa.pdf

fqa.ps: mb.tmac fqa.roff index.roff
	troff -mpictures mb.tmac fqa.roff index.roff ${ROFFS} 2>/dev/null | dpost >fqa.ps

index.roff: index
	grep '^index:' index | sed 's/index://' >index.roff

index: ${ROFFS}
	troff -mpictures mb.tmac ${ROFFS} 2>index >/dev/null

.txt.roff:
	awk -f ./incipit $< >$@

.txt.html:
	awk -f ./incipit -v 'type=html' $< >$@

clean:
	-rm fqa.pdf fqa.ps index index.roff ${ROFFS} ${HTMLS}

.PHONY: clean
