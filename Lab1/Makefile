SHELL = /bin/bash

all:
	make lab1.pdf

%.pdf: %.tex
	pdflatex $<
	pdflatex $<
	make clean

clean:
	rm -f *.aux *.log *.out *.toc
