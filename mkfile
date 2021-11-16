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
	ps2pdf '-sPAPERSIZE=a4' fqa.ps fqa.pdf

fqa.ps:D: title.roff index.roff
	troff -mpictures mb.tmac title.roff index.roff $ROFFS >[2]/dev/null | dpost >fqa.ps

index.roff:D: $ROFFS
	troff -mpictures mb.tmac $ROFFS >[2=1] >/dev/null | grep '^index:' | sed 's/index://' >index.roff

%.roff:D: %.txt
	awk -f ./incipit $stem.txt >$target

%.html:D: %.txt
	awk -f ./incipit -v 'type=html' $stem.txt >$target

clean:V:
	rm fqa.pdf fqa.ps index.roff $ROFFS $HTMLS
