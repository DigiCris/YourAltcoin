#!/bin/sh

coma=''
guardar=''

for line in $(cat listaIn.txt)
do 
	guardar1=$(perl ip.perl "$line")
	guardar="$guardar$coma$guardar1"
	coma=','
done

echo $guardar >listaOut.txt
exit
