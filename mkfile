FILES=fqa.pdf

ROFFS= \
	fqa0.roff

HTMLS= \
	fqa0.html

fqa.pdf:D: fqa.ps
	ps2pdf fqa.ps fqa.pdf

fqa.ps:D: $ROFFS
	troff -mpictures mb.tmac $ROFFS | dpost >fqa.ps

%.roff:D: %.txt
	awk -f ./incipit $stem.txt >$target

%.html:D: %.txt
	awk -f ./incipit -v 'type=html' $stem.txt >$target

clean:VQ:
	rm fqa.pdf fqa.ps $ROFFS $HTMLS
