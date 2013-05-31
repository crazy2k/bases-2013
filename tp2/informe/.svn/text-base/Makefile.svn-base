DEPS = intro.tex conclusiones.tex decisiones.tex implementacion.tex

all: informe.pdf clean-logs

new: clean all

informe.pdf: informe.tex $(DEPS)
	pdflatex informe.tex
	pdflatex informe.tex	
	clear
	evince informe.pdf &
	
clean-logs: 
	rm -f *.aux *.log *.nav *.out *.toc *.vrb *.snm *.idx	

clean: clean-logs
	rm -f informe.pdf	
