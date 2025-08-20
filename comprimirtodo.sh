#!/bin/bash

echo "Selecciona nivel de compresión:"
echo "1) Alta calidad (menos compresión)"
echo "2) Balanceado"
echo "3) Máxima compresión (menor calidad)"
read -p "Opción [2]: " nivel

case $nivel in
    1) 
        PDFSETTINGS="/printer"
        RESOLUTION="300"
        ;;
    3)
        PDFSETTINGS="/screen"
        RESOLUTION="72"
        ;;
    *)
        PDFSETTINGS="/ebook"
        RESOLUTION="150"
        ;;
esac

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


