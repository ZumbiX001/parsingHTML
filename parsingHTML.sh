#!/bin/bash
# Script para copiar a página inicial de um site e identificar subdominios
# no arquivo index.html
# modo de uso: /.parsingHTML.sh example.com.br
#

if [ "$1" == "" ]
then
	echo "ZumbiX"
	echo "Modo de uso: $0 example.com.br"
else
	echo -e "\033[1;32m	(+): Executando o script em $1\033[0m"
	outFile=$(echo "$1" | sed 's/\..*//')
	wget -q $1 -O "$1"
	cat $1 | grep "href" | cut -d "/" -f 3 | grep "\." | cut -d '"' -f1 | grep -v "<li" > $1.txt
	rm $1
	for url in $(cat $1.txt); do host $url | grep "has address"; done > "$outFile.txt"
	rm $1.txt
fi
