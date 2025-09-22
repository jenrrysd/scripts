#!/bin/bash

# este script comprime o reduce el tamaño del pdf
# con tan solo correrlo

PDFSETTINGS="/ebook"
RESOLUTION="150"

mkdir -p "comprimidos"

for input_pdf in *.pdf; do
    [ -f "$input_pdf" ] || continue
    
    output_pdf="comprimidos/${input_pdf%.pdf}_comprimido.pdf"
    
    echo "Comprimiendo: $input_pdf (nivel: $PDFSETTINGS) ..."
    
    gs -sDEVICE=pdfwrite \
       -dCompatibilityLevel=1.4 \
       -dPDFSETTINGS=$PDFSETTINGS \
       -dDownsampleColorImages=true \
       -dColorImageResolution=$RESOLUTION \
       -dDownsampleGrayImages=true \
       -dGrayImageResolution=$RESOLUTION \
       -dDownsampleMonoImages=true \
       -dMonoImageResolution=$RESOLUTION \
       -dAutoRotatePages=/None \
       -dNOPAUSE \
       -dQUIET \
       -dBATCH \
       -sOutputFile="$output_pdf" \
       "$input_pdf" 2>/dev/null
    
    [ -f "$output_pdf" ] && echo "  ✅ Listo: $output_pdf" || echo "  ❌ Falló: $input_pdf"
done

echo " "
echo "Empaquetando"
tar -czf comprimidos.tar.gz comprimidos/
echo "--Listo--"

# nota para ver sin extraer.
# tar -tzf comprimidos.tar.gz
#
# para extraer archivos comprimidos.
# tar -xzf comprimidos.tar.gz
#
# creado por Jenrry Soto Dextre
# Web: https://dextre.xyz
# correo: jsd@dextre.org
#
