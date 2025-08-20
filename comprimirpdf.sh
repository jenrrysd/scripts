#!/bin/bash
#

read -p "Ingresa el nombre del pdf: " input_pdf

input_pdf=$(echo "$input_pdf" | tr -d "'\"")

# Nombre para el archivo comprimido (añadimos "_comprimido")
output_pdf="${input_pdf%.pdf}_comprimido.pdf"

gs -sDEVICE=pdfwrite \
   -dCompatibilityLevel=1.4 \
   -dPDFSETTINGS=/ebook \
   -dNOPAUSE \
   -dQUIET \
   -dBATCH \
   -sOutputFile="${output_pdf}" \
   "$input_pdf"

# Verificar si la compresión fue exitosa
if [ -f "$output_pdf" ]; then
	if [ $(stat -c%s "$output_pdf") -lt 100 ]; then
		echo "PDF creado pero con paginas vacías"
	else
		echo "PDF comprimido con exito: '$output_pdf'"
	fi
else
	echo "falló"
fi

