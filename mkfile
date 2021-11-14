MKSHELL=rc
FILES=fqa.pdf

ROFFS= \
	fqa0.roff \
	fqa1.roff

HTMLS= \
	fqa0.html \
	fqa1.html

all:V: fqa.pdf $HTMLS

fqa.pdf:D: fqa.ps
	ps2pdf fqa.ps fqa.pdf

fqa.ps:D: fqa.roff index.roff
	troff -mpictures mb.tmac fqa.roff index.roff $ROFFS >[2]/dev/null | dpost >fqa.ps

index.roff: index
	grep '^index:' index | sed 's/index://' >index.roff

index:D: $ROFFS
	troff -mpictures mb.tmac $ROFFS >[2]index >/dev/null

%.roff:D: %.txt
	awk -f ./incipit $stem.txt >$target

%.html:D: %.txt
	awk -f ./incipit -v 'type=html' $stem.txt >$target

clean:V:
	rm fqa.pdf fqa.ps index index.roff $ROFFS $HTMLS
