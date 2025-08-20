# scripts
varios scripts

Retirara nombre de _comprimido
for file in *_comprimido.pdf; do mv "$file" "${file/_comprimido/}"; done

Solo empaquetar (sin comprimir)	tar -cf archivo.tar directorio/	~100 MB	2 seg
gzip	tar -czvf archivo.tar.gz directorio/	~40 MB	10 seg
bzip2	tar -cjvf archivo.tar.bz2 directorio/	~35 MB	30 seg
xz	    tar -cJvf archivo.tar.xz directorio/	~30 MB	2 min

