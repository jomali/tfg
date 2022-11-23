#! /bin/sh

#-------------------------------------------------------------------------------

limpia_ficheros_temporales() {
	rm *.aux
	rm *.bbl
	rm *.blg
	rm *.dvi
	rm *.lof
	rm *.log
	rm *.lot
	rm *.out
	rm *.toc
	rm ./chapters/*.aux
}

#-------------------------------------------------------------------------------

if [ "$1" != "" ]; then sourceFile=$1;
else
	echo -n "Introduce el nombre del archivo (sin la extensión): ";
	read sourceFile;
	echo " ";
fi
if [ ! -e "$sourceFile.tex" ]; then
	echo "El archivo '$sourceFile.tex' no existe.";
	exit 1;
fi

if [ "$2" != "" ]; then objectFile=$2;
else objectFile=$sourceFile
fi

latex $sourceFile.tex
bibtex $sourceFile.aux
pdflatex $sourceFile.tex
pdflatex $sourceFile.tex
limpia_ficheros_temporales

mv $sourceFile.pdf $objectFile.pdf
evince $objectFile.pdf &

exit 0;
