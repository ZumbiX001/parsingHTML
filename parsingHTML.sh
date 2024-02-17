#!/bin/bash
# Script para copiar a página inicial de um site e identificar subdominios
# no arquivo index.html
# modo de uso: /.parsingHTML.sh example.com.br
#

if [ "$1" == "" ]
then
	echo -e "\033[1;4;31m		ZumbiX\033[0m"
	echo -e "\033[1;31m	Usage:\033[0m"
	echo -e "\033[1;31m     Execution permission:\033[0m"
	echo -e "\033[1;31m     chmod +x parsingHTML.sh\033[0m"
	echo -e "\033[1;31m     Running Script: ./parsingHTML.sh target\033[0m"

else
	echo -e "\033[1;32m	(+): Running script on $1 \033[0m"
	outFile=$(echo "$1" | sed 's/\..*//')
	echo -e "\033[1;32m	(+): Downloading the frontpage of $1 \033[0m"
	wget -q $1 -O "$1"
	echo -e "\033[1;32m	(+): Aanalyzing the output file \033[0m"
	echo ""
	echo ""
	cat $1 | grep "href" | cut -d "/" -f 3 | grep "\." | cut -d '"' -f1 | grep -v "<li" > $1.txt
	rm $1
	for url in $(cat $1.txt); do host $url | grep "has address"; done > "$outFile.txt"
	rm $1.txt
	sed 's/^//' "$outFile.txt" | sed 's/has address//g' | column -t
fi
