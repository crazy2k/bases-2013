all: informe.pdf clear-logs

new: clear all

informe.pdf: informe.tex
	pdflatex informe.tex
	pdflatex informe.tex	
	clear
	evince informe.pdf &
	
clear-logs: 
	rm -f *.aux *.log *.nav *.out *.toc *.vrb *.snm *.idx	

clear:
	rm -f informe.pdf	
