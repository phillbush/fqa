SRCS  = fqa0.txt fqa1.txt
ROFFS = ${SRCS:.txt=.roff}
HTMLS = ${SRCS:.txt=.html}

.SUFFIXES: .txt .roff .html .ps .pdf

all: fqa.pdf ${HTMLS}

fqa.pdf: fqa.ps
	ps2pdf '-sPAPERSIZE=a4' fqa.ps fqa.pdf

fqa.ps: mb.tmac title.roff index.roff
	troff -mpictures mb.tmac fonts.roff title.roff index.roff ${ROFFS} 2>/dev/null | dpost >fqa.ps

index.roff: ${ROFFS}
	troff -mpictures mb.tmac fonts.roff ${ROFFS} 2>&1 >/dev/null | grep '^index:' | sed 's/index://' >index.roff

.txt.roff:
	awk -f ./incipit $< >$@

.txt.html:
	awk -f ./incipit -v 'type=html' $< >$@

clean:
	-rm fqa.pdf fqa.ps index.roff ${ROFFS} ${HTMLS}

.PHONY: clean
